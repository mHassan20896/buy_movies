part of 'config_bloc.dart';

class ConfigState extends Equatable {
  const ConfigState({required this.appTheme});

  final AppTheme appTheme;

  ConfigState copyWith({AppTheme? appTheme}) =>
      ConfigState(appTheme: appTheme ?? this.appTheme);

  @override
  List<Object> get props => [appTheme];
}
