import 'dart:collection';
import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:swayzy/constants/app_button_styles.dart';
import 'package:swayzy/constants/app_spaces.dart';
import 'package:swayzy/screens/creation/mocks/category.mocks.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_text_styles.dart';

const String _titleText = "Creation";
typedef DropdownEntry = DropdownMenuEntry<String>;
final storage = FirebaseStorage.instance;
late String title;
late String description;
late String ownerId;
late String image;
final TextEditingController _titleController = TextEditingController();
final TextEditingController _descriptionController = TextEditingController();
final TextEditingController _durationController = TextEditingController();
final TextEditingController _priceController = TextEditingController();

class Creation extends StatefulWidget {
  const Creation({super.key});

  @override
  State<Creation> createState() => _CreationState();
}

class _CreationState extends State<Creation> {
  // final ImagePicker _picker = ImagePicker();
  // XFile? _image;

  static final List<String> categoryTitles = appCategories.map((c) => c.title).toList();
  static final List<DropdownEntry> categoryEntries = UnmodifiableListView<DropdownEntry>(
    categoryTitles.map<DropdownEntry>((String title) => DropdownEntry(value: title, label: title)),
  );
  String dropdownCategoryValue = categoryTitles.first;

  static final List<String> reviewType = <String>["Positive", "Fair", "Negative"];
  static final List<DropdownEntry> reviewEntries = UnmodifiableListView<DropdownEntry>(
    reviewType.map<DropdownEntry>((String title) => DropdownEntry(value: title, label: title)),
  );
  String dropdownReviewValue = reviewType.first;

  // Future getImageFromGallery() async {
  //   final XFile? image = await _picker.pickImage(
  //     source: ImageSource.gallery,
  //     imageQuality: 80,
  //   );
  //
  //   setState(() {
  //     _image = image;
  //   });
  // }
  //
  // Future<String> uploadImageToStorage(XFile image) async {
  //   final ref = FirebaseStorage.instance
  //       .ref()
  //       .child('ad_images')
  //       .child('${DateTime.now().millisecondsSinceEpoch}.jpg');
  //
  //   final uploadTask = await ref.putFile(File(image.path));
  //   print(uploadTask);
  //   return await ref.getDownloadURL();
  // }

