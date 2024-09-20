import 'package:app_clone/src/domain/remoteconfig/remote_config_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreRepository
{
  static FirestoreRepository? instance;
  final RemoteConfigRepository _remoteConfigRepository;
  final FirebaseAuth _firebaseAuthInstance;

  FirestoreRepository(this._remoteConfigRepository,
      {
        required FirebaseAuth firebaseAuthInstance})
      : _firebaseAuthInstance = firebaseAuthInstance ?? FirebaseAuth.instance;

  Future<void> addUserToFirestore() async{

  }


}