import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:swayzy/constants/app_colors.dart';
import 'package:swayzy/constants/app_text_styles.dart';
import 'package:swayzy/screens/profile/mocks/badge.mocks.dart';

import '../../constants/app_button_styles.dart';
import '../../constants/app_spaces.dart';

class Profile extends StatelessWidget{
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final photoURL = user?.photoURL;

    return SafeArea(
      child: Scaffold(
        body: user == null
          ? const Center(child: Text('Not logged in'))
          : SingleChildScrollView(
            child: Stack(
              children: [
                Positioned(
                  top: -10,
                  right: 10,
                  child: IconButton(
                    icon: const Icon(Icons.settings_rounded),
                    color: AppColors.highlight,
                    iconSize: 40,
                    onPressed: () {
                      Navigator.of(context).pushNamed('/settings');
                    }
                  ),
                ),
                Positioned(
                  top: -10,
                  left: 10,
                  child: IconButton(
                    icon: const Icon(Icons.notifications_rounded),
                    color: AppColors.highlight,
                    iconSize: 40,
                    onPressed: () {
                      Navigator.of(context).pushNamed('/notifications');
                    }
                  ),
                ),
                Center(
                  child: Column(
                    spacing: AppSpacing.small,
                    children: [
                      CircleAvatar(
                        radius: 100,
                        backgroundImage: photoURL != null ? NetworkImage(photoURL) : null,
                        child: photoURL == null ? const Icon(Icons.account_circle_rounded) : null,
                      ),
                      Container(
                        alignment: Alignment.center,
                        width: MediaQuery.sizeOf(context).width,
                        child: const EditableUserDisplayName(),
                      ),
                      // Container(
                      //   // alignment: Alignment.center,
                      //   // width: MediaQuery.sizeOf(context).width,
                      //   // child: TextButton.icon(
                      //   //   onPressed: () {
                      //   //
                      //   // },
                      //   // style: AppButtonStyles.primary,
                      //   // label: Text("Balance: "),
                      //   // ),
                      // ),
                      GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          mainAxisSpacing: 15.0,
                          crossAxisSpacing: 8.0,
                          mainAxisExtent: 180,
                          childAspectRatio: 0.7
                        ),
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: appBadges.length,
                        padding: const EdgeInsets.all(20),
                        itemBuilder: (context, index){
                          final badge = appBadges[index];
                          return Container(
                            padding: const EdgeInsets.all(8),
                            color: AppColors.secondaryBackground,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  badge.pathToImage,
                                  fit: BoxFit.fitHeight,
                                ),
                                SizedBox(height: 10,),
                                Text(
                                  badge.title,
                                  style: AppTextStyles.form,
                                ),
                              ],
                            ),
                          );
                        }
                      ),
                      ElevatedButton.icon(
                        style: AppButtonStyles.primary,
                        onPressed: () async {
                          await FirebaseAuth.instance.signOut();
                          Navigator.of(context).pushReplacementNamed('/auth');
                        },
                        label: const Text('Logout'),
                        icon: const Icon(Icons.logout_rounded),
                      ),
                      ElevatedButton.icon(
                        style: AppButtonStyles.delete,
                        onPressed: () async {
                          await user.delete();
                          await FirebaseAuth.instance.signOut();
                          Navigator.of(context).pushReplacementNamed('/auth');
                        },
                        label: const Text('Delete account'),
                        icon: const Icon(Icons.delete_rounded),
                      ),
                    ],
                  ),
                ),
              ]
            ),
          ),
      ),
    );
  }
}