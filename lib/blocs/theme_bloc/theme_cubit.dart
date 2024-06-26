import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  ThemeCubit(super.initialState);

  void changeThemeMode(ThemeMode mode) {
    emit(mode);
  }
}