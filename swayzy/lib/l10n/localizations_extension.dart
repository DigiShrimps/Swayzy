import 'app_localizations.dart';

extension DaysEnding on AppLocalizations {
  String dayLabel(int count) {
    switch (localeName) {
      case 'uk':
        final mod10 = count % 10;
        final mod100 = count % 100;

        if (mod100 >= 11 && mod100 <= 14) return 'днів';
        if (mod10 == 1) return 'день';
        if (mod10 >= 2 && mod10 <= 4) return 'дні';
        return 'днів';

      case 'en':
      default:
        return count == 1 ? 'day' : 'days';
    }
  }
}