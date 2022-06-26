part of 'theme.dart';

abstract class AppTheme extends Equatable {
  ColorScheme get colorScheme;

  ThemeData get themeData => ThemeData(colorScheme: colorScheme);

  @override
  List<Object?> get props => [themeData];
}
