import 'package:buy_movies/core/config/bloc/config_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ConfigEvent', () {
    const theme = ThemeEvent(themeName: ThemeName.blue);

    group('ThemeEvent', () {
      test('Initialisation', () {
        expect(
          theme,
          isA<ThemeEvent>()
              .having((p0) => p0.themeName, 'themeName', ThemeName.blue),
        );
      });
    });
  });
}
