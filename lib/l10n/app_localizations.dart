import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_tr.dart';

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
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

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
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[Locale('tr')];

  /// No description provided for @appTitle.
  ///
  /// In tr, this message translates to:
  /// **'plan2me'**
  String get appTitle;

  /// No description provided for @navProjects.
  ///
  /// In tr, this message translates to:
  /// **'Projeler'**
  String get navProjects;

  /// No description provided for @navPeople.
  ///
  /// In tr, this message translates to:
  /// **'Kişiler'**
  String get navPeople;

  /// No description provided for @navSettings.
  ///
  /// In tr, this message translates to:
  /// **'Ayarlar'**
  String get navSettings;

  /// No description provided for @commonSave.
  ///
  /// In tr, this message translates to:
  /// **'Kaydet'**
  String get commonSave;

  /// No description provided for @commonCancel.
  ///
  /// In tr, this message translates to:
  /// **'Vazgeç'**
  String get commonCancel;

  /// No description provided for @commonDelete.
  ///
  /// In tr, this message translates to:
  /// **'Sil'**
  String get commonDelete;

  /// No description provided for @commonEdit.
  ///
  /// In tr, this message translates to:
  /// **'Düzenle'**
  String get commonEdit;

  /// No description provided for @commonAdd.
  ///
  /// In tr, this message translates to:
  /// **'Ekle'**
  String get commonAdd;

  /// No description provided for @commonClose.
  ///
  /// In tr, this message translates to:
  /// **'Kapat'**
  String get commonClose;

  /// No description provided for @commonNone.
  ///
  /// In tr, this message translates to:
  /// **'Yok'**
  String get commonNone;

  /// No description provided for @commonClear.
  ///
  /// In tr, this message translates to:
  /// **'Temizle'**
  String get commonClear;

  /// No description provided for @commonRetry.
  ///
  /// In tr, this message translates to:
  /// **'Tekrar dene'**
  String get commonRetry;

  /// No description provided for @commonDeleteTitle.
  ///
  /// In tr, this message translates to:
  /// **'Silinsin mi?'**
  String get commonDeleteTitle;

  /// No description provided for @commonColor.
  ///
  /// In tr, this message translates to:
  /// **'Renk'**
  String get commonColor;

  /// No description provided for @commonNotFound.
  ///
  /// In tr, this message translates to:
  /// **'Kayıt bulunamadı'**
  String get commonNotFound;

  /// No description provided for @errorGeneric.
  ///
  /// In tr, this message translates to:
  /// **'Bir şeyler ters gitti: {error}'**
  String errorGeneric(Object error);

  /// No description provided for @priority.
  ///
  /// In tr, this message translates to:
  /// **'Öncelik'**
  String get priority;

  /// No description provided for @priorityLow.
  ///
  /// In tr, this message translates to:
  /// **'Düşük'**
  String get priorityLow;

  /// No description provided for @priorityMedium.
  ///
  /// In tr, this message translates to:
  /// **'Orta'**
  String get priorityMedium;

  /// No description provided for @priorityHigh.
  ///
  /// In tr, this message translates to:
  /// **'Yüksek'**
  String get priorityHigh;

  /// No description provided for @priorityCritical.
  ///
  /// In tr, this message translates to:
  /// **'Kritik'**
  String get priorityCritical;

  /// No description provided for @status.
  ///
  /// In tr, this message translates to:
  /// **'Aşama'**
  String get status;

  /// No description provided for @statusBacklog.
  ///
  /// In tr, this message translates to:
  /// **'Havuz'**
  String get statusBacklog;

  /// No description provided for @statusPlanned.
  ///
  /// In tr, this message translates to:
  /// **'Planlandı'**
  String get statusPlanned;

  /// No description provided for @statusInProgress.
  ///
  /// In tr, this message translates to:
  /// **'Devam ediyor'**
  String get statusInProgress;

  /// No description provided for @statusOnHold.
  ///
  /// In tr, this message translates to:
  /// **'Askıda'**
  String get statusOnHold;

  /// No description provided for @statusDone.
  ///
  /// In tr, this message translates to:
  /// **'Tamamlandı'**
  String get statusDone;

  /// No description provided for @statusCancelled.
  ///
  /// In tr, this message translates to:
  /// **'İptal'**
  String get statusCancelled;

  /// No description provided for @projectsTitle.
  ///
  /// In tr, this message translates to:
  /// **'Projelerim'**
  String get projectsTitle;

  /// No description provided for @projectsSearchHint.
  ///
  /// In tr, this message translates to:
  /// **'Proje, kişi veya detay ara'**
  String get projectsSearchHint;

  /// No description provided for @projectsEmptyTitle.
  ///
  /// In tr, this message translates to:
  /// **'Henüz proje yok'**
  String get projectsEmptyTitle;

  /// No description provided for @projectsEmptyBody.
  ///
  /// In tr, this message translates to:
  /// **'İlk projeni oluşturarak planlamaya başla.'**
  String get projectsEmptyBody;

  /// No description provided for @projectsNoMatch.
  ///
  /// In tr, this message translates to:
  /// **'Filtrelere uyan proje yok'**
  String get projectsNoMatch;

  /// No description provided for @projectsNew.
  ///
  /// In tr, this message translates to:
  /// **'Yeni proje'**
  String get projectsNew;

  /// No description provided for @projectsFilters.
  ///
  /// In tr, this message translates to:
  /// **'Filtreler'**
  String get projectsFilters;

  /// No description provided for @projectsShowClosed.
  ///
  /// In tr, this message translates to:
  /// **'Kapananları göster'**
  String get projectsShowClosed;

  /// No description provided for @projectsClearFilters.
  ///
  /// In tr, this message translates to:
  /// **'Filtreleri temizle'**
  String get projectsClearFilters;

  /// No description provided for @projectsReorderHint.
  ///
  /// In tr, this message translates to:
  /// **'Sıralamak için basılı tutup sürükle'**
  String get projectsReorderHint;

  /// No description provided for @sort.
  ///
  /// In tr, this message translates to:
  /// **'Sırala'**
  String get sort;

  /// No description provided for @sortManual.
  ///
  /// In tr, this message translates to:
  /// **'Manuel'**
  String get sortManual;

  /// No description provided for @sortPriority.
  ///
  /// In tr, this message translates to:
  /// **'Öncelik'**
  String get sortPriority;

  /// No description provided for @sortDueDate.
  ///
  /// In tr, this message translates to:
  /// **'Son tarih'**
  String get sortDueDate;

  /// No description provided for @sortUpdated.
  ///
  /// In tr, this message translates to:
  /// **'Son güncellenen'**
  String get sortUpdated;

  /// No description provided for @cardsProgress.
  ///
  /// In tr, this message translates to:
  /// **'{done}/{total} kart'**
  String cardsProgress(int done, int total);

  /// No description provided for @projectFormNew.
  ///
  /// In tr, this message translates to:
  /// **'Yeni proje'**
  String get projectFormNew;

  /// No description provided for @projectFormEdit.
  ///
  /// In tr, this message translates to:
  /// **'Projeyi düzenle'**
  String get projectFormEdit;

  /// No description provided for @fieldTitle.
  ///
  /// In tr, this message translates to:
  /// **'Başlık'**
  String get fieldTitle;

  /// No description provided for @fieldTitleRequired.
  ///
  /// In tr, this message translates to:
  /// **'Başlık gerekli'**
  String get fieldTitleRequired;

  /// No description provided for @fieldDescription.
  ///
  /// In tr, this message translates to:
  /// **'Kısa açıklama'**
  String get fieldDescription;

  /// No description provided for @fieldDetails.
  ///
  /// In tr, this message translates to:
  /// **'Detaylar'**
  String get fieldDetails;

  /// No description provided for @fieldDetailsHint.
  ///
  /// In tr, this message translates to:
  /// **'Kapsam, notlar, bağlantılar…'**
  String get fieldDetailsHint;

  /// No description provided for @fieldStartDate.
  ///
  /// In tr, this message translates to:
  /// **'Başlangıç'**
  String get fieldStartDate;

  /// No description provided for @fieldDueDate.
  ///
  /// In tr, this message translates to:
  /// **'Son tarih'**
  String get fieldDueDate;

  /// No description provided for @fieldDates.
  ///
  /// In tr, this message translates to:
  /// **'Tarihler'**
  String get fieldDates;

  /// No description provided for @fieldResponsible.
  ///
  /// In tr, this message translates to:
  /// **'Sorumlu'**
  String get fieldResponsible;

  /// No description provided for @fieldRequesters.
  ///
  /// In tr, this message translates to:
  /// **'Talep edenler'**
  String get fieldRequesters;

  /// No description provided for @pickDate.
  ///
  /// In tr, this message translates to:
  /// **'Tarih seç'**
  String get pickDate;

  /// No description provided for @addPersonInline.
  ///
  /// In tr, this message translates to:
  /// **'Yeni kişi'**
  String get addPersonInline;

  /// No description provided for @noPeopleYet.
  ///
  /// In tr, this message translates to:
  /// **'Henüz kişi yok. Yeni kişi ekleyebilirsin.'**
  String get noPeopleYet;

  /// No description provided for @defaultColumnTodo.
  ///
  /// In tr, this message translates to:
  /// **'Yapılacak'**
  String get defaultColumnTodo;

  /// No description provided for @defaultColumnDoing.
  ///
  /// In tr, this message translates to:
  /// **'Devam ediyor'**
  String get defaultColumnDoing;

  /// No description provided for @defaultColumnDone.
  ///
  /// In tr, this message translates to:
  /// **'Tamamlandı'**
  String get defaultColumnDone;

  /// No description provided for @projectOpenBoard.
  ///
  /// In tr, this message translates to:
  /// **'Board\'u aç'**
  String get projectOpenBoard;

  /// No description provided for @projectPeople.
  ///
  /// In tr, this message translates to:
  /// **'Kişiler'**
  String get projectPeople;

  /// No description provided for @projectDetails.
  ///
  /// In tr, this message translates to:
  /// **'Detaylar'**
  String get projectDetails;

  /// No description provided for @projectNoDetails.
  ///
  /// In tr, this message translates to:
  /// **'Henüz detay eklenmemiş.'**
  String get projectNoDetails;

  /// No description provided for @projectBoardSummary.
  ///
  /// In tr, this message translates to:
  /// **'Board'**
  String get projectBoardSummary;

  /// No description provided for @projectDeleteBody.
  ///
  /// In tr, this message translates to:
  /// **'\"{title}\" projesi ve tüm board içeriği silinecek.'**
  String projectDeleteBody(String title);

  /// No description provided for @projectChangeStatus.
  ///
  /// In tr, this message translates to:
  /// **'Aşamayı değiştir'**
  String get projectChangeStatus;

  /// No description provided for @projectCreated.
  ///
  /// In tr, this message translates to:
  /// **'Oluşturuldu {date}'**
  String projectCreated(String date);

  /// No description provided for @dueOverdue.
  ///
  /// In tr, this message translates to:
  /// **'{days} gün gecikti'**
  String dueOverdue(int days);

  /// No description provided for @dueToday.
  ///
  /// In tr, this message translates to:
  /// **'Bugün'**
  String get dueToday;

  /// No description provided for @dueTomorrow.
  ///
  /// In tr, this message translates to:
  /// **'Yarın'**
  String get dueTomorrow;

  /// No description provided for @dueInDays.
  ///
  /// In tr, this message translates to:
  /// **'{days} gün kaldı'**
  String dueInDays(int days);

  /// No description provided for @boardAddColumn.
  ///
  /// In tr, this message translates to:
  /// **'Sütun ekle'**
  String get boardAddColumn;

  /// No description provided for @boardColumnName.
  ///
  /// In tr, this message translates to:
  /// **'Sütun adı'**
  String get boardColumnName;

  /// No description provided for @boardAddCard.
  ///
  /// In tr, this message translates to:
  /// **'Kart ekle'**
  String get boardAddCard;

  /// No description provided for @boardCardTitleHint.
  ///
  /// In tr, this message translates to:
  /// **'Kart başlığı, Enter ile ekle'**
  String get boardCardTitleHint;

  /// No description provided for @boardEmptyColumn.
  ///
  /// In tr, this message translates to:
  /// **'Kartı buraya bırak'**
  String get boardEmptyColumn;

  /// No description provided for @boardLabels.
  ///
  /// In tr, this message translates to:
  /// **'Etiketler'**
  String get boardLabels;

  /// No description provided for @columnSettings.
  ///
  /// In tr, this message translates to:
  /// **'Sütun ayarları'**
  String get columnSettings;

  /// No description provided for @columnMoveLeft.
  ///
  /// In tr, this message translates to:
  /// **'Sola taşı'**
  String get columnMoveLeft;

  /// No description provided for @columnMoveRight.
  ///
  /// In tr, this message translates to:
  /// **'Sağa taşı'**
  String get columnMoveRight;

  /// No description provided for @columnWipLimit.
  ///
  /// In tr, this message translates to:
  /// **'WIP limiti'**
  String get columnWipLimit;

  /// No description provided for @columnWipHint.
  ///
  /// In tr, this message translates to:
  /// **'Boş bırakılırsa limitsiz'**
  String get columnWipHint;

  /// No description provided for @columnIsDone.
  ///
  /// In tr, this message translates to:
  /// **'Tamamlanma sütunu'**
  String get columnIsDone;

  /// No description provided for @columnIsDoneHelp.
  ///
  /// In tr, this message translates to:
  /// **'Bu sütuna taşınan kartlar tamamlandı sayılır.'**
  String get columnIsDoneHelp;

  /// No description provided for @columnDeleteBody.
  ///
  /// In tr, this message translates to:
  /// **'\"{name}\" sütunu ve içindeki {count} kart silinecek.'**
  String columnDeleteBody(String name, int count);

  /// No description provided for @columnLastWarning.
  ///
  /// In tr, this message translates to:
  /// **'Board\'da en az bir sütun kalmalı.'**
  String get columnLastWarning;

  /// No description provided for @cardColumn.
  ///
  /// In tr, this message translates to:
  /// **'Sütun'**
  String get cardColumn;

  /// No description provided for @cardDescription.
  ///
  /// In tr, this message translates to:
  /// **'Açıklama'**
  String get cardDescription;

  /// No description provided for @cardDescriptionHint.
  ///
  /// In tr, this message translates to:
  /// **'Açıklama ekle…'**
  String get cardDescriptionHint;

  /// No description provided for @cardLabels.
  ///
  /// In tr, this message translates to:
  /// **'Etiketler'**
  String get cardLabels;

  /// No description provided for @cardChecklist.
  ///
  /// In tr, this message translates to:
  /// **'Kontrol listesi'**
  String get cardChecklist;

  /// No description provided for @cardChecklistHint.
  ///
  /// In tr, this message translates to:
  /// **'Yeni madde ekle'**
  String get cardChecklistHint;

  /// No description provided for @cardDeleteBody.
  ///
  /// In tr, this message translates to:
  /// **'Bu kart ve kontrol listesi silinecek.'**
  String get cardDeleteBody;

  /// No description provided for @cardCompletedOn.
  ///
  /// In tr, this message translates to:
  /// **'Tamamlandı · {date}'**
  String cardCompletedOn(String date);

  /// No description provided for @cardNoLabels.
  ///
  /// In tr, this message translates to:
  /// **'Bu projede henüz etiket yok.'**
  String get cardNoLabels;

  /// No description provided for @labelsManage.
  ///
  /// In tr, this message translates to:
  /// **'Etiketleri yönet'**
  String get labelsManage;

  /// No description provided for @labelNew.
  ///
  /// In tr, this message translates to:
  /// **'Yeni etiket'**
  String get labelNew;

  /// No description provided for @labelName.
  ///
  /// In tr, this message translates to:
  /// **'Etiket adı'**
  String get labelName;

  /// No description provided for @labelDeleteBody.
  ///
  /// In tr, this message translates to:
  /// **'\"{name}\" etiketi tüm kartlardan kaldırılacak.'**
  String labelDeleteBody(String name);

  /// No description provided for @peopleTitle.
  ///
  /// In tr, this message translates to:
  /// **'Kişiler'**
  String get peopleTitle;

  /// No description provided for @peopleEmptyTitle.
  ///
  /// In tr, this message translates to:
  /// **'Kişi listesi boş'**
  String get peopleEmptyTitle;

  /// No description provided for @peopleEmptyBody.
  ///
  /// In tr, this message translates to:
  /// **'Projelere talep eden ve sorumlu atamak için kişi ekle.'**
  String get peopleEmptyBody;

  /// No description provided for @personNew.
  ///
  /// In tr, this message translates to:
  /// **'Yeni kişi'**
  String get personNew;

  /// No description provided for @personEdit.
  ///
  /// In tr, this message translates to:
  /// **'Kişiyi düzenle'**
  String get personEdit;

  /// No description provided for @personName.
  ///
  /// In tr, this message translates to:
  /// **'Ad soyad'**
  String get personName;

  /// No description provided for @personNameRequired.
  ///
  /// In tr, this message translates to:
  /// **'Ad gerekli'**
  String get personNameRequired;

  /// No description provided for @personEmail.
  ///
  /// In tr, this message translates to:
  /// **'E-posta'**
  String get personEmail;

  /// No description provided for @personRole.
  ///
  /// In tr, this message translates to:
  /// **'Rol / birim'**
  String get personRole;

  /// No description provided for @personIsMe.
  ///
  /// In tr, this message translates to:
  /// **'Bu benim'**
  String get personIsMe;

  /// No description provided for @personIsMeHelp.
  ///
  /// In tr, this message translates to:
  /// **'Yeni projelerde varsayılan sorumlu olur.'**
  String get personIsMeHelp;

  /// No description provided for @personMe.
  ///
  /// In tr, this message translates to:
  /// **'Ben'**
  String get personMe;

  /// No description provided for @personStats.
  ///
  /// In tr, this message translates to:
  /// **'{responsible} sorumlu · {requested} talep'**
  String personStats(int responsible, int requested);

  /// No description provided for @personDeleteBody.
  ///
  /// In tr, this message translates to:
  /// **'\"{name}\" silinecek ve projelerdeki atamaları kaldırılacak.'**
  String personDeleteBody(String name);

  /// No description provided for @settingsTitle.
  ///
  /// In tr, this message translates to:
  /// **'Ayarlar'**
  String get settingsTitle;

  /// No description provided for @settingsTheme.
  ///
  /// In tr, this message translates to:
  /// **'Tema'**
  String get settingsTheme;

  /// No description provided for @themeSystem.
  ///
  /// In tr, this message translates to:
  /// **'Sistem'**
  String get themeSystem;

  /// No description provided for @themeLight.
  ///
  /// In tr, this message translates to:
  /// **'Açık'**
  String get themeLight;

  /// No description provided for @themeDark.
  ///
  /// In tr, this message translates to:
  /// **'Koyu'**
  String get themeDark;

  /// No description provided for @settingsData.
  ///
  /// In tr, this message translates to:
  /// **'Veri'**
  String get settingsData;

  /// No description provided for @settingsDataLocal.
  ///
  /// In tr, this message translates to:
  /// **'Tüm veriler yalnızca bu cihazda saklanıyor. Senkronizasyon ileride eklenecek.'**
  String get settingsDataLocal;

  /// No description provided for @settingsAbout.
  ///
  /// In tr, this message translates to:
  /// **'Hakkında'**
  String get settingsAbout;

  /// No description provided for @settingsVersion.
  ///
  /// In tr, this message translates to:
  /// **'Sürüm {version}'**
  String settingsVersion(String version);
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['tr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'tr':
      return AppLocalizationsTr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
