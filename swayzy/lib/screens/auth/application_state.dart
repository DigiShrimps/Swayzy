// import 'package:firebase_auth/firebase_auth.dart'
//     hide EmailAuthProvider, PhoneAuthProvider;
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_ui_auth/firebase_ui_auth.dart';
// import 'package:firebase_ui_oauth_google/firebase_ui_oauth_google.dart';
// import 'package:flutter/material.dart';
//
// import 'package:swayzy/firebase_config.dart';
// import 'package:swayzy/firebase_options.dart';
//
// class ApplicationState extends ChangeNotifier {
//   ApplicationState() {
//     init();
//   }
//
//   bool _loggedIn = false;
//   bool get loggedIn => _loggedIn;
//
//   Future<void> init() async{
//     await Firebase.initializeApp(
//       options: DefaultFirebaseOptions.currentPlatform
//     );
//
//     FirebaseUIAuth.configureProviders(
//         [GoogleProvider(clientId: "928593099570-gdeobs8ibpqq633ljqor92q83m6cjak3.apps.googleusercontent.com")]
//     );
//
//     FirebaseAuth.instance.userChanges().listen((user){
//       if(user != null) {
//         _loggedIn = true;
//       } else {
//         _loggedIn = false;
//       }
//       notifyListeners();
//     });
//   }
// }