import 'package:buy_movies/modules/movie_list/view/movie_list_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/config/bloc/config_bloc.dart';

void main() {
  runApp(BlocProvider(
    create: (context) => ConfigBloc(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConfigBloc, ConfigState>(
      builder: (context, state) {
        return MaterialApp(
          title: 'Flutter Demo',
          theme: state.appTheme.themeData,
          home: const MovieListPage(),
        );
      },
    );
  }
}
