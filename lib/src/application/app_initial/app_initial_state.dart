part of 'app_initial_bloc.dart';

@immutable
final class AppInitialState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class AppNotInitializedState extends AppInitialState {}

final class AuthenticatedState extends AppInitialState{
  final User currentUser;

  AuthenticatedState({required this.currentUser});
  @override
  List<Object?> get props => [currentUser];
}

final class UnauthenticatedState extends AppInitialState{}

final class AppLoadingState extends AppInitialState{}
