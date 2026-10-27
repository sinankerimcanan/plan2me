// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Turkish (`tr`).
class AppLocalizationsTr extends AppLocalizations {
  AppLocalizationsTr([String locale = 'tr']) : super(locale);

  @override
  String get appTitle => 'plan2me';

  @override
  String get navProjects => 'Projeler';

  @override
  String get navPeople => 'Kişiler';

  @override
  String get navSettings => 'Ayarlar';

  @override
  String get commonSave => 'Kaydet';

  @override
  String get commonCancel => 'Vazgeç';

  @override
  String get commonDelete => 'Sil';

  @override
  String get commonEdit => 'Düzenle';

  @override
  String get commonAdd => 'Ekle';

  @override
  String get commonClose => 'Kapat';

  @override
  String get commonNone => 'Yok';

  @override
  String get commonClear => 'Temizle';

  @override
  String get commonRetry => 'Tekrar dene';

  @override
  String get commonDeleteTitle => 'Silinsin mi?';

  @override
  String get commonColor => 'Renk';

  @override
  String get commonNotFound => 'Kayıt bulunamadı';

  @override
  String errorGeneric(Object error) {
    return 'Bir şeyler ters gitti: $error';
  }

  @override
  String get priority => 'Öncelik';

  @override
  String get priorityLow => 'Düşük';

  @override
  String get priorityMedium => 'Orta';

  @override
  String get priorityHigh => 'Yüksek';

  @override
  String get priorityCritical => 'Kritik';

  @override
  String get status => 'Aşama';

  @override
  String get statusBacklog => 'Havuz';

  @override
  String get statusPlanned => 'Planlandı';

  @override
  String get statusInProgress => 'Devam ediyor';

  @override
  String get statusOnHold => 'Askıda';

  @override
  String get statusDone => 'Tamamlandı';

  @override
  String get statusCancelled => 'İptal';

  @override
  String get projectsTitle => 'Projelerim';

  @override
  String get projectsSearchHint => 'Proje, kişi veya detay ara';

  @override
  String get projectsEmptyTitle => 'Henüz proje yok';

  @override
  String get projectsEmptyBody => 'İlk projeni oluşturarak planlamaya başla.';

  @override
  String get projectsNoMatch => 'Filtrelere uyan proje yok';

  @override
  String get projectsNew => 'Yeni proje';

  @override
  String get projectsFilters => 'Filtreler';

  @override
  String get projectsShowClosed => 'Kapananları göster';

  @override
  String get projectsClearFilters => 'Filtreleri temizle';

  @override
  String get projectsReorderHint => 'Sıralamak için basılı tutup sürükle';

  @override
  String get sort => 'Sırala';

  @override
  String get sortManual => 'Manuel';

  @override
  String get sortPriority => 'Öncelik';

  @override
  String get sortDueDate => 'Son tarih';

  @override
  String get sortUpdated => 'Son güncellenen';

  @override
  String cardsProgress(int done, int total) {
    return '$done/$total kart';
  }

  @override
  String get projectFormNew => 'Yeni proje';

  @override
  String get projectFormEdit => 'Projeyi düzenle';

  @override
  String get fieldTitle => 'Başlık';

  @override
  String get fieldTitleRequired => 'Başlık gerekli';

  @override
  String get fieldDescription => 'Kısa açıklama';

  @override
  String get fieldDetails => 'Detaylar';

  @override
  String get fieldDetailsHint => 'Kapsam, notlar, bağlantılar…';

  @override
  String get fieldStartDate => 'Başlangıç';

  @override
  String get fieldDueDate => 'Son tarih';

  @override
  String get fieldDates => 'Tarihler';

  @override
  String get fieldResponsible => 'Sorumlu';

  @override
  String get fieldRequesters => 'Talep edenler';

  @override
  String get pickDate => 'Tarih seç';

  @override
  String get addPersonInline => 'Yeni kişi';

  @override
  String get noPeopleYet => 'Henüz kişi yok. Yeni kişi ekleyebilirsin.';

  @override
  String get defaultColumnTodo => 'Yapılacak';

  @override
  String get defaultColumnDoing => 'Devam ediyor';

  @override
  String get defaultColumnDone => 'Tamamlandı';

  @override
  String get projectOpenBoard => 'Board\'u aç';

  @override
  String get projectPeople => 'Kişiler';

  @override
  String get projectDetails => 'Detaylar';

  @override
  String get projectNoDetails => 'Henüz detay eklenmemiş.';

  @override
  String get projectBoardSummary => 'Board';

  @override
  String projectDeleteBody(String title) {
    return '\"$title\" projesi ve tüm board içeriği silinecek.';
  }

