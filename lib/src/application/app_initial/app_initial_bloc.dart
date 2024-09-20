import 'package:app_clone/src/domain/auth/auth_repository.dart';
import 'package:app_clone/src/domain/remoteconfig/remote_config_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'app_initial_event.dart';
part 'app_initial_state.dart';

class AppInitialBloc extends Bloc<AppInitialEvent, AppInitialState> {
  final AuthRepository _authRepository;
  final RemoteConfigRepository _configRepository;

  AppInitialBloc(this._authRepository, this._configRepository) : super(AppNotInitializedState()) {

    on<AppLoadingEvent>((event,emit) {
      emit(AppLoadingState());
    });
    on<AuthStartedEvent>((event, emit) async{
      emit(AppNotInitializedState());
      await _configRepository.getAndUpdateConfig();
      await _authCheck(emit);
    });
  }

  Future<void> _authCheck(Emitter<AppInitialState> emit) async {
    bool isSignIn = await _authRepository.isSignedIn();
    if (isSignIn) {
      final currentUser = await _authRepository.getCurrentUser();
      emit(AuthenticatedState(currentUser: currentUser));
    } else {
      emit(UnauthenticatedState());
    }
  }
}
//Since the authBloc is being used in both auth and myapp , the UI build on state change would result in unexpected behavior.
//So creating a separate bloc for handling initial app configs and manage auth changes.