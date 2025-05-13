import 'package:bip39/bip39.dart' as bip39;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_ui_oauth_google/firebase_ui_oauth_google.dart';
import 'package:flutter/material.dart';
import 'package:swayzy/constants/app_images_paths.dart';
import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:swayzy/constants/private_data.dart';
import 'package:swayzy/main.dart';

import '../../constants/app_text_styles.dart';

class Auth extends StatefulWidget {
  const Auth({super.key});

  @override
  State<Auth> createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  String _mnemonic = "";

  @override
  void initState() {
    super.initState();
    _generateMnemonic();
  }

  Future<void> _generateMnemonic() async {
    String mnemonic = bip39.generateMnemonic();

    setState(() {
      _mnemonic = mnemonic;
    });
  }

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
                resizeToAvoidBottomInset: true,
                showAuthActionSwitch: false,
                headerMaxExtent: 600,
                oauthButtonVariant: OAuthButtonVariant.icon_and_text,
                providers: [
                  GoogleProvider(clientId: PrivateData.googleProviderClientId),
                ],
                headerBuilder: (context, constraints, shrinkOffset) {
                  return Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AspectRatio(
                          aspectRatio: 1.1,
                          child: Image.asset(
                            AppImagesPaths.logo,
                            height: 300,
                            width: 300,
                          ),
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
        WidgetsBinding.instance.addPostFrameCallback((_) async {
          Future<bool> isDuplicateUniqueName(String userId) async {
            QuerySnapshot query = await FirebaseFirestore.instance
                .collection('users')
                .where('userId', isEqualTo: userId)
                .get();
            return query.docs.isNotEmpty;
          }
          if (await isDuplicateUniqueName(FirebaseAuth.instance.currentUser!.uid)) {
            Navigator.of(context).pushNamedAndRemoveUntil(
              '/', (Route<dynamic> route) => false,
            );
          } else {
            FirebaseFirestore.instance
              .collection('users')
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .set(<String, dynamic>{
              'timestamp': DateTime.now().millisecondsSinceEpoch,
              'name': FirebaseAuth.instance.currentUser!.displayName,
              'userId': FirebaseAuth.instance.currentUser!.uid,
              'mnemonic': _mnemonic
            });
            Navigator.of(context).pushNamedAndRemoveUntil(
              '/', (Route<dynamic> route) => false,
            );
          }
        });
        return const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