  @override
  String get projectChangeStatus => 'Aşamayı değiştir';

  @override
  String projectCreated(String date) {
    return 'Oluşturuldu $date';
  }

  @override
  String dueOverdue(int days) {
    return '$days gün gecikti';
  }

  @override
  String get dueToday => 'Bugün';

  @override
  String get dueTomorrow => 'Yarın';

  @override
  String dueInDays(int days) {
    return '$days gün kaldı';
  }

  @override
  String get boardAddColumn => 'Sütun ekle';

  @override
  String get boardColumnName => 'Sütun adı';

  @override
  String get boardAddCard => 'Kart ekle';

  @override
  String get boardCardTitleHint => 'Kart başlığı, Enter ile ekle';

  @override
  String get boardEmptyColumn => 'Kartı buraya bırak';

  @override
  String get boardLabels => 'Etiketler';

  @override
  String get columnSettings => 'Sütun ayarları';

  @override
  String get columnMoveLeft => 'Sola taşı';

  @override
  String get columnMoveRight => 'Sağa taşı';

  @override
  String get columnWipLimit => 'WIP limiti';

  @override
  String get columnWipHint => 'Boş bırakılırsa limitsiz';

  @override
  String get columnIsDone => 'Tamamlanma sütunu';

  @override
  String get columnIsDoneHelp =>
      'Bu sütuna taşınan kartlar tamamlandı sayılır.';

  @override
  String columnDeleteBody(String name, int count) {
    return '\"$name\" sütunu ve içindeki $count kart silinecek.';
  }

  @override
  String get columnLastWarning => 'Board\'da en az bir sütun kalmalı.';

  @override
  String get cardColumn => 'Sütun';

  @override
  String get cardDescription => 'Açıklama';

  @override
  String get cardDescriptionHint => 'Açıklama ekle…';

  @override
  String get cardLabels => 'Etiketler';

  @override
  String get cardChecklist => 'Kontrol listesi';

  @override
  String get cardChecklistHint => 'Yeni madde ekle';

  @override
  String get cardDeleteBody => 'Bu kart ve kontrol listesi silinecek.';

  @override
  String cardCompletedOn(String date) {
    return 'Tamamlandı · $date';
  }

  @override
  String get cardNoLabels => 'Bu projede henüz etiket yok.';

  @override
  String get labelsManage => 'Etiketleri yönet';

  @override
  String get labelNew => 'Yeni etiket';

  @override
  String get labelName => 'Etiket adı';

  @override
  String labelDeleteBody(String name) {
    return '\"$name\" etiketi tüm kartlardan kaldırılacak.';
  }

  @override
  String get peopleTitle => 'Kişiler';

  @override
  String get peopleEmptyTitle => 'Kişi listesi boş';

  @override
  String get peopleEmptyBody =>
      'Projelere talep eden ve sorumlu atamak için kişi ekle.';

  @override
  String get personNew => 'Yeni kişi';

  @override
  String get personEdit => 'Kişiyi düzenle';

  @override
  String get personName => 'Ad soyad';

  @override
  String get personNameRequired => 'Ad gerekli';

  @override
  String get personEmail => 'E-posta';

  @override
  String get personRole => 'Rol / birim';

  @override
  String get personIsMe => 'Bu benim';

  @override
  String get personIsMeHelp => 'Yeni projelerde varsayılan sorumlu olur.';

  @override
  String get personMe => 'Ben';

  @override
  String personStats(int responsible, int requested) {
    return '$responsible sorumlu · $requested talep';
  }

  @override
  String personDeleteBody(String name) {
    return '\"$name\" silinecek ve projelerdeki atamaları kaldırılacak.';
  }

  @override
  String get settingsTitle => 'Ayarlar';

  @override
  String get settingsTheme => 'Tema';

  @override
  String get themeSystem => 'Sistem';

  @override
  String get themeLight => 'Açık';

  @override
  String get themeDark => 'Koyu';

  @override
  String get settingsData => 'Veri';

  @override
  String get settingsDataLocal =>
      'Tüm veriler yalnızca bu cihazda saklanıyor. Senkronizasyon ileride eklenecek.';

  @override
  String get settingsAbout => 'Hakkında';

  @override
  String settingsVersion(String version) {
    return 'Sürüm $version';
  }

  @override
  String get navTasks => 'Görevler';

  @override
  String get tasksTitle => 'Görevlerim';

  @override
  String get tasksAll => 'Tümü';

  @override
  String get tasksMine => 'Bana atanan';

