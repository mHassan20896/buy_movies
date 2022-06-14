part of 'config_bloc.dart';

abstract class ConfigEvent extends Equatable {
  const ConfigEvent();
}

class ThemeEvent extends ConfigEvent {
  const ThemeEvent({required this.themeName});

  final ThemeName themeName;

  @override
  List<Object?> get props => [themeName];
}

enum ThemeName { blue, green, red, dark }
