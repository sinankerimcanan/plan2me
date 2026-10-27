# plan2me

Kişisel proje, görev ve Kanban planlama uygulaması.

**Özellikler**
- **Projeler:** öncelik, aşama, talep edenler, sorumlu, tarihler, detaylar; filtre, arama, elle sıralama
- **Kanban board:** sürükle-bırak, WIP limiti, tamamlanma sütunu, etiketler, kontrol listesi
- **Görevlerim:** tüm projelerdeki görevler gecikmiş / bugün / yarın / bu hafta / sonra gruplarında;
  kaydırarak tamamla veya ertele, "Bana atanan" filtresi, her işlemde "Geri al"
- **Hızlı ekleme ve Gelen kutusu:** projesiz görevler için; Bugün / Yarın / Hafta sonu kısayolları
- **Kart sorumlusu ve tekrarlayan görevler:** her gün / hafta / ay / yıl; tamamlanınca sonraki tekrar oluşur
- **Takvim:** ay / 2 hafta / hafta görünümü; telefondaki etkinlikler de görünür
- **Telefon takvimiyle eşitleme:** tarihli görevler ve proje teslimleri telefonda "plan2me"
  takviminde tutulur; değişince güncellenir, tamamlanınca kaldırılır
- **Konum ve haritalar:** görev/projeye adresle ya da mevcut konumla yer ekleme; Apple Haritalar,
  Google Haritalar, Yandex veya Waze'de açma ve yol tarifi
- **Hatırlatıcılar:** son gün ve bir gün önce bildirim, günlük özet, seçilebilir saat
- **Çöp kutusu ve yedek:** silineni geri alma, JSON yedek alma / geri yükleme
- **iOS widget'ları:** proje özeti ve Görevlerim (widget'tan dokunarak tamamlama), kilit ekranı türleri
- **Ana ekran kısayolları** ve **Face ID / şifre kilidi**
- Liquid cam arayüz, açık (yeşil-sarımtırak) ve koyu tema, Türkçe

**Faz 1:** Mobil öncelikli (iOS/Android), veriler cihazda SQLite'ta.
**Faz 2 (planlı):** Backend senkronizasyonu ve web arayüzü.

## Kurulum

Bu proje Flutter **3.47.8**'e [FVM](https://fvm.app) ile sabitlenmiştir
(`.fvmrc`). Makinedeki global Flutter sürümü etkilenmez.

```bash
brew tap leoafarias/fvm && brew install fvm   # bir kez
fvm install                                   # .fvmrc'deki sürümü indirir
fvm flutter pub get
fvm dart run build_runner build               # Drift, Riverpod, freezed kodları
fvm flutter run
```

VS Code `.vscode/settings.json` üzerinden FVM SDK'sını otomatik kullanır.
Projede tüm komutlar `fvm flutter ...` / `fvm dart ...` ile çalıştırılır.

### Örnek veriyle çalıştırma

```bash
fvm flutter run --dart-define=PLAN2ME_SEED=true
```

Veritabanı boşsa örnek kişi, proje ve kartlar eklenir. Bu modda uygulama
klasöründeki `Documents/dev_start_route.txt` dosyası varsa (ör. `/people`)
uygulama o ekrandan açılır. Normal ve release derlemelerde ikisi de devre dışıdır.

## Mimari

Feature-first **MVVM** + **Riverpod 3** (codegen).

```
lib/
  core/        veritabanı, tema, router, l10n, ortak widget'lar, yardımcılar
  features/
    people/    domain (model + repository arayüzü) · data (Drift) · presentation (VM + ekran)
    projects/
    board/     sütun, kart, checklist, etiket
    settings/
  l10n/        app_tr.arb (Türkçe; yeni dil = yeni ARB dosyası)
```

| Katman | Sorumluluk |
|---|---|
| Model | `domain/` içindeki freezed sınıflar |
| Repository | `domain/*_repository.dart` arayüzü, `data/drift_*_repository.dart` uygulaması |
| ViewModel | `presentation/*_view_model.dart`, `@riverpod` Notifier sınıfları |
| View | `ConsumerWidget` ekranlar, sadece VM'i izler ve niyet metodlarını çağırır |

Repository'ler `data/*_providers.dart` içinde bağlanır. Faz 2'de bu provider'lar
override edilerek uzak/senkron uygulamaya geçilir; ViewModel ve ekranlar değişmez.

### Veri ve senkron hazırlığı

- Tüm tablolarda `id` (UUID v7), `created_at`, `updated_at`, `deleted_at`, `version`.
- Silme işlemi soft delete'tir ve alt kayıtlara transaction içinde yayılır.
- Sıralama `REAL` pozisyonla yapılır (araya ekleme ortalama alır, gerekirse yeniden numaralandırılır).
- Tarihler ISO-8601 UTC metin olarak saklanır (`build.yaml`).
- "Tamamlanma sütunu"na taşınan kart `completed_at` alır; proje ilerlemesi buradan hesaplanır.

### Web

`web/sqlite3.wasm` ve `web/drift_worker.js`, `pubspec.lock`'taki drift sürümüyle
eşleşmelidir. drift güncellendiğinde
[drift release](https://github.com/simolus3/drift/releases) sayfasından yeniden indirin.
En hızlı depolama (OPFS) için sunucu şu başlıkları vermelidir; yoksa IndexedDB kullanılır:

```
Cross-Origin-Opener-Policy: same-origin
Cross-Origin-Embedder-Policy: require-corp
```

## iOS ana ekran widget'ı

`ios/Plan2meWidget` altında SwiftUI/WidgetKit widget'ı (iOS 17+):

- plan2me: küçük (aktif proje + gecikmiş), orta (öncelikli 3 proje), büyük (projeler + yaklaşan kartlar).
- Görevlerim: yaklaşan ve gecikmiş görevler; daireye dokununca görev uygulama açılmadan tamamlanır
  (iOS App Intent). Tamamlama uygulama bir sonraki açılışta/öne gelişte veritabanına işlenir.
- Kilit ekranı: dairesel, dikdörtgen ve satır içi.
- Her proje ve karta dokununca uygulamada ilgili ekran açılır (`plan2me://app/...`).

Veri akışı: `lib/features/home_widget` proje/kart verisi değişince özet JSON'u
App Group'a (`group.krx.plan2me.app`) yazar ve widget'ı yeniler. Göreli tarihler
("2 gün kaldı") widget tarafında hesaplanır ve gece yarısı kendiliğinden güncellenir.

Gerçek cihazda ilk kurulumdan önce Xcode'da `ios/Runner.xcworkspace` açılıp
Runner ve Plan2meWidget hedeflerinde **Signing & Capabilities > App Groups**
altında `group.krx.plan2me.app` grubunun etkin olduğu bir kez kontrol edilmelidir
(otomatik imzalama grubu Apple Developer hesabına kaydeder).

Widget hedefi `tool/ios/add_widget_target.rb` ile eklendi; proje sıfırdan
oluşturulursa bu betik tekrar çalıştırılabilir.

## Uygulama ikonu ve kısayol simgeleri

```bash
python3 tool/generate_icon.py && fvm dart run flutter_launcher_icons
python3 tool/generate_shortcut_icons.py
```

## Veritabanı şeması değişikliği

Tablolarda değişiklik yaptıktan sonra `schemaVersion`'ı artırın ve:

```bash
fvm dart run build_runner build
fvm dart run drift_dev make-migrations
```

Bu komut şema anlık görüntüsünü, adım adım migration yardımcısını ve
migration testlerini üretir. Yeni adımı `app_database.dart` içindeki
`stepByStep`'e ekleyin.

## Test

```bash
fvm flutter analyze
fvm flutter test
```

Testler bellek içi SQLite ile repository'leri, mocktail ile board ViewModel'ini ve
widget testiyle board üzerinde sürükle-bırakı kapsar.
