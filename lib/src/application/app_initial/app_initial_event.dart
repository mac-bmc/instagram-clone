part of 'app_initial_bloc.dart';

@immutable
final class AppInitialEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

final class AuthStartedEvent extends AppInitialEvent {}

final class AppLoadingEvent extends AppInitialEvent{}
