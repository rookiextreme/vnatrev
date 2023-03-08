import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:vnatpro2/locale/LanguageEn.dart';
import 'package:vnatpro2/locale/LanguageFr.dart';
import 'package:vnatpro2/locale/Languages.dart';
import 'package:vnatpro2/locale/LanguageAr.dart';
import 'package:vnatpro2/locale/LanguageHi.dart';

class AppLocalizations extends LocalizationsDelegate<BaseLanguage> {
  const AppLocalizations();

  @override
  Future<BaseLanguage> load(Locale locale) async {
    switch (locale.languageCode) {
      case 'en':
        return LanguageEn();
      case 'ar':
        return LanguageAr();
      case 'hi':
        return LanguageHi();
      case 'fr':
        return LanguageFr();
      default:
        return LanguageEn();
    }
  }

  @override
  bool isSupported(Locale locale) => LanguageDataModel.languages().contains(locale.languageCode);

  @override
  bool shouldReload(LocalizationsDelegate<BaseLanguage> old) => false;
}
