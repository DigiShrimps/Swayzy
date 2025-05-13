import 'dart:collection';
import 'dart:core';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
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
final TextEditingController _performersController = TextEditingController();

class Creation extends StatefulWidget {
  const Creation({super.key});

  @override
  State<Creation> createState() => _CreationState();
}

class _CreationState extends State<Creation> {
  final ImagePicker _picker = ImagePicker();
  XFile? _image;

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

  static final List<String> socialType = <String>["Instagram", "Telegram", "TikTok", "FaceBook", "Reddit"];
  static final List<DropdownEntry> socialEntries = UnmodifiableListView<DropdownEntry>(
    socialType.map<DropdownEntry>((String title) => DropdownEntry(value: title, label: title)),
  );
  String dropdownSocialValue = socialType.first;

  static final List<String> subsAmount = <String>["100+", "500+", "1000+", "10000+", "50000+", "100000+", "500000+", "1000000+"];
  static final List<DropdownEntry> subsEntries = UnmodifiableListView<DropdownEntry>(
    subsAmount.map<DropdownEntry>((String title) => DropdownEntry(value: title, label: title)),
  );
  String dropdownSubsValue = subsAmount.first;

  Future getImageFromGallery() async {
    final XFile? image = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );

    setState(() {
      _image = image;
    });
  }

  Future<String> uploadImageToStorage(XFile image) async {
    final ref = FirebaseStorage.instance
        .ref()
        .child('ad_images')
        .child('${DateTime.now().millisecondsSinceEpoch}.jpg');

    final uploadTask = await ref.putFile(File(image.path));
    print(uploadTask);
    return await ref.getDownloadURL();
  }

  Future<void> createAd(
    String title,
    String category,
    String review,
    String description,
    String ownerId,
    String ownerName,
    String ownerEmail,
    double price,
    String duration,
    int amountOfPerformers,
    String amountOfSubscribers,
    String social,) async {
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
      'amountOfPerformers': amountOfPerformers,
      'amountOfSubscribers': amountOfSubscribers,
      'social': social,
      'imageUrl': null, //imageUrl,
      'createdAt': "${now.day}.${now.month} ${now.hour}:${now.minute}",
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
        child: Wrap(
          children: [
            Center(
              child: Column(
                spacing: AppSpacing.small,
                children: [
                  Text(
                    "Choose an image:",
                    style: AppTextStyles.title,
                  ),
                  _image == null
                      ? Container(
                    width: 260,
                    height: 260,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        border: Border.all(color: AppColors.highlight),
                        color: AppColors.secondaryBackground
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Add photo",
                          style: AppTextStyles.body,
                        ),
                        SizedBox(height: AppSpacing.small,),
                        FloatingActionButton(
                          onPressed: getImageFromGallery,
                          tooltip: 'Pick Image',
                          child: const Icon(Icons.add_a_photo),
                        ),
                      ],
                    ),
                  )
                      : Container(
                    width: 260,
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.highlight, width: 3),
                      color: AppColors.secondaryBackground,
                    ),
                    child: Column(
                      children: [
                        Row(
                          spacing: AppSpacing.small,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Add another photo",
                              style: AppTextStyles.body,
                            ),
                            FloatingActionButton(
                              onPressed: getImageFromGallery,
                              tooltip: 'Pick Image',
                              child: const Icon(Icons.add_a_photo),
                            ),
                          ],
                        ),
                        Image.file(File(_image!.path)),
                      ],
                    ),
                  ),
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
                    width: MediaQuery.sizeOf(context).width - 20,
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      spacing: 10,
                      children: [
                        Flexible(
                          flex: 5,
                          child: Column(
                            spacing: AppSpacing.small,
                            children: [
                              Text(
                                "Category:",
                                style: AppTextStyles.form,
                              ),
                              SizedBox(
                                  //width: MediaQuery.sizeOf(context).width * 0.45,
                                  child: DropdownMenu<String>(
                                    //width: MediaQuery.sizeOf(context).width * 0.45,
                                    expandedInsets: null,
                                    textStyle: AppTextStyles.body,
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
                        ),
                        Flexible(
                          flex: 4,
                          child: Column(
                            spacing: AppSpacing.small,
                            children: [
                              Text(
                                "Review type:",
                                style: AppTextStyles.form,
                              ),
                              SizedBox(
                                  //width: MediaQuery.sizeOf(context).width * 0.37,
                                  child: DropdownMenu<String>(
                                    //width: MediaQuery.sizeOf(context).width * 0.37,
                                    expandedInsets: null,
                                    textStyle: AppTextStyles.body,
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
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.sizeOf(context).width - 20,
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      spacing: 10,
                      children: [
                        Flexible(
                          child: Column(
                            spacing: AppSpacing.small,
                            children: [
                              Text(
                                "Social network:",
                                style: AppTextStyles.form,
                              ),
                              SizedBox(
                                  //width: MediaQuery.sizeOf(context).width * 0.45,
                                  child: DropdownMenu<String>(
                                    //width: MediaQuery.sizeOf(context).width * 0.45,
                                    expandedInsets: null,
                                    textStyle: AppTextStyles.body,
                                    initialSelection: socialType.first,
                                    dropdownMenuEntries: socialEntries,
                                    onSelected: (String? value) {
                                      setState(() {
                                        dropdownSocialValue = value!;
                                      });
                                    },
                                  )
                              ),
                            ],
                          ),
                        ),
                        Flexible(
                          flex: 1,
                          child: Column(
                            spacing: AppSpacing.small,
                            children: [
                              Text(
                                "Subscribers:",
                                style: AppTextStyles.form,
                              ),
                              SizedBox(
                                  //width: MediaQuery.sizeOf(context).width * 0.37,
                                  child: DropdownMenu<String>(
                                    //width: MediaQuery.sizeOf(context).width * 0.37,
                                    expandedInsets: null,
                                    textStyle: AppTextStyles.body,
                                    initialSelection: subsAmount.first,
                                    dropdownMenuEntries: subsEntries,
                                    onSelected: (String? value) {
                                      setState(() {
                                        dropdownSubsValue = value!;
                                      });
                                    },
                                  )
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    "Number of influencers involved:",
                    style: AppTextStyles.form,
                  ),
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width - 200,
                    child: TextField(
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      maxLength: 3,
                      style: AppTextStyles.body,
                      decoration: InputDecoration(
                        hintText: "1-100"
                      ),
                      controller: _performersController,
                    ),
                  ),
                  Container(
                    width: MediaQuery.sizeOf(context).width - 10,
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      spacing: AppSpacing.small,
                      children: [
                        Flexible(
                          flex: 5,
                          child: Column(
                            spacing: AppSpacing.small,
                            children: [
                              Text(
                                "Duration:",
                                style: AppTextStyles.form,
                              ),
                              SizedBox(
                                //width: MediaQuery.sizeOf(context).width * 0.4,
                                child: TextField(
                                  maxLength: 15,
                                  style: AppTextStyles.body,
                                  decoration: InputDecoration(
                                    hintText: "Post save time"
                                  ),
                                  controller: _durationController,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Flexible(
                          flex: 5,
                          child: Column(
                            spacing: AppSpacing.small,
                            children: [
                              Text(
                                "Price:",
                                style: AppTextStyles.form,
                              ),
                              SizedBox(
                                //width: MediaQuery.sizeOf(context).width * 0.5,
                                child: TextField(
                                  keyboardType: TextInputType.number,
                                  maxLength: 4,
                                  style: AppTextStyles.body,
                                  decoration: InputDecoration(
                                      hintText: "SOL/influencer"
                                  ),
                                  controller: _priceController,
                                ),
                              ),
                            ],
                          ),
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
                      double price = double.parse(_priceController.text);
                      String duration = _durationController.text;
                      int amountOfPerformers = int.parse(_performersController.text);
                      String amountOfSubscribers = dropdownSubsValue;
                      String social = dropdownSocialValue;
                      createAd(
                        title,
                        category,
                        reviewType,
                        description,
                        user.uid,
                        user.displayName!,
                        user.email!,
                        price,
                        duration,
                        amountOfPerformers,
                        amountOfSubscribers,
                        social,
                      );
                      _titleController.clear();
                      _descriptionController.clear();
                      _priceController.clear();
                      _durationController.clear();
                      _performersController.clear();
                    },
                  ),
                  SizedBox(width: AppSpacing.small,)
                ],
              ),
            ),
          ]
        ),
      ),
    );
  }
}