import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_uk.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('uk')
  ];

  /// No description provided for @bottomNavBarItem.
  ///
  /// In uk, this message translates to:
  /// **''**
  String get bottomNavBarItem;

  /// No description provided for @homeTitle.
  ///
  /// In uk, this message translates to:
  /// **'Головна'**
  String get homeTitle;

  /// No description provided for @creationTitle.
  ///
  /// In uk, this message translates to:
  /// **'Створення'**
  String get creationTitle;

  /// No description provided for @chatTitle.
  ///
  /// In uk, this message translates to:
  /// **'Чат'**
  String get chatTitle;

  /// No description provided for @notificationTitle.
  ///
  /// In uk, this message translates to:
  /// **'Повідомлення'**
  String get notificationTitle;

  /// No description provided for @settingsTitle.
  ///
  /// In uk, this message translates to:
  /// **'Налаштування'**
  String get settingsTitle;

  /// No description provided for @adTitle.
  ///
  /// In uk, this message translates to:
  /// **'Оголошення'**
  String get adTitle;

  /// No description provided for @statusOption.
  ///
  /// In uk, this message translates to:
  /// **'{key, select, inWork{В процесі} completed{Завершено} other{}}'**
  String statusOption(String key);

  /// No description provided for @searchButton.
  ///
  /// In uk, this message translates to:
  /// **'Усі'**
  String get searchButton;

  /// No description provided for @processButton.
  ///
  /// In uk, this message translates to:
  /// **'В процесі'**
  String get processButton;

  /// No description provided for @priceLabel.
  ///
  /// In uk, this message translates to:
  /// **'Ціна:'**
  String get priceLabel;

  /// No description provided for @descriptionLabel.
  ///
  /// In uk, this message translates to:
  /// **'Опис:'**
  String get descriptionLabel;

  /// No description provided for @reviewTag.
  ///
  /// In uk, this message translates to:
  /// **'огляд'**
  String get reviewTag;

  /// No description provided for @durationTag.
  ///
  /// In uk, this message translates to:
  /// **'Тривалість:'**
  String get durationTag;

  /// No description provided for @subscribersTag.
  ///
  /// In uk, this message translates to:
  /// **'підписників'**
  String get subscribersTag;

  /// No description provided for @takeButton.
  ///
  /// In uk, this message translates to:
  /// **'Прийняти замовлення'**
  String get takeButton;

  /// No description provided for @completeButton.
  ///
  /// In uk, this message translates to:
  /// **'Завершити замовлення'**
  String get completeButton;

  /// No description provided for @orderTaken.
  ///
  /// In uk, this message translates to:
  /// **'Замовлення прийнято'**
  String get orderTaken;

  /// No description provided for @orderCompleted.
  ///
  /// In uk, this message translates to:
  /// **'Замовлення завершено'**
  String get orderCompleted;

  /// No description provided for @yourOrderError.
  ///
  /// In uk, this message translates to:
  /// **'Ви не можете прийняти своє замовлення'**
  String get yourOrderError;

  /// No description provided for @chooseImageLabel.
  ///
  /// In uk, this message translates to:
  /// **'Оберіть зображення для оголошення:'**
  String get chooseImageLabel;

  /// No description provided for @addPhotoLabel.
  ///
  /// In uk, this message translates to:
  /// **'Додати фото'**
  String get addPhotoLabel;

  /// No description provided for @addPhotoTooltip.
  ///
  /// In uk, this message translates to:
  /// **'Оберіть фото'**
  String get addPhotoTooltip;

  /// No description provided for @addAnotherPhotoLabel.
  ///
  /// In uk, this message translates to:
  /// **'Додати інше фото'**
  String get addAnotherPhotoLabel;

  /// No description provided for @chooseTitleLabel.
  ///
  /// In uk, this message translates to:
  /// **'Заголовок:'**
  String get chooseTitleLabel;

  /// No description provided for @hintTitleLabel.
  ///
  /// In uk, this message translates to:
  /// **'Наприклад: Напій безалкогольний Живчик'**
  String get hintTitleLabel;

  /// No description provided for @chooseDescriptionLabel.
  ///
  /// In uk, this message translates to:
  /// **'Опис:'**
  String get chooseDescriptionLabel;

  /// No description provided for @hintDescriptionLabel.
  ///
  /// In uk, this message translates to:
  /// **'Опишіть, чого ви хочете від потенційних виконавців, включаючи «де», «як» і «що» вони повинні рекламувати'**
  String get hintDescriptionLabel;

  /// No description provided for @categorySelectorLabel.
  ///
  /// In uk, this message translates to:
  /// **'Категорія:'**
  String get categorySelectorLabel;

  /// No description provided for @categoryOption.
  ///
  /// In uk, this message translates to:
  /// **'{key, select, all{Все} electronics{Електроніка} services{Послуги} vehicles{Транспорт} clothes{Одяг} other{}}'**
  String categoryOption(String key);

  /// No description provided for @reviewSelectorLabel.
  ///
  /// In uk, this message translates to:
  /// **'Тип огляду:'**
  String get reviewSelectorLabel;

  /// No description provided for @reviewOption.
  ///
  /// In uk, this message translates to:
  /// **'{key, select, positive{Позитивний} fair{Чесний} negative{Негативний} other{}}'**
  String reviewOption(String key);

  /// No description provided for @socialSelectorLabel.
  ///
  /// In uk, this message translates to:
  /// **'Соціальна мережа:'**
  String get socialSelectorLabel;

  /// No description provided for @subscribersSelectorLabel.
  ///
  /// In uk, this message translates to:
  /// **'Підписники:'**
  String get subscribersSelectorLabel;

  /// No description provided for @chooseInfluencersLabel.
  ///
  /// In uk, this message translates to:
  /// **'Кількість залучених інфлюенсерів:'**
  String get chooseInfluencersLabel;

  /// No description provided for @hintInfluencersLabel.
  ///
  /// In uk, this message translates to:
  /// **'1-100'**
  String get hintInfluencersLabel;

  /// No description provided for @chooseDurationLabel.
  ///
  /// In uk, this message translates to:
  /// **'Тривалість:'**
  String get chooseDurationLabel;

  /// No description provided for @hintDurationLabel.
  ///
  /// In uk, this message translates to:
  /// **'Зберігати протягом'**
  String get hintDurationLabel;

  /// No description provided for @choosePriceLabel.
  ///
  /// In uk, this message translates to:
  /// **'Ціна:'**
  String get choosePriceLabel;

  /// No description provided for @hintPriceLabel.
  ///
  /// In uk, this message translates to:
  /// **'Cedra/інфлюенсер'**
  String get hintPriceLabel;

  /// No description provided for @saveButton.
  ///
  /// In uk, this message translates to:
  /// **'Зберегти'**
  String get saveButton;

  /// No description provided for @orderCreated.
  ///
  /// In uk, this message translates to:
  /// **'Оголошення створено'**
  String get orderCreated;

  /// No description provided for @customerButton.
  ///
  /// In uk, this message translates to:
  /// **'Замовник'**
  String get customerButton;

  /// No description provided for @performerButton.
  ///
  /// In uk, this message translates to:
  /// **'Виконавець'**
  String get performerButton;

  /// No description provided for @balanceLabel.
  ///
  /// In uk, this message translates to:
  /// **'Баланс:'**
  String get balanceLabel;

  /// No description provided for @notEnterToAccount.
  ///
  /// In uk, this message translates to:
  /// **'Не увійшли в акаунт'**
  String get notEnterToAccount;

  /// No description provided for @exitButton.
  ///
  /// In uk, this message translates to:
  /// **'Вийти'**
  String get exitButton;

  /// No description provided for @deleteButton.
  ///
  /// In uk, this message translates to:
  /// **'Видалити акаунт'**
  String get deleteButton;

  /// No description provided for @noSocialError.
  ///
  /// In uk, this message translates to:
  /// **'Соцмережу не підключено'**
  String get noSocialError;

  /// No description provided for @settingsSectionCommon.
  ///
  /// In uk, this message translates to:
  /// **'Загальні'**
  String get settingsSectionCommon;

  /// No description provided for @socialSectionCommon.
  ///
  /// In uk, this message translates to:
  /// **'Соцмережі'**
  String get socialSectionCommon;

  /// No description provided for @settingsSectionAbout.
  ///
  /// In uk, this message translates to:
  /// **'Про програму'**
  String get settingsSectionAbout;

  /// No description provided for @supportSubject.
  ///
  /// In uk, this message translates to:
  /// **'[Swayzy Підтримка] *Текст запитання*'**
  String get supportSubject;

  /// No description provided for @supportMessage.
  ///
  /// In uk, this message translates to:
  /// **'Вітаю! Маю питання щодо застосунку: '**
  String get supportMessage;

  /// No description provided for @languageTitle.
  ///
  /// In uk, this message translates to:
  /// **'Мова'**
  String get languageTitle;

  /// No description provided for @languageOption.
  ///
  /// In uk, this message translates to:
  /// **'Українська'**
  String get languageOption;

  /// No description provided for @notifications.
  ///
  /// In uk, this message translates to:
  /// **'Сповіщення'**
  String get notifications;

  /// No description provided for @githubText.
  ///
  /// In uk, this message translates to:
  /// **'GitHub-репозиторій проєкту'**
  String get githubText;

  /// No description provided for @supportTitle.
  ///
  /// In uk, this message translates to:
  /// **'Підтримка'**
  String get supportTitle;

  /// No description provided for @supportText.
  ///
  /// In uk, this message translates to:
  /// **'Пишіть якщо виникають запитання'**
  String get supportText;

  /// No description provided for @feedbackTitle.
  ///
  /// In uk, this message translates to:
  /// **'Зворотний зв\'язок'**
  String get feedbackTitle;

  /// No description provided for @feedbackText.
  ///
  /// In uk, this message translates to:
  /// **'Пишіть якщо маєте скарги чи пропозиції'**
  String get feedbackText;

  /// No description provided for @copyright.
  ///
  /// In uk, this message translates to:
  /// **' Розроблено DigiShrimps'**
  String get copyright;

  /// No description provided for @okButton.
  ///
  /// In uk, this message translates to:
  /// **'ОК'**
  String get okButton;

  /// No description provided for @cancelButton.
  ///
  /// In uk, this message translates to:
  /// **'Скасувати'**
  String get cancelButton;

  /// No description provided for @confirmationText.
  ///
  /// In uk, this message translates to:
  /// **'Видалення акаунту призведе до видалення профілю, всіх ваших плейлистів, створеної музики тощо.\nВи впевнені?'**
  String get confirmationText;

  /// No description provided for @followersText.
  ///
  /// In uk, this message translates to:
  /// **'Підписники:'**
  String get followersText;

  /// No description provided for @noUrlError.
  ///
  /// In uk, this message translates to:
  /// **'Помилка: URL не введено'**
  String get noUrlError;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'uk'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'uk': return AppLocalizationsUk();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
