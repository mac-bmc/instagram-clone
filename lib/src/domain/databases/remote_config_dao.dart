import 'dart:convert';

import 'package:app_clone/src/utils/extension_utils.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class RemoteConfigDao
{
  Future<Box> _getConfigHive() async
  {
    return await Hive.openBox("config");
  }

  Future<void> addConfig(Map<String,dynamic> configData) async
  {
    debugPrint("ADDED__CONFIG ${configData}");
    final box = await _getConfigHive();
    await box.put("configData",jsonEncode(configDataToJson(configData)));

  }
  Future<Map<String,dynamic>> getConfig() async
  {
    final box = await _getConfigHive();
    debugPrint("DATAHIVE ${await box.get("configData")}");
    return jsonDecode(await box.get("configData")) as Map<String,dynamic>;
  }
}

