import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../constants/app_button_styles.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/app_spaces.dart';
import '../../../constants/app_text_styles.dart';
import '../../../l10n/app_localizations.dart';

class ConfirmDeletingAccountDialog extends StatelessWidget {
  const ConfirmDeletingAccountDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final user = FirebaseAuth.instance.currentUser;

    return Dialog(
      insetPadding: const EdgeInsets.all(10),
      alignment: Alignment.center,
      backgroundColor: AppColors.primaryBackground,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              localizations.confirmationText,
              style: AppTextStyles.title,
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: AppSpacing.small,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () async {
                    await deleteUser(user!, context);
                  },
                  style: AppButtonStyles.primary,
                  child: Text(
                    localizations.okButton,
                    style: AppTextStyles.buttonPrimary,
                  ),
                ),
                const SizedBox(
                  width: AppSpacing.large,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: AppButtonStyles.delete,
                  child: Text(
                    localizations.cancelButton,
                    style: AppTextStyles.buttonSecondary,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }


  Future<void> reauthenticateUser(User user) async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    if (googleUser == null) {
      return;
    }

    final GoogleSignInAuthentication googleAuth =
    await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    await user.reauthenticateWithCredential(credential);
  }

  Future<void> deleteUser(User user, BuildContext context) async {
    // TODO зробити видалення всіх даних
    final navigator = Navigator.of(context);

    await reauthenticateUser(user);
    await FirebaseFirestore.instance.collection('users').doc(user.uid).delete();
    final snapshots = await FirebaseFirestore.instance
      .collection('ads')
      .where('ownerId', isEqualTo: user.uid)
      .get();
    for(var doc in snapshots.docs){
      await doc.reference.delete();
    }
    await user.delete();

    navigator.pushReplacementNamed('/auth');
  }
}
