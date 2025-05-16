import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../constants/app_button_styles.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/app_spaces.dart';
import '../../../constants/app_text_styles.dart';
import '../../creation/creation.dart';

String dropdownSubsValue = subsAmount.first;

final List<String> subsAmount = <String>[
  "<100",
  "100+",
  "500+",
  "1000+",
  "10000+",
  "50000+",
  "100000+",
  "500000+",
  "1000000+",
];

final List<DropdownEntry> subsEntries = UnmodifiableListView<DropdownEntry>(
  subsAmount.map<DropdownEntry>(
    (String title) => DropdownEntry(value: title, label: title),
  ),
);

final TextEditingController _urlController = TextEditingController();
void saveSocialData(ChangeSocialInfoDialog widget, context) {
  // TODO додати на пустий рядок
  FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .update({
        '${widget.socialName}URL': _urlController.text,
        '${widget.socialName}Followers': dropdownSubsValue,
      });
  _urlController.clear();
  Navigator.pop(context);
}
class ChangeSocialInfoDialog extends StatefulWidget {
  final String? socialName;
  const ChangeSocialInfoDialog({super.key, required this.socialName});

  @override
  State<ChangeSocialInfoDialog> createState() => _ChangeSocialInfoDialogState();
}

class _ChangeSocialInfoDialogState extends State<ChangeSocialInfoDialog> {
  @override
  Widget build(BuildContext context) {
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
              widget.socialName!,
              style: AppTextStyles.title,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: AppSpacing.small),
            SizedBox(height: AppSpacing.small),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              spacing: AppSpacing.medium,
              children: [
                Flexible(
                  flex: 3,
                  child: SizedBox(
                    width: MediaQuery.sizeOf(context).width - 80,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      spacing: AppSpacing.large,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text("URL:", style: AppTextStyles.form),
                        Text("Followers:", style: AppTextStyles.form),
                      ],
                    ),
                  ),
                ),
                //SizedBox(height: AppSpacing.small,),
                Flexible(
                  flex: 5,
                  child: SizedBox(
                    width: MediaQuery.sizeOf(context).width - 10,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      spacing: AppSpacing.small,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Flexible(
                          flex: 1,
                          child: SizedBox(
                            child: TextFormField(controller: _urlController),
                          ),
                        ),
                        Flexible(
                          flex: 1,
                          child: SizedBox(
                            child: DropdownMenu<String>(
                              expandedInsets: null,
                              textStyle: AppTextStyles.body,
                              initialSelection: subsAmount.first,
                              dropdownMenuEntries: subsEntries,
                              onSelected: (String? value) {
                                setState(() {
                                  dropdownSubsValue = value!;
                                });
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: AppSpacing.small),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    saveSocialData(widget, context);
                  },
                  style: AppButtonStyles.primary,
                  child: Text("Зберегти", style: AppTextStyles.buttonPrimary),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: AppButtonStyles.delete,
                  child: Text("Скасувати", style: AppTextStyles.buttonPrimary),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
