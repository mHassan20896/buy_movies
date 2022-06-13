part of 'theme.dart';

abstract class AppTheme {
  ColorScheme get colorScheme;

  ThemeData get themeData => ThemeData(colorScheme: colorScheme);
}
