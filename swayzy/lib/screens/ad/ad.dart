import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:swayzy/constants/app_spaces.dart';

import '../../constants/app_button_styles.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_text_styles.dart';
import '../../global_widgets/custom_app_bar.dart';
import '../../solana/solana_service.dart';
import 'models/ad_arguments.dart';

const String _titleText = "Advertisement";

class Ad extends StatefulWidget {
  final AdArguments arguments;

  const Ad({super.key, required this.arguments});

  @override
  State<Ad> createState() => _AdState();
}

class _AdState extends State<Ad> {
  var user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    final args = widget.arguments;
    return Scaffold(
      appBar: CustomAppBar(title: _titleText,),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          vertical: AppSpacing.small,
          horizontal: AppSpacing.medium,
        ),
        child: Wrap(
          children: [
            Column(
              spacing: AppSpacing.medium,
              children: [
                SizedBox(height: 0),
                Center(
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.3,
                    width: MediaQuery.of(context).size.width * 0.95,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.grey[300],
                      image:
                          args.adImageUrl != null
                              ? DecorationImage(
                                image: NetworkImage(args.adImageUrl),
                                fit: BoxFit.contain,
                              )
                              : null,
                    ),
                    child:
                        args.adImageUrl == null
                            ? const Icon(
                              Icons.image,
                              size: 50,
                              color: Colors.black54,
                            )
                            : null,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    //spacing: AppSpacing.small,
                    children: [
                      Text(
                        args.adCreatedTime,
                        style: AppTextStyles.orderCategory,
                      ),
                      SizedBox(height: AppSpacing.small),
                      Text(args.adTitle, style: AppTextStyles.title),
                      SizedBox(height: AppSpacing.small),
                      Text(
                        "Price: ${args.adPrice.toString()} SOL",
                        style: AppTextStyles.buttonPrimary,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: AppSpacing.small),
                      SizedBox(
                        //width: MediaQuery.sizeOf(context).width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          spacing: AppSpacing.small,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Flexible(
                              flex: 10,
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: AppColors.accent,
                                ),
                                padding: EdgeInsets.all(10),
                                height: 60,
                                alignment: Alignment.center,
                                child: Text(
                                  args.adCategory,
                                  style: AppTextStyles.orderCategoryWhite,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            Flexible(
                              flex: 8,
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: AppColors.accent,
                                ),
                                padding: EdgeInsets.all(10),
                                height: 60,
                                alignment: Alignment.center,
                                child: Text(
                                  "${args.adReviewType}\nreview",
                                  style: AppTextStyles.orderCategoryWhite,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            Flexible(
                              flex: 9,
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: AppColors.accent,
                                ),
                                padding: EdgeInsets.all(10),
                                child: Text(
                                  "Duration:\n${args.adDuration}",
                                  style: AppTextStyles.orderCategoryWhite,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(thickness: 2, color: AppColors.highlight),
                      SizedBox(
                        width: MediaQuery.sizeOf(context).width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          spacing: AppSpacing.medium,
                          children: [
                            Flexible(
                              flex: 1,
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: AppColors.accent,
                                ),
                                padding: EdgeInsets.all(10),
                                height: 60,
                                alignment: Alignment.center,
                                child: Text(
                                  args.adSocial,
                                  style: AppTextStyles.orderCategoryWhite,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            Flexible(
                              flex: 2,
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: AppColors.accent,
                                ),
                                padding: EdgeInsets.all(10),
                                child: Text(
                                  "${args.adSubscribers}\nsubscribers",
                                  style: AppTextStyles.orderCategoryWhite,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: AppSpacing.medium),
                      Text(
                        "Description:",
                        style: AppTextStyles.buttonPrimary,
                        textAlign: TextAlign.start,
                      ),
                      SizedBox(
                        width: MediaQuery.sizeOf(context).width - 20,
                        child: Text(
                          args.adDescription,
                          style: AppTextStyles.form,
                          textAlign: TextAlign.start,
                        ),
                      ),
                      SizedBox(height: AppSpacing.medium),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            args.adOwnerName,
                            style: AppTextStyles.smallDescription,
                          ),
                          Divider(thickness: 2, color: AppColors.highlight),
                          Text(
                            args.adOwnerEmail,
                            style: AppTextStyles.smallDescription,
                          ),
                        ],
                      ),
                      SizedBox(height: AppSpacing.medium),
                      args.adId == null
                          ? Center(
                            child: ElevatedButton(
                              style: AppButtonStyles.primary,
                              onPressed: () async {
                                if (args.processId != null &&
                                    args.processId != "Completed") {
                                  updateStatus(args.processId, "Completed");
                                  var querySender =
                                      await FirebaseFirestore.instance
                                          .collection('users')
                                          .where(
                                            'userId',
                                            isEqualTo: args.adOwnerId,
                                          )
                                          .get();
                                  String senderWalletMnemonic =
                                      querySender.docs.first['mnemonic'];
                                  var queryRecipient =
                                      await FirebaseFirestore.instance
                                          .collection('users')
                                          .where('userId', isEqualTo: user.uid)
                                          .get();
                                  String recipientWalletMnemonic =
                                      queryRecipient.docs.first['mnemonic'];

                                  await passDataToContract(
                                    senderWalletMnemonic,
                                    recipientWalletMnemonic,
                                    args.adPrice,
                                  );
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      backgroundColor: AppColors.tokenSuccess,
                                      duration: Duration(seconds: 2),
                                      content: Text(
                                        "Complete!",
                                        style: AppTextStyles.form,
                                      ),
                                    ),
                                  );
                                }
                              },
                              child: Text("Complete"),
                            ),
                          )
                          : Center(
                            child: ElevatedButton(
                              style: AppButtonStyles.primary,
                              onPressed: () {
                                if (args.adOwnerId != user.uid) {
                                  createAdInProcess(
                                    args.adOwnerId,
                                    args.adId,
                                    user.uid,
                                    "In Work",
                                  );
                                  Navigator.of(context).pop();
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      backgroundColor: AppColors.tokenSuccess,
                                      duration: Duration(seconds: 2),
                                      content: Text(
                                        "Order taken!",
                                        style: AppTextStyles.form,
                                      ),
                                    ),
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      backgroundColor: AppColors.error,
                                      duration: Duration(seconds: 2),
                                      content: Text(
                                        "You can't take your order",
                                        style: AppTextStyles.form,
                                      ),
                                    ),
                                  );
                                }
                              },
                              child: Text("Take order"),
                            ),
                          ),
                      SizedBox(height: AppSpacing.medium),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> createAdInProcess(
    String ownerId,
    String adId,
    String userId,
    String status,
  ) async {
    final adData = {
      'ownerId': ownerId,
      'adId': adId,
      'userId': userId,
      'status': status,
    };

    await FirebaseFirestore.instance.collection('inProcess').add(adData);
  }

  Future<void> updateStatus(String inProcessId, String newStatus) async {
    CollectionReference inProcessRef = FirebaseFirestore.instance.collection(
      'inProcess',
    );

    await inProcessRef.doc(inProcessId).update({'status': newStatus});
  }
}
