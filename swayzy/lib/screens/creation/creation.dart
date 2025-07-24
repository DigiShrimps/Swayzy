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
import 'package:swayzy/global_entities/category/category.mocks.dart';
import 'package:swayzy/screens/creation/mocks/duration_time.mocks.dart';
import 'package:swayzy/screens/creation/models/duration_time.dart';
import 'package:uuid/uuid.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_text_styles.dart';
import '../../constants/subs_amount_list.dart';
import '../../global_widgets/custom_exception.dart';
import '../../l10n/app_localizations.dart';
import '../../services/supabase/supabase_storage_service.dart';
import 'mocks/review_type.mocks.dart';

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

  List<DropdownEntry> categoryEntries(AppLocalizations loc) {
    return UnmodifiableListView<DropdownEntry>(
      adCategories
          .where((category) => category.key != "all")
          .map<DropdownEntry>(
            (category) => DropdownEntry(
              value: category.key,
              label: loc.categoryOption(category.key),
            ),
          ),
    );
  }

  List<DropdownEntry> reviewTypesEntries(AppLocalizations loc) {
    return UnmodifiableListView<DropdownEntry>(
      reviewTypes.map<DropdownEntry>(
        (review) => DropdownEntry(
          value: review.key,
          label: loc.reviewOption(review.key),
        ),
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
  // String dropdownCategoryValue = adCategories[1].key;
  // String dropdownReviewValue = reviewTypes.first.key;
  // String dropdownSocialValue = socialType.first;
  // String dropdownSubsValue = SubsAmount.subsAmount.first;
  // String? selectedDurationKey;
  String? dropdownCategoryValue;
  String? dropdownReviewValue;
  String? dropdownSocialValue;
  String? dropdownSubsValue;
  String? selectedDurationKey;

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
                  Text(
                    localizations.chooseImageLabel,
                    style: AppTextStyles.title,
                    textAlign: TextAlign.center,
                  ),
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
                            Text(
                              localizations.addPhotoLabel,
                              style: AppTextStyles.body,
                            ),
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
                  Text(
                    localizations.chooseTitleLabel,
                    style: AppTextStyles.title,
                  ),
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
                  Text(
                    localizations.chooseDescriptionLabel,
                    style: AppTextStyles.title,
                  ),
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
                              Text(
                                localizations.categorySelectorLabel,
                                style: AppTextStyles.form,
                              ),
                              SizedBox(
                                child: DropdownMenu<String>(
                                  expandedInsets: null,
                                  key: dropdownKey(
                                    dropdownCategoryValue,
                                    localizations,
                                  ),
                                  textStyle: AppTextStyles.body,
                                  initialSelection: dropdownCategoryValue,
                                  dropdownMenuEntries: categoryEntries(
                                    localizations,
                                  ),
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
                              Text(
                                localizations.reviewSelectorLabel,
                                style: AppTextStyles.form,
                              ),
                              SizedBox(
                                child: DropdownMenu<String>(
                                  expandedInsets: null,
                                  key: dropdownKey(
                                    dropdownReviewValue,
                                    localizations,
                                  ),
                                  textStyle: AppTextStyles.body,
                                  initialSelection: dropdownReviewValue,
                                  dropdownMenuEntries: reviewTypesEntries(
                                    localizations,
                                  ),
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
                                  key: dropdownKey(
                                    dropdownSocialValue,
                                    localizations,
                                  ),
                                  textStyle: AppTextStyles.body,
                                  initialSelection: dropdownSocialValue,
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
                              Text(
                                localizations.subscribersSelectorLabel,
                                style: AppTextStyles.form,
                              ),
                              SizedBox(
                                child: DropdownMenu<String>(
                                  expandedInsets: null,
                                  key: dropdownKey(
                                    dropdownSubsValue,
                                    localizations,
                                  ),
                                  textStyle: AppTextStyles.body,
                                  initialSelection: dropdownSubsValue,
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
                      decoration: InputDecoration(
                        hintText: localizations.hintInfluencersLabel,
                      ),
                      controller: _performersController,
                    ),
                  ),
                  Container(
                    width: MediaQuery.sizeOf(context).width - 40,
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      spacing: AppSpacing.small,
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Flexible(
                          flex: 1,
                          child: Column(
                            spacing: AppSpacing.small,
                            children: [
                              Text(
                                localizations.chooseDurationLabel,
                                style: AppTextStyles.form,
                              ),
                              SizedBox(
                                child: TextFormField(
                                  controller: _durationController,
                                  keyboardType: TextInputType.number,
                                  maxLength: 4,
                                  decoration: InputDecoration(
                                    labelText: localizations.hintDurationLabel,
                                    labelStyle: TextStyle(
                                      fontSize: AppFontSizes.body,
                                      color: Colors.grey[750],
                                    ),
                                    floatingLabelStyle:
                                        AppTextStyles.orderTitle,
                                    hintText:
                                        localizations.exampleDurationLabel,
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                                // оцю фігню поки не чіпайте, воно пригодиться
                                // Autocomplete<DurationTime>(
                                //   key: ValueKey(selectedDurationKey),
                                //   optionsBuilder: (TextEditingValue textEditingValue,) {
                                //     if (textEditingValue.text.isEmpty) {
                                //       return const Iterable<DurationTime>.empty();
                                //     }
                                //     return durationTimes.where((DurationTime option) {
                                //       final localized = localizations.durationOption(option.key);
                                //       return localized.toLowerCase().contains(textEditingValue.text.toLowerCase());
                                //     });
                                //   },
                                //   displayStringForOption: (DurationTime option) => localizations.durationOption(option.key),
                                //   onSelected: (DurationTime selection) {
                                //     setState(() {
                                //       selectedDurationKey = selection.key;
                                //       _durationController.text = localizations.durationOption(selection.key);
                                //     });
                                //   },
                                //   fieldViewBuilder: (
                                //       context,
                                //       _,
                                //       focusNode,
                                //       onFieldSubmitted,
                                //       ) {
                                //     return TextFormField(
                                //       controller: _durationController,
                                //       focusNode: focusNode,
                                //       decoration: InputDecoration(
                                //         labelText:
                                //             localizations.hintDurationLabel,
                                //         labelStyle: TextStyle(
                                //           fontSize: AppFontSizes.body,
                                //           color: Colors.grey[750],
                                //         ),
                                //         floatingLabelStyle:
                                //             AppTextStyles.orderTitle,
                                //         hintText:
                                //             localizations.exampleDurationLabel,
                                //         border: OutlineInputBorder(),
                                //       ),
                                //     );
                                //   },
                                // ),
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
                                localizations.choosePriceLabel,
                                style: AppTextStyles.form,
                              ),
                              SizedBox(
                                child: TextField(
                                  keyboardType: TextInputType.number,
                                  maxLength: 4,
                                  style: AppTextStyles.body,
                                  decoration: InputDecoration(
                                    labelText: localizations.hintPriceLabel,
                                    labelStyle: TextStyle(
                                      fontSize: AppFontSizes.body,
                                      color: Colors.grey[750],
                                    ),
                                    floatingLabelStyle:
                                    AppTextStyles.orderTitle,
                                    hintText: localizations.examplePriceLabel,
                                    border: OutlineInputBorder(),
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
                    label: Text(
                      localizations.saveButton,
                      style: AppTextStyles.title,
                    ),
                    icon: Icon(Icons.save_rounded),
                    style: AppButtonStyles.primary,
                    onPressed: () {
                      saveAd(context, localizations);
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

  Future<void> saveAd(BuildContext context, AppLocalizations loc) async {
    var user = FirebaseAuth.instance.currentUser!;
    final scaffoldMessenger = ScaffoldMessenger.of(context);

    try {
      String title = _titleController.text;
      if (title.isEmpty) {
        throw CustomException(loc.noTitleError);
      }
      String description = _descriptionController.text;
      if (description.isEmpty) {
        throw CustomException(loc.noDescriptionError);
      }

      String? category = dropdownCategoryValue;
      if (category == null) {
        throw CustomException(loc.noCategoryError);
      }
      String? reviewType = dropdownReviewValue;
      if (reviewType == null) {
        throw CustomException(loc.noReviewError);
      }
      String? social = dropdownSocialValue;
      if (social == null) {
        throw CustomException(loc.noSocialError);
      }
      String? amountOfSubscribers = dropdownSubsValue;
      if (amountOfSubscribers == null) {
        throw CustomException(loc.noSubscribersError);
      }

      int? amountOfPerformers = int.tryParse(_performersController.text);
      if (amountOfPerformers == null) {
        throw CustomException(loc.noPerformersError);
      }
      if (amountOfPerformers == 0) {
        throw CustomException(loc.zeroPerformersError);
      }
      int? duration = int.tryParse(_durationController.text);
      if (duration == null) {
        throw CustomException(loc.noDurationError);
      }
      if (duration == 0) {
        throw CustomException(loc.zeroDurationError);
      }
      double? price = double.tryParse(_priceController.text);
      if (price == null) {
        throw CustomException(loc.noPriceError);
      }
      if (price == 0) {
        throw CustomException(loc.zeroPriceError);
      }

      await createAd(
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
        loc,
      );

      for (var controller in controllers) {
        controller.clear();
      }

      setState(() {
        dropdownCategoryValue = null;
        dropdownReviewValue = null;
        dropdownSocialValue = null;
        dropdownSubsValue = null;
        _image = null;
      });

      scaffoldMessenger.showSnackBar(
        SnackBar(
          backgroundColor: AppColors.tokenSuccess,
          duration: Duration(seconds: 2),
          content: Text(loc.orderCreated, style: AppTextStyles.form),
        ),
      );
    } on Exception catch (e) {
      scaffoldMessenger.showSnackBar(
        SnackBar(
          backgroundColor: AppColors.error,
          duration: const Duration(seconds: 2),
          content: Text("$e", style: AppTextStyles.form),
        ),
      );
    }
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
    int duration,
    int amountOfPerformers,
    String amountOfSubscribers,
    String social,
    AppLocalizations loc,
  ) async {
    try {
      if (_image == null) {
        throw CustomException(loc.noImageError);
      }
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
    } catch (e) {
      rethrow;
    }
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

  Key dropdownKey(String? value, AppLocalizations loc) {
    return ValueKey('${loc.localeName}_$value');
  }
}
