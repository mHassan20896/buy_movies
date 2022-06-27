import 'package:buy_movies/core/exception/custom_exception.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CustomException', () {
    const customException = CustomException('test message');
    test('initialisation', () {
      expect(customException.message, 'test message');
    });

    test('toString', () {
      expect(customException.toString(), 'test message');
    });
  });
}
