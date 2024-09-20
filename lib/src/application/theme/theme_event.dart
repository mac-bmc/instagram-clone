part of 'theme_bloc.dart';

@immutable
class ThemeEvent extends Equatable {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class ThemeChange extends ThemeEvent {
  final ThemeMode themeMode;

  ThemeChange({required this.themeMode});
}
