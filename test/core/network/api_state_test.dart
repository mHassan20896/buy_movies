import 'package:buy_movies/core/network/api_state.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ApiState', () {
    const apiState = ApiState<String>();
    test('Initialization', () {
      expect(
        apiState,
        isA<ApiState>().having((p0) => p0.apiResponseState, 'apiResponseState',
            ApiResponseState.initial),
      );
    });

    test('change state', () {
      final newApiState = apiState.copyWith(
          apiResponseState: ApiResponseState.loading, response: 'Response');
      expect(
        newApiState,
        const ApiState<String>(
            apiResponseState: ApiResponseState.loading, response: 'Response'),
      );
      expect(
        newApiState.copyWith(apiResponseState: ApiResponseState.success),
        const ApiState<String>(
            apiResponseState: ApiResponseState.success, response: 'Response'),
      );
    });
  });
}
