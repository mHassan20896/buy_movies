import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../config/bloc/config_bloc.dart';

class DrawerListView extends StatelessWidget {
  const DrawerListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        children: [
          ListTile(
            onTap: () {
              context
                  .read<ConfigBloc>()
                  .add(const ThemeEvent(themeName: ThemeName.red));
              Navigator.pop(context);
            },
            title: const Text('Red theme'),
          ),
          ListTile(
            onTap: () {
              context
                  .read<ConfigBloc>()
                  .add(const ThemeEvent(themeName: ThemeName.green));
              Navigator.pop(context);
            },
            title: const Text('Green theme'),
          ),
          ListTile(
            onTap: () {
              context
                  .read<ConfigBloc>()
                  .add(const ThemeEvent(themeName: ThemeName.blue));
              Navigator.pop(context);
            },
            title: const Text('Blue theme'),
          ),
          ListTile(
            onTap: () {
              context
                  .read<ConfigBloc>()
                  .add(const ThemeEvent(themeName: ThemeName.dark));
              Navigator.pop(context);
            },
            title: const Text('Dark theme'),
          ),
        ],
      ),
    );
  }
}
