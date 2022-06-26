import 'package:buy_movies/core/config/bloc/config_bloc.dart';
import 'package:buy_movies/core/config/theme/theme.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';

void main() {
  group('ConfigBloc', () {
    blocTest<ConfigBloc, ConfigState>(
      'emits ConfigState(DarkTheme) when ThemeEvent(ThemeName.dark) is added.',
      build: () => ConfigBloc(),
      act: (bloc) => bloc.add(const ThemeEvent(themeName: ThemeName.dark)),
      expect: () => <ConfigState>[ConfigState(appTheme: DarkTheme())],
    );

    blocTest<ConfigBloc, ConfigState>(
      'emits ConfigState(BlueTheme) when ThemeEvent(ThemeName.blue) is added.',
      build: () => ConfigBloc(),
      act: (bloc) => bloc.add(const ThemeEvent(themeName: ThemeName.blue)),
      expect: () => <ConfigState>[ConfigState(appTheme: BlueTheme())],
    );

    blocTest<ConfigBloc, ConfigState>(
      'emits ConfigState(GreenTheme) when ThemeEvent(ThemeName.green) is added.',
      build: () => ConfigBloc(),
      act: (bloc) => bloc.add(const ThemeEvent(themeName: ThemeName.green)),
      expect: () => <ConfigState>[ConfigState(appTheme: GreenTheme())],
    );

    blocTest<ConfigBloc, ConfigState>(
      'emits ConfigState(RedTheme) when ThemeEvent(ThemeName.red) is added.',
      build: () => ConfigBloc(),
      act: (bloc) => bloc.add(const ThemeEvent(themeName: ThemeName.red)),
      expect: () => <ConfigState>[ConfigState(appTheme: RedTheme())],
    );
  });
}
