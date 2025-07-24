// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Ukrainian (`uk`).
class AppLocalizationsUk extends AppLocalizations {
  AppLocalizationsUk([String locale = 'uk']) : super(locale);

  @override
  String get bottomNavBarItem => '';

  @override
  String get homeTitle => 'Головна';

  @override
  String get creationTitle => 'Створення';

  @override
  String get chatTitle => 'Чат';

  @override
  String get notificationTitle => 'Повідомлення';

  @override
  String get settingsTitle => 'Налаштування';

  @override
  String get adTitle => 'Оголошення';

  @override
  String statusOption(String key) {
    String _temp0 = intl.Intl.selectLogic(
      key,
      {
        'inWork': 'В процесі',
        'completed': 'Завершено',
        'other': '',
      },
    );
    return '$_temp0';
  }

  @override
  String get searchButton => 'Усі';

  @override
  String get processButton => 'В процесі';

  @override
  String get priceLabel => 'Ціна:';

  @override
  String get descriptionLabel => 'Опис:';

  @override
  String get reviewTag => 'огляд';

  @override
  String get durationTag => 'Тривалість:';

  @override
  String get subscribersTag => 'підписників';

  @override
  String get takeButton => 'Прийняти замовлення';

  @override
  String get completeButton => 'Завершити замовлення';

  @override
  String get orderTaken => 'Замовлення прийнято';

  @override
  String get orderCompleted => 'Замовлення завершено';

  @override
  String get yourOrderError => 'Ви не можете прийняти своє замовлення';

  @override
  String get chooseImageLabel => 'Оберіть зображення для оголошення:';

  @override
  String get addPhotoLabel => 'Додати фото';

  @override
  String get addPhotoTooltip => 'Оберіть фото';

  @override
  String get addAnotherPhotoLabel => 'Додати інше фото';

  @override
  String get chooseTitleLabel => 'Заголовок:';

  @override
  String get hintTitleLabel => 'Наприклад: Напій безалкогольний Живчик';

  @override
  String get chooseDescriptionLabel => 'Опис:';

  @override
  String get hintDescriptionLabel => 'Опишіть, чого ви хочете від потенційних виконавців, включаючи «де», «як» і «що» вони повинні рекламувати';

  @override
  String get categorySelectorLabel => 'Категорія:';

  @override
  String categoryOption(String key) {
    String _temp0 = intl.Intl.selectLogic(
      key,
      {
        'all': 'Все',
        'electronics': 'Електроніка',
        'services': 'Послуги',
        'vehicles': 'Транспорт',
        'clothes': 'Одяг',
        'other': '',
      },
    );
    return '$_temp0';
  }

  @override
  String get reviewSelectorLabel => 'Тип огляду:';

  @override
  String reviewOption(String key) {
    String _temp0 = intl.Intl.selectLogic(
      key,
      {
        'positive': 'Позитивний',
        'fair': 'Чесний',
        'negative': 'Негативний',
        'other': '',
      },
    );
    return '$_temp0';
  }

  @override
  String get socialSelectorLabel => 'Соціальна мережа:';

  @override
  String get subscribersSelectorLabel => 'Підписники:';

  @override
  String get chooseInfluencersLabel => 'Кількість залучених інфлюенсерів:';

  @override
  String get hintInfluencersLabel => '1-100';

  @override
  String get chooseDurationLabel => 'Тривалість:';

  @override
  String get hintDurationLabel => 'Не видаляти протягом';

  @override
  String get exampleDurationLabel => 'Число в днях';

  @override
  String get choosePriceLabel => 'Ціна:';

  @override
  String get hintPriceLabel => 'Плата за виконання';

  @override
  String get examplePriceLabel => 'Cedra/інфлюенсер';

  @override
  String get saveButton => 'Зберегти';

  @override
  String get orderCreated => 'Оголошення створено';

  @override
  String get noImageError => 'Помилка: додайте зображення для оголошення';

  @override
  String get noTitleError => 'Помилка: додайте назву оголошення';

  @override
  String get noDescriptionError => 'Помилка: додайте опис для оголошення';

  @override
  String get noCategoryError => 'Помилка: оберіть категорію зі списку';

  @override
  String get noReviewError => 'Помилка: оберіть тип огляду зі списку';

  @override
  String get noSocialError => 'Помилка: оберіть соціальну мережу зі списку';

  @override
  String get noSubscribersError => 'Помилка: оберіть кількість підписників зі списку';

  @override
  String get noPerformersError => 'Помилка: введіть кількість виконавців';

  @override
  String get zeroPerformersError => 'Помилка: кількість виконавців повинна бути більшою за 0';

  @override
  String get noDurationError => 'Помилка: введіть кількість днів збереження допису';

  @override
  String get zeroDurationError => 'Помилка: тривалість повинна бути більшою за 0';

  @override
  String get noPriceError => 'Помилка: введіть ціну за оголошення';

  @override
  String get zeroPriceError => 'Помилка: ціна повинна бути більшою за 0';

  @override
  String get customerButton => 'Замовник';

  @override
  String get performerButton => 'Виконавець';

  @override
  String get balanceLabel => 'Баланс:';

  @override
  String get notEnterToAccount => 'Не увійшли в акаунт';

  @override
  String get exitButton => 'Вийти';

  @override
  String get deleteButton => 'Видалити акаунт';

  @override
  String get noConnectedSocialError => 'Соцмережу не підключено';

  @override
  String get settingsSectionCommon => 'Загальні';

  @override
  String get socialSectionCommon => 'Соцмережі';

  @override
  String get settingsSectionAbout => 'Про програму';

  @override
  String get supportSubject => '[Swayzy Підтримка] *Текст запитання*';

  @override
  String get supportMessage => 'Вітаю! Маю питання щодо застосунку: ';

  @override
  String get languageTitle => 'Мова';

  @override
  String get languageOption => 'Українська';

  @override
  String get notifications => 'Сповіщення';

  @override
  String get githubText => 'GitHub-репозиторій проєкту';

  @override
  String get supportTitle => 'Підтримка';

  @override
  String get supportText => 'Пишіть якщо виникають запитання';

  @override
  String get feedbackTitle => 'Зворотний зв\'язок';

  @override
  String get feedbackText => 'Пишіть якщо маєте скарги чи пропозиції';

  @override
  String get copyright => ' Розроблено DigiShrimps';

  @override
  String get okButton => 'ОК';

  @override
  String get cancelButton => 'Скасувати';

  @override
  String get confirmationText => 'Видалення акаунту призведе до видалення профілю, всіх ваших плейлистів, створеної музики тощо.\nВи впевнені?';

  @override
  String get followersText => 'Підписники:';

  @override
  String get noUrlError => 'Помилка: URL не введено';
}
