import 'package:flutter/material.dart';

import '../main.dart';
import '../screens/ad/ad.dart';
import '../screens/auth/auth.dart';
import '../screens/chat/chat.dart';
import '../screens/creation/creation.dart';
import '../screens/explore/explore.dart';
import '../screens/inner_browser/inner_browser.dart';
import '../screens/notifications/models/app_notification.dart';
import '../screens/notifications/notifications.dart';
import '../screens/profile/profile.dart';
import '../screens/settings/dialogs/change_social_info_dialog.dart';
import '../screens/settings/settings.dart';

class AppRoutes {
  static const String main = "/";
  static const String ad = "/ad";
  static const String auth = "/auth";
  static const String chat = "/chat";
  static const String creation = "/creation";
  static const String explore = "/explore";
  static const String innerBrowser = "/innerBrowser";
  static const String notifications = "/notifications";
  static const String profile = "/profile";
  static const String settings = "/settings";
  static const String socialDialog = "/socialDialog";

  static Route<dynamic>? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case main:
        return MaterialPageRoute(builder: (_) => const MainPage());
      case ad:
        return MaterialPageRoute(builder: (_) {
          final args = routeSettings.arguments as AdArguments?;
          if (args == null) {
            return Scaffold(
              appBar: AppBar(title: Text("Error")),
              body: Center(child: Text("Помилка: Аргументи не передані!")),
            );
          }
          return Ad(arguments: args);
        });
      case auth:
        return MaterialPageRoute(builder: (_) => const Auth());
      case chat:
        return MaterialPageRoute(builder: (_) => const Chat());
      case creation:
        return MaterialPageRoute(builder: (_) => const Creation());
      case explore:
        return MaterialPageRoute(builder: (_) => const Explore());
      case innerBrowser:
        return MaterialPageRoute(builder: (_) => const InnerBrowser());
      case notifications:
        return MaterialPageRoute(builder: (_) => Notifications());
      case profile:
        return MaterialPageRoute(builder: (_) => const Profile());
      case settings:
        return MaterialPageRoute(builder: (_) => const Settings());
      case socialDialog:
        final socialName = routeSettings.arguments as String?;
        return MaterialPageRoute(builder: (_) => ChangeSocialInfoDialog(socialName: socialName));
      default:
        return MaterialPageRoute(builder: (_) => const Auth());
    }
  }
}
