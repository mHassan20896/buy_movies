import 'package:flutter/material.dart';

extension NavigatorX on Navigator {
  static Future pushPage(BuildContext context, {required Widget page}) =>
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => page,
        ),
      );

  static Future pushAndRemoveUntilPage(
    BuildContext context, {
    required Widget page,
    bool Function(Route<dynamic>)? predicate,
  }) =>
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => page),
        predicate ?? (route) => false,
      );
}
