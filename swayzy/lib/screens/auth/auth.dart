import 'package:firebase_ui_oauth_google/firebase_ui_oauth_google.dart';
import 'package:flutter/material.dart';
import 'package:swayzy/constants/app_images_paths.dart';
import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:swayzy/constants/private_data.dart';
import 'package:swayzy/main.dart';

import '../../constants/app_text_styles.dart';

class Auth extends StatelessWidget {
  const Auth({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Theme(
            data: Theme.of(context).copyWith(
              scaffoldBackgroundColor: const Color(0xFF4618A7),
              textTheme: TextTheme(bodyMedium: AppTextStyles.body),
            ),
            child: PopScope(
              canPop: false,
              child: SignInScreen(
                showAuthActionSwitch: false,
                headerMaxExtent: 700,
                oauthButtonVariant: OAuthButtonVariant.icon_and_text,
                providers: [
                  GoogleProvider(clientId: PrivateData.googleProviderClientId),
                ],
                headerBuilder: (context, constraints, shrinkOffset) {
                  return Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Image.asset(
                          AppImagesPaths.logo,
                          width: constraints.maxWidth - 50,
                          height: constraints.maxWidth - 50,
                          fit: BoxFit.cover,
                        ),
                        SizedBox(height: 20),
                        Text(
                          "WELCOME TO YOUR INFLUENCER ADVENTURE!",
                          style: AppTextStyles.title,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          );
        }
        return MainPage();
      },
    );
  }
}
