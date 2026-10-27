# plan2me

Kişisel proje takibi ve Kanban planlama uygulaması. Jira mantığında projeler
(öncelik, aşama, talep edenler, sorumlu, tarihler, detay) ve her projeye bağlı
Trello benzeri bir board.

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

## Test

```bash
fvm flutter analyze
fvm flutter test
```

Testler bellek içi SQLite ile repository'leri, mocktail ile board ViewModel'ini ve
widget testiyle board üzerinde sürükle-bırakı kapsar.
