import 'package:zod_validation/src/locales/i_locale.dart';

import 'locale_br.dart';
import 'locale_en.dart';

/// this is the enum responsible localizations
enum Locale {
  pt_BR,
  en_US;

  /// this method is responsible for returning the ILocaleZod instance
  ILocaleZod get localeZod {
    if (this == Locale.pt_BR) return LocaleBR();
    if (this == Locale.en_US) return LocaleEN();
    return LocaleEN();
  }
}
