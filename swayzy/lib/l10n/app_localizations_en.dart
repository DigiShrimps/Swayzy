// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get bottomNavBarItem => '';

  @override
  String get homeTitle => 'Home';

  @override
  String get creationTitle => 'Creation';

  @override
  String get chatTitle => 'Chat';

  @override
  String get notificationTitle => 'Notification';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get adTitle => 'Advertisement';

  @override
  String statusOption(String key) {
    String _temp0 = intl.Intl.selectLogic(
      key,
      {
        'inWork': 'In work',
        'completed': 'Completed',
        'other': '',
      },
    );
    return '$_temp0';
  }

  @override
  String get searchButton => 'All';

  @override
  String get processButton => 'In process';

  @override
  String get priceLabel => 'Price:';

  @override
  String get descriptionLabel => 'Description:';

  @override
  String get reviewTag => 'review';

  @override
  String get durationTag => 'Duration:';

  @override
  String get subscribersTag => 'subscribers';

  @override
  String get takeButton => 'Take order';

  @override
  String get completeButton => 'Complete order';

  @override
  String get orderTaken => 'Order accepted';

  @override
  String get orderCompleted => 'Order completed';

  @override
  String get yourOrderError => 'You can\'t take your order';

  @override
  String get chooseImageLabel => 'Choose an image for ad:';

  @override
  String get addPhotoLabel => 'Add photo';

  @override
  String get addPhotoTooltip => 'Pick Image';

  @override
  String get addAnotherPhotoLabel => 'Add another photo';

  @override
  String get chooseTitleLabel => 'Title:';

  @override
  String get hintTitleLabel => 'Example: Samsung A34 Black';

  @override
  String get chooseDescriptionLabel => 'Description:';

  @override
  String get hintDescriptionLabel => 'Describe what you want from potential performers, including «where», «how» and «what» they need to advertise';

  @override
  String get categorySelectorLabel => 'Category:';

  @override
  String categoryOption(String key) {
    String _temp0 = intl.Intl.selectLogic(
      key,
      {
        'all': 'All',
        'electronics': 'Electronics',
        'services': 'Services',
        'vehicles': 'Vehicles',
        'clothes': 'Clothes',
        'other': '',
      },
    );
    return '$_temp0';
  }

  @override
  String get reviewSelectorLabel => 'Review Type:';

  @override
  String reviewOption(String key) {
    String _temp0 = intl.Intl.selectLogic(
      key,
      {
        'positive': 'Positive',
        'fair': 'Fair',
        'negative': 'Negative',
        'other': '',
      },
    );
    return '$_temp0';
  }

  @override
  String get socialSelectorLabel => 'Social Network:';

  @override
  String get subscribersSelectorLabel => 'Subscribers:';

  @override
  String get chooseInfluencersLabel => 'Number of influencers involved:';

  @override
  String get hintInfluencersLabel => '1-100';

  @override
  String get chooseDurationLabel => 'Duration:';

  @override
  String get hintDurationLabel => 'Post save time';

  @override
  String get choosePriceLabel => 'Price:';

  @override
  String get hintPriceLabel => 'Cedra/influencer';

  @override
  String get saveButton => 'Save';

  @override
  String get orderCreated => 'Order created';

  @override
  String get customerButton => 'Customer';

  @override
  String get performerButton => 'Performer';

  @override
  String get balanceLabel => 'Balance:';

  @override
  String get notEnterToAccount => 'Not logged into account';

  @override
  String get exitButton => 'Exit';

  @override
  String get deleteButton => 'Delete account';

  @override
  String get noSocialError => 'Social isn\'t connected';

  @override
  String get settingsSectionCommon => 'Common';

  @override
  String get socialSectionCommon => 'Social';

  @override
  String get settingsSectionAbout => 'About';

  @override
  String get supportSubject => '[Swayzy Support] *Topic of question*';

  @override
  String get supportMessage => 'Hello! I have question about the app: ';

  @override
  String get languageTitle => 'Language';

  @override
  String get languageOption => 'English';

  @override
  String get notifications => 'Notifications';

  @override
  String get githubText => 'GitHub repository for a project';

  @override
  String get supportTitle => 'Support';

  @override
  String get supportText => 'Write us if you have any questions';

  @override
  String get feedbackTitle => 'Feedback';

  @override
  String get feedbackText => 'Write if you have any suggestions or complaints';

  @override
  String get copyright => ' Developed by DigiShrimps';

  @override
  String get okButton => 'Confirm';

  @override
  String get cancelButton => 'Cancel';

  @override
  String get confirmationText => 'Deleting your account will delete your profile, all your playlists, music you\'ve created, and more.\nAre you sure?';

  @override
  String get followersText => 'Followers:';

  @override
  String get noUrlError => 'Error: URL not given';
}
