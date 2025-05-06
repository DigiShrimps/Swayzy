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

  static MaterialPageRoute? onGenerateRoute(RouteSettings routeSettings) {
    return MaterialPageRoute(
      builder: (BuildContext context) {
        switch (routeSettings.name) {
          case main:
            return const MainPage();
          case ad:
            return const Ad();
          case auth:
            return const Auth();
          case chat:
            return const Chat();
          case creation:
            return const Creation();
          case explore:
            return const Explore();
          case innerBrowser:
            return const InnerBrowser();
          case notifications:
            return Notifications();
          case profile:
            return const Profile();
          case settings:
            return const Settings();
          default:
            return const Auth();
        }
      },
    );
  }
}