  @override
  String get tasksShowCompleted => 'Tamamlananları göster';

  @override
  String get tasksEmptyTitle => 'Her şey yolunda';

  @override
  String get tasksEmptyBody =>
      'Bekleyen görevin yok. Aklına geleni hemen ekleyebilirsin.';

  @override
  String get tasksMineEmpty => 'Sana atanmış açık görev yok.';

  @override
  String get tasksNoMe =>
      'Kişiler\'de kendini \"Bu benim\" olarak işaretlersen sana atanan görevleri burada görürsün.';

  @override
  String get taskGroupOverdue => 'Gecikmiş';

  @override
  String get taskGroupToday => 'Bugün';

  @override
  String get taskGroupTomorrow => 'Yarın';

  @override
  String get taskGroupThisWeek => 'Bu hafta';

  @override
  String get taskGroupLater => 'Daha sonra';

  @override
  String get taskGroupNoDate => 'Tarihsiz';

  @override
  String get taskGroupCompleted => 'Tamamlanan';

  @override
  String get taskAdd => 'Görev ekle';

  @override
  String get taskTitleHint => 'Ne yapılacak?';

  @override
  String get taskProject => 'Proje';

  @override
  String get taskMore => 'Daha fazla';

  @override
  String get taskAssignee => 'Sorumlu';

  @override
  String get taskAdded => 'Görev eklendi';

  @override
  String get taskCompletedToast => 'Görev tamamlandı';

  @override
  String get taskReopenedToast => 'Görev yeniden açıldı';

  @override
  String get taskSnoozedToast => 'Yarına ertelendi';

  @override
  String get taskSnooze => 'Yarına ertele';

  @override
  String get taskComplete => 'Tamamla';

  @override
  String get taskReopen => 'Yeniden aç';

  @override
  String get taskDeletedToast => 'Görev silindi';

  @override
  String get inboxTitle => 'Gelen kutusu';

  @override
  String get openInbox => 'Gelen kutusunu aç';

  @override
  String get dateToday => 'Bugün';

  @override
  String get dateTomorrow => 'Yarın';

  @override
  String get dateWeekend => 'Hafta sonu';

  @override
  String get dateNextWeek => 'Gelecek hafta';

  @override
  String get dateNone => 'Tarihsiz';

  @override
  String get recurrence => 'Tekrar';

  @override
  String get recurrenceNone => 'Tekrar yok';

  @override
  String get recurrenceDaily => 'Her gün';

  @override
  String get recurrenceWeekly => 'Her hafta';

  @override
  String get recurrenceMonthly => 'Her ay';

  @override
  String get recurrenceYearly => 'Her yıl';

  @override
  String get undo => 'Geri al';

  @override
  String get navCalendar => 'Takvim';

  @override
  String get calendarTitle => 'Takvim';

  @override
  String get calendarToday => 'Bugün';

  @override
  String get calendarEmptyDay => 'Bu gün için plan yok.';

  @override
  String get calendarTasks => 'Görevler';

  @override
  String get calendarProjectsDue => 'Proje teslimleri';

  @override
  String get calendarFormatMonth => 'Ay';

  @override
  String get calendarFormatTwoWeeks => '2 hafta';

  @override
  String get calendarFormatWeek => 'Hafta';

  @override
  String get addToDeviceCalendar => 'Telefon takvimine ekle';

  @override
  String get deviceCalendarFailed => 'Takvim uygulaması açılamadı.';

  @override
  String deviceCalendarProjectDue(String title) {
    return 'Proje teslimi: $title';
  }

  @override
  String deviceCalendarTaskFrom(String project) {
    return '$project projesinden görev';
  }

  @override
  String get remindersTitle => 'Hatırlatıcılar';

  @override
  String get remindersEnable => 'Hatırlatıcıları aç';

  @override
  String get remindersEnableHelp =>
      'Son tarihi gelen görev ve projeler için bildirim.';

  @override
  String get remindersTime => 'Bildirim saati';

  @override
  String get remindersDayBefore => 'Bir gün önce de hatırlat';

  @override
  String get remindersDigest => 'Günlük özet';

  @override
  String get remindersDigestHelp =>
      'O günün görevleri tek bildirimde toplanır.';

  @override
  String get remindersDenied =>
      'Bildirim izni verilmedi. Ayarlar > plan2me\'den açabilirsin.';

  @override
  String reminderTaskToday(String title) {
    return 'Bugün: $title';
  }

  @override
  String reminderTaskTomorrow(String title) {
    return 'Yarın: $title';
  }

  @override
  String reminderProjectToday(String title) {
    return 'Proje teslimi bugün: $title';
  }

  @override
  String reminderProjectTomorrow(String title) {
    return 'Proje teslimi yarın: $title';
  }

  @override
  String reminderDigestTitle(int count) {
    return 'Bugün $count görevin var';
  }

  @override
  String reminderDigestMore(int count) {
    return 've $count görev daha';
  }

  @override
  String get trashTitle => 'Çöp kutusu';

  @override
  String get trashHelp =>
      'Silinen kayıtlar burada durur; 30 günden eskiler otomatik olarak kalıcı silinir.';

  @override
  String get trashEmptyTitle => 'Çöp kutusu boş';

  @override
  String get trashEmptyAll => 'Çöpü boşalt';

  @override
  String get trashEmptyConfirm =>
      'Çöpteki tüm kayıtlar kalıcı olarak silinecek. Bu işlem geri alınamaz.';

  @override
  String get trashRestore => 'Geri yükle';

  @override
  String get trashRestored => 'Geri yüklendi';

  @override
  String get trashPurge => 'Kalıcı olarak sil';

  @override
  String trashPurgeConfirm(String title) {
    return '\"$title\" kalıcı olarak silinecek. Bu işlem geri alınamaz.';
  }

  @override
  String get trashKindProject => 'Proje';

  @override
  String get trashKindCard => 'Görev';

  @override
  String get trashKindPerson => 'Kişi';

  @override
  String trashDeletedOn(String date) {
    return '$date silindi';
  }

  @override
  String get projectDeletedToast => 'Proje silindi';

  @override
  String get personDeletedToast => 'Kişi silindi';

  @override
  String get backupExport => 'Yedek al';

  @override
  String get backupExportHelp => 'Tüm verileri bir dosyaya kaydet ve paylaş.';

  @override
  String get backupImport => 'Yedekten geri yükle';

  @override
  String get backupImportHelp =>
      'Mevcut verilerin yerine bir yedek dosyası yükle.';

  @override
  String get backupImportConfirmTitle => 'Yedek geri yüklensin mi?';

  @override
  String backupImportConfirmBody(int projects, int cards, int persons) {
    return '$projects proje, $cards görev ve $persons kişi yüklenecek. Cihazdaki mevcut verilerin yerini alacak.';
  }

  @override
  String get backupImported => 'Yedek geri yüklendi';

  @override
  String get backupShareSubject => 'plan2me yedeği';

  @override
  String get shortcutNewTask => 'Görev ekle';

  @override
  String get shortcutTasks => 'Görevlerim';

  @override
  String get shortcutCalendar => 'Takvim';

  @override
  String get shortcutNewProject => 'Yeni proje';

  @override
  String get securityTitle => 'Güvenlik';

  @override
  String get appLockEnable => 'Face ID / şifre ile kilitle';

  @override
  String get appLockHelp =>
      'Açılışta ve 30 saniyeden uzun arka planda kaldıktan sonra kilit ister.';

  @override
  String get appLockUnsupported =>
      'Bu cihazda biyometrik kilit veya ekran şifresi ayarlı değil.';

  @override
  String get appLockReason => 'plan2me\'yi açmak için kimliğini doğrula';

  @override
  String get appLockLocked => 'plan2me kilitli';

  @override
  String get appLockUnlock => 'Kilidi aç';

  @override
  String get location => 'Konum';

  @override
  String get locationAdd => 'Konum ekle';

  @override
  String get locationEdit => 'Konumu değiştir';

  @override
  String get locationRemove => 'Konumu kaldır';

  @override
  String get locationSearchHint => 'Adres veya yer ara';

  @override
  String get locationSearch => 'Ara';

  @override
  String get locationUseCurrent => 'Mevcut konumumu kullan';

  @override
  String locationUseAsTyped(String text) {
    return '\"$text\" olarak kaydet';
  }

  @override
  String get locationNoResults =>
      'Sonuç bulunamadı. Yazdığın adres olduğu gibi kaydedilebilir.';

  @override
  String get locationServiceDisabled => 'Konum servisleri kapalı.';

  @override
  String get locationDenied => 'Konum izni verilmedi.';

  @override
  String get locationDeniedForever =>
      'Konum izni kapalı. Ayarlar > plan2me\'den açabilirsin.';

  @override
  String get locationFailed => 'Konum alınamadı.';

  @override
  String get mapsOpen => 'Haritada aç';

  @override
  String get mapsDirections => 'Yol tarifi';

  @override
  String get mapsChooseApp => 'Harita uygulaması seç';

  @override
  String get mapsNone => 'Bu konumu açabilecek harita uygulaması bulunamadı.';
}
