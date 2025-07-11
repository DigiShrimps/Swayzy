import 'dart:collection';
import 'dart:core';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:swayzy/constants/app_button_styles.dart';
import 'package:swayzy/constants/app_font_sizes.dart';
import 'package:swayzy/constants/app_spaces.dart';
import 'package:swayzy/screens/creation/mocks/category.mocks.dart';
import 'package:uuid/uuid.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_text_styles.dart';
import '../../constants/subs_amount_list.dart';
import '../../l10n/app_localizations.dart';
import '../../services/supabase/supabase_storage_service.dart';
import 'mocks/reviewType.mocks.dart';

late String description;
late XFile image;
late String ownerId;
final storage = FirebaseStorage.instance;
late String title;
final TextEditingController _descriptionController = TextEditingController();
final TextEditingController _durationController = TextEditingController();
final TextEditingController _performersController = TextEditingController();
final TextEditingController _priceController = TextEditingController();
final TextEditingController _titleController = TextEditingController();

typedef DropdownEntry = DropdownMenuEntry<String>;

class Creation extends StatefulWidget {
  const Creation({super.key});

  @override
  State<Creation> createState() => _CreationState();
}

class _CreationState extends State<Creation> {

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    setState(() {});
  }

  // static final List<String> categoryTitles =
  //     appCategories.map((c) => c.title).toList();
  // static final List<DropdownEntry> categoryEntries =
  //   UnmodifiableListView<DropdownEntry>(
  //     categoryTitles.map<DropdownEntry>(
  //       (String title) => DropdownEntry(value: title, label: title),
  //     ),
  //   );

  List<DropdownEntry> categoryEntries(AppLocalizations loc) {
    return UnmodifiableListView<DropdownEntry>(
      appCategories.map<DropdownEntry>(
        (category) => DropdownEntry(
        value: category.key,
        label: loc.categoryOption(category.key)),
      ),
    );
  }

  List<DropdownEntry> reviewTypesEntries(AppLocalizations loc) {
    return UnmodifiableListView<DropdownEntry>(
      reviewTypes.map<DropdownEntry>(
        (review) => DropdownEntry(
        value: review.key,
        label: loc.reviewOption(review.key)),
      ),
    );
  }

  static final List<String> socialType = <String>[
    "Instagram",
    "Telegram",
    "TikTok",
    "FaceBook",
    "Reddit",
  ];
  static final List<DropdownEntry> socialEntries =
      UnmodifiableListView<DropdownEntry>(
        socialType.map<DropdownEntry>(
          (String title) => DropdownEntry(value: title, label: title),
        ),
      );

  static List<TextEditingController> controllers = [
    _titleController,
    _descriptionController,
    _priceController,
    _durationController,
    _performersController,
  ];

  final ImagePicker _picker = ImagePicker();
  XFile? _image;
  String dropdownCategoryValue = appCategories.first.key;
  String dropdownReviewValue = reviewTypes.first.key;
  String dropdownSocialValue = socialType.first;
  String dropdownSubsValue = SubsAmount.subsAmount.first;

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final String titleText = localizations.creationTitle;

    return Scaffold(
      appBar: AppBar(
        title: Text(titleText),
        titleTextStyle: AppTextStyles.title,
        backgroundColor: AppColors.secondaryBackground,
        centerTitle: true,
        surfaceTintColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Wrap(
          children: [
            Center(
              child: Column(
                spacing: AppSpacing.small,
                children: [
                  Text(localizations.chooseImageLabel, style: AppTextStyles.title, textAlign: TextAlign.center,),
                  _image == null
                      ? Container(
                        width: 260,
                        height: 260,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.highlight),
                          color: AppColors.secondaryBackground,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(localizations.addPhotoLabel, style: AppTextStyles.body),
                            SizedBox(height: AppSpacing.small),
                            FloatingActionButton(
                              onPressed: getImageFromGallery,
                              tooltip: localizations.addPhotoTooltip,
                              child: const Icon(Icons.add_a_photo),
                            ),
                          ],
                        ),
                      )
                      : Container(
                        width: 260,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: AppColors.highlight,
                            width: 3,
                          ),
                          color: AppColors.secondaryBackground,
                        ),
                        child: Column(
                          children: [
                            Row(
                              spacing: AppSpacing.small,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  localizations.addAnotherPhotoLabel,
                                  style: AppTextStyles.body,
                                ),
                                FloatingActionButton(
                                  onPressed: getImageFromGallery,
                                  tooltip: localizations.addPhotoTooltip,
                                  child: const Icon(Icons.add_a_photo),
                                ),
                              ],
                            ),
                            Image.file(File(_image!.path)),
                          ],
                        ),
                      ),
                  Text(localizations.chooseTitleLabel, style: AppTextStyles.title),
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width - 40,
                    child: TextField(
                      maxLength: 30,
                      style: AppTextStyles.form,
                      decoration: InputDecoration(
                        hintText: localizations.hintTitleLabel,
                      ),
                      controller: _titleController,
                    ),
                  ),
                  Text(localizations.chooseDescriptionLabel, style: AppTextStyles.title),
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width - 40,
                    child: TextField(
                      maxLength: 1000,
                      maxLines: 5,
                      style: AppTextStyles.form,
                      decoration: InputDecoration(
                        hintText: localizations.hintDescriptionLabel,
                      ),
                      controller: _descriptionController,
                    ),
                  ),
                  Container(
                    width: MediaQuery.sizeOf(context).width - 40,
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      spacing: AppSpacing.small,
                      children: [
                        Flexible(
                          flex: 113,
                          child: Column(
                            spacing: AppSpacing.small,
                            children: [
                              Text(localizations.categorySelectorLabel, style: AppTextStyles.form),
                              SizedBox(
                                child: DropdownMenu<String>(
                                  expandedInsets: null,
                                  key: ValueKey(localizations.localeName),
                                  textStyle: AppTextStyles.body,
                                  initialSelection: dropdownCategoryValue,
                                  dropdownMenuEntries: categoryEntries(localizations),
                                  onSelected: (String? value) {
                                    setState(() {
                                      dropdownCategoryValue = value!;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        Flexible(
                          flex: 100,
                          child: Column(
                            spacing: AppSpacing.small,
                            children: [
                              Text(localizations.reviewSelectorLabel, style: AppTextStyles.form),
                              SizedBox(
                                child: DropdownMenu<String>(
                                  expandedInsets: null,
                                  key: ValueKey(localizations.localeName), // використано для динамічного перекладу при зміні мови
                                  textStyle: AppTextStyles.body,
                                  initialSelection: dropdownReviewValue,
                                  dropdownMenuEntries: reviewTypesEntries(localizations),
                                  onSelected: (String? value) {
                                    setState(() {
                                      dropdownReviewValue = value!;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.sizeOf(context).width - 40,
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      spacing: AppSpacing.small,
                      children: [
                        Flexible(
                          flex: 103,
                          child: Column(
                            spacing: AppSpacing.small,
                            children: [
                              Text(
                                localizations.socialSelectorLabel,
                                style: AppTextStyles.form,
                              ),
                              SizedBox(
                                child: DropdownMenu<String>(
                                  expandedInsets: null,
                                  textStyle: AppTextStyles.body,
                                  initialSelection: socialType.first,
                                  dropdownMenuEntries: socialEntries,
                                  onSelected: (String? value) {
                                    setState(() {
                                      dropdownSocialValue = value!;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        Flexible(
                          flex: 100,
                          child: Column(
                            spacing: AppSpacing.small,
                            children: [
                              Text(localizations.subscribersSelectorLabel, style: AppTextStyles.form),
                              SizedBox(
                                child: DropdownMenu<String>(
                                  expandedInsets: null,
                                  textStyle: AppTextStyles.body,
                                  initialSelection: SubsAmount.subsAmount.first,
                                  dropdownMenuEntries: SubsAmount.subsEntries,
                                  onSelected: (String? value) {
                                    setState(() {
                                      dropdownSubsValue = value!;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    localizations.chooseInfluencersLabel,
                    style: AppTextStyles.form,
                  ),
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width - 200,
                    child: TextField(
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      maxLength: 3,
                      style: AppTextStyles.body,
                      decoration: InputDecoration(hintText: localizations.hintInfluencersLabel),
                      controller: _performersController,
                    ),
                  ),
                  Container(
                    width: MediaQuery.sizeOf(context).width - 40,
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      spacing: AppSpacing.small,
                      children: [
                        Flexible(
                          flex: 1,
                          child: Column(
                            spacing: AppSpacing.small,
                            children: [
                              Text(localizations.chooseDurationLabel, style: AppTextStyles.form),
                              SizedBox(
                                child: TextField(
                                  maxLength: 10,
                                  style: AppTextStyles.body,
                                  decoration: InputDecoration(
                                    hintText: localizations.hintDurationLabel,
                                    //  hintStyle: TextStyle(fontSize: AppFontSizes.small) якщо на телефоні не буде влазити
                                  ),
                                  controller: _durationController,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Flexible(
                          flex: 1,
                          child: Column(
                            spacing: AppSpacing.small,
                            children: [
                              Text(localizations.choosePriceLabel, style: AppTextStyles.form),
                              SizedBox(
                                child: TextField(
                                  keyboardType: TextInputType.number,
                                  maxLength: 4,
                                  style: AppTextStyles.body,
                                  decoration: InputDecoration(
                                    hintText: localizations.hintPriceLabel,
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
                    label: Text(localizations.saveButton, style: AppTextStyles.title),
                    icon: Icon(Icons.save_rounded),
                    style: AppButtonStyles.primary,
                    onPressed: () {
                      saveAd(context);
                    },
                  ),
                  SizedBox(width: AppSpacing.small),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void saveAd(BuildContext context) {
    var user = FirebaseAuth.instance.currentUser!;

    String title = _titleController.text;
    String description = _descriptionController.text;
    String duration = _durationController.text;

    String amountOfSubscribers = dropdownSubsValue;
    String social = dropdownSocialValue;
    String reviewType = dropdownReviewValue;
    String category = dropdownCategoryValue;

    double price = double.parse(_priceController.text);
    int amountOfPerformers = int.parse(_performersController.text);

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

    for (var controller in controllers) {
      controller.clear();
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: AppColors.tokenSuccess,
        duration: Duration(seconds: 2),
        content: Text("Order created", style: AppTextStyles.form),
      ),
    );
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
    String social,
  ) async {
    final imageUrl = await uploadImageToStorage(_image!);
    int timeNow = DateTime.now().millisecondsSinceEpoch;
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timeNow);
    var dateFormatter = DateFormat('dd-MM-yyyy HH:mm');

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
      'imageUrl': imageUrl,
      'createdAt': dateFormatter.format(dateTime),
    };

    await FirebaseFirestore.instance.collection('ads').add(adData);
  }

  Future getImageFromGallery() async {
    final XFile? image = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );

    setState(() {
      _image = image;
    });
  }

  Future uploadImageToStorage(XFile image) async {
    SupabaseStorageService supabaseStorageService = SupabaseStorageService();
    final uuid = Uuid();
    File file = File(image.path);

    final publicUrl = await supabaseStorageService.uploadFile(
      file: file,
      fileName: basename("${uuid.v4()}_file.path"),
    );

    return publicUrl;
  }
}
