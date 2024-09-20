import 'package:app_clone/src/domain/databases/remote_config_dao.dart';
import 'package:app_clone/src/utils/extension_utils.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';

class RemoteConfigRepository
{
  static RemoteConfigRepository? instance;

  final FirebaseRemoteConfig _remoteConfig;
  final RemoteConfigDao _remoteConfigDao;

  RemoteConfigRepository(this._remoteConfigDao, {required FirebaseRemoteConfig remoteConfig}) : _remoteConfig = remoteConfig ?? FirebaseRemoteConfig.instance;

  Future<void> getAndUpdateConfig() async
  {
    final configData =   _remoteConfig.getAll();
    await _remoteConfigDao.addConfig(configData);
  }

  Future<dynamic> getConfigValue(String key) async
  {
    final configData = await _remoteConfigDao.getConfig();
    final fromHive = configData[key]['value'];
    debugPrint("_fromHive ${configData[key]['value']}");
    return uTFToValue(fromHive);
  }
  Future<void> initializeFirebaseAndRemoteConfig() async {
    await _remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(seconds: 10),
      minimumFetchInterval: const Duration(hours: 1),
    ));
    await _remoteConfig.setDefaults(<String, dynamic>{
      'welcome_message': 'Welcome to my app!',
    });
    await _remoteConfig.fetchAndActivate();
  }
}