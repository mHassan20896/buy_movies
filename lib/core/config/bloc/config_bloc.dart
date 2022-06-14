import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../theme/theme.dart';

part 'config_event.dart';
part 'config_state.dart';

class ConfigBloc extends Bloc<ConfigEvent, ConfigState> {
  ConfigBloc() : super(ConfigState(appTheme: RedTheme())) {
    on<ThemeEvent>(_changeTheme);
  }

  void _changeTheme(ThemeEvent event, Emitter<ConfigState> emit) {
    switch (event.themeName) {
      case ThemeName.blue:
        emit(state.copyWith(appTheme: BlueTheme()));
        break;
      case ThemeName.red:
        emit(state.copyWith(appTheme: RedTheme()));
        break;
      case ThemeName.green:
        emit(state.copyWith(appTheme: GreenTheme()));
        break;
      case ThemeName.dark:
        emit(state.copyWith(appTheme: DarkTheme()));
        break;
    }
  }
}