  Future<void> createAd(
    String title,
    String category,
    String review,
    String description,
    String ownerId,
    String ownerName,
    String ownerEmail,
    int price,
    String duration) async {
    //final imageUrl = await uploadImageToStorage(image);
    DateTime now = DateTime.now();

    final adData = {
      'title': title,
      'category': category,
      'reviewType': review,
      'description': description,
      'ownerId': ownerId,
      'ownerName': ownerName,
      'ownerEmail': ownerEmail,
      'price': price,
      'duration': duration,
      //'imageUrl': imageUrl,
      'createdAt': "${now.day} ${now.month} ${now.hour}:${now.minute}",
    };

    await FirebaseFirestore.instance.collection('ads').add(adData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(_titleText),
        titleTextStyle: AppTextStyles.title,
        backgroundColor: AppColors.secondaryBackground,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            spacing: AppSpacing.small,
            children: [
              // Text(
              //   "Choose an image:",
              //   style: AppTextStyles.title,
              // ),
              // _image == null
              //   ? Container(
              //   width: 260,
              //   height: 260,
              //   alignment: Alignment.center,
              //   decoration: BoxDecoration(
              //       border: Border.all(color: AppColors.highlight),
              //       color: AppColors.secondaryBackground
              //   ),
              //   child: Column(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //       children: [
              //         Text(
              //           "Add photo",
              //           style: AppTextStyles.body,
              //         ),
              //         SizedBox(height: AppSpacing.small,),
              //         FloatingActionButton(
              //           onPressed: getImageFromGallery,
              //             tooltip: 'Pick Image',
              //             child: const Icon(Icons.add_a_photo),
              //         ),
              //       ],
              //     ),
              //   )
              //   : Container(
              //     width: 260,
              //     decoration: BoxDecoration(
              //       border: Border.all(color: AppColors.highlight, width: 3),
              //       color: AppColors.secondaryBackground,
              //     ),
              //     child: Column(
              //       children: [
              //         Row(
              //           spacing: AppSpacing.small,
              //           mainAxisAlignment: MainAxisAlignment.center,
              //           children: [
              //             Text(
              //               "Add another photo",
              //               style: AppTextStyles.body,
              //             ),
              //             FloatingActionButton(
              //               onPressed: getImageFromGallery,
              //               tooltip: 'Pick Image',
              //               child: const Icon(Icons.add_a_photo),
              //             ),
              //           ],
              //         ),
              //         Image.file(File(_image!.path)),
              //       ],
              //     ),
              //   ),
              Text(
                "Title:",
                style: AppTextStyles.title,
              ),
              SizedBox(
                width: MediaQuery.sizeOf(context).width - 20,
                child: TextField(
                  maxLength: 30,
                  style: AppTextStyles.form,
                  decoration: InputDecoration(
                    hintText: "Example: Samsung A34 Black"
                  ),
                  controller: _titleController,
                ),
              ),
              Container(
                width: MediaQuery.sizeOf(context).width - 10,
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: AppSpacing.small,
                  children: [
                    Column(
                      spacing: AppSpacing.small,
                      children: [
                        Text(
                          "Category:",
                          style: AppTextStyles.title,
                        ),
                        SizedBox(
                          width: MediaQuery.sizeOf(context).width * 0.5,
                          child: DropdownMenu<String>(
                            width: MediaQuery.sizeOf(context).width * 0.5,
                            expandedInsets: null,
                            textStyle: AppTextStyles.form,
                            initialSelection: appCategories.first.title,
                            dropdownMenuEntries: categoryEntries,
                            onSelected: (String? value) {
                              setState(() {
                                dropdownCategoryValue = value!;
                              });
                            },
                          )
                        ),
                      ],
                    ),
                    Column(
                      spacing: AppSpacing.small,
                      children: [
                        Text(
                          "Review type:",
                          style: AppTextStyles.title,
                        ),
                        SizedBox(
                          width: MediaQuery.sizeOf(context).width * 0.4,
                          child: DropdownMenu<String>(
                            width: MediaQuery.sizeOf(context).width * 0.4,
                            expandedInsets: null,
                            textStyle: AppTextStyles.form,
                            initialSelection: reviewType.first,
                            dropdownMenuEntries: reviewEntries,
                            onSelected: (String? value) {
                              setState(() {
                                dropdownReviewValue = value!;
                              });
                            },
                          )
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Text(
                "Description:",
                style: AppTextStyles.title,
              ),
              SizedBox(
                width: MediaQuery.sizeOf(context).width - 20,
                child: TextField(
                  maxLength: 1000,
                  maxLines: 5,
                  style: AppTextStyles.form,
                  decoration: InputDecoration(
                    hintText: "Describe what you want from potential performers, including \"where\", "
                        "\"how\" and \"what\" they need to advertise"
                  ),
                  controller: _descriptionController,
                ),
              ),
              Container(
                width: MediaQuery.sizeOf(context).width - 10,
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: AppSpacing.small,
                  children: [
                    Column(
                      spacing: AppSpacing.small,
                      children: [
                        Text(
                          "Duration:",
                          style: AppTextStyles.title,
                        ),
                        SizedBox(
                          width: MediaQuery.sizeOf(context).width * 0.4,
                          child: TextField(
                            maxLength: 15,
                            style: AppTextStyles.form,
                            decoration: InputDecoration(
                              hintText: "Post save time"
                            ),
                            controller: _durationController,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      spacing: AppSpacing.small,
                      children: [
                        Text(
                          "Price:",
                          style: AppTextStyles.title,
                        ),
                        SizedBox(
                          width: MediaQuery.sizeOf(context).width * 0.5,
                          child: TextField(
                            maxLength: 15,
                            style: AppTextStyles.form,
                            decoration: InputDecoration(
                              hintText: "SOL per performer"
                            ),
                            controller: _priceController,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              TextButton.icon(
                label: Text("Save", style: AppTextStyles.title,),
                icon: Icon(Icons.save_rounded),
                style: AppButtonStyles.primary,
                onPressed: () {
                  var user = FirebaseAuth.instance.currentUser!;
                  String title = _titleController.text;
                  String description = _descriptionController.text;
                  String reviewType = dropdownReviewValue;
                  String category = dropdownCategoryValue;
                  int price = int.parse(_priceController.text);
                  String duration = _durationController.text;
                  createAd(
                    title,
                    category,
                    reviewType,
                    description,
                    user.uid,
                    user.displayName!,
                    user.email!,
                    price,
                    duration
                  );
                  _titleController.clear();
                  _descriptionController.clear();
                  _priceController.clear();
                  _durationController.clear();
                },
              ),
              SizedBox(width: AppSpacing.small,)
            ],
          ),
        ),
      ),
    );
  }
}