import 'dart:async';
import 'dart:ffi';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(const ThemeState(themeMode:ThemeMode.system)) {
    on<ThemeChange>(_mapToThemeChange);
  }

  FutureOr<void> _mapToThemeChange(ThemeChange event, Emitter<ThemeState> emit) {

    emit(ThemeState(themeMode: event.themeMode));
  }
}

/*ElevatedButton(
onPressed: () {
final currentTheme = BlocProvider.of<ThemeBloc>(context).state.themeMode;
final newTheme = currentTheme == ThemeMode.light
? ThemeMode.dark
    : ThemeMode.light;
BlocProvider.of<ThemeBloc>(context).add(ThemeChange(themeMode: newTheme));
},
child: const Text('Toggle Theme'),
),*/
