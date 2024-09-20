import 'package:app_clone/src/domain/auth/auth_repository.dart';
import 'package:app_clone/src/domain/databases/remote_config_dao.dart';
import 'package:app_clone/src/domain/remoteconfig/remote_config_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:google_sign_in/google_sign_in.dart';

AuthRepository provideAuthRepository() {
  return AuthRepository.instance = AuthRepository(
    provideRemoteConfigRepository(),
      googleInstance: provideGoogleAuth(),
      firebaseAuthInstance: provideFirebaseAuth());
}
RemoteConfigDao provideConfigDao()
{
  return RemoteConfigDao();
}

RemoteConfigRepository provideRemoteConfigRepository()
{
  return RemoteConfigRepository.instance = RemoteConfigRepository(provideConfigDao(), remoteConfig: provideFirebaseConfig());
}

FirebaseAuth provideFirebaseAuth() {
  return FirebaseAuth.instance;
}
FirebaseRemoteConfig provideFirebaseConfig()
{
  return FirebaseRemoteConfig.instance;
}

GoogleSignIn provideGoogleAuth() {
  return GoogleSignIn();
}
