import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:swayzy/constants/app_colors.dart';

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
            : Stack(
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
                    child:
                    Column(
                      spacing: AppSpacing.small,
                      children: [
                        CircleAvatar(
                          radius: 100,
                          backgroundImage: photoURL != null ? NetworkImage(photoURL) : null,
                          child: photoURL == null ? const Icon(Icons.account_circle_rounded) : null,
                        ),
                        const EditableUserDisplayName(),
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
    );
  }
}