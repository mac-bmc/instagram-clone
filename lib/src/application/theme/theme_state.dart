part of 'theme_bloc.dart';

@immutable
final class ThemeState extends Equatable {
  const ThemeState({required this.themeMode});

  @override
  List<Object?> get props => [themeMode];

  final ThemeMode themeMode;

}
