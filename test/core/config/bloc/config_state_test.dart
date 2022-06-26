import 'package:buy_movies/core/config/bloc/config_bloc.dart';
import 'package:buy_movies/core/config/theme/theme.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ConfigState', () {
    final state = ConfigState(appTheme: RedTheme());

    test('Initialisation', () {
      expect(
        state,
        isA<ConfigState>().having((p0) => p0.appTheme, 'appTheme', RedTheme()),
      );
    });

    test('copyWith', () {
      final copiedState = state.copyWith(appTheme: GreenTheme());
      expect(
        copiedState,
        ConfigState(appTheme: GreenTheme()),
      );
    });
  });
}
