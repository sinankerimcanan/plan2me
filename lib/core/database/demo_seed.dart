import '../../features/board/domain/board_repository.dart';
import '../../features/people/domain/person.dart';
import '../../features/people/domain/person_repository.dart';
import '../../features/projects/domain/project.dart';
import '../../features/projects/domain/project_repository.dart';
import '../domain/enums.dart';
import '../utils/clock.dart';

/// Geliştirme için örnek veri. Sadece `--dart-define=PLAN2ME_SEED=true` ile
/// ve veritabanı boşken çalışır; üretim derlemesinde hiç çağrılmaz.
const kSeedDemoData = bool.fromEnvironment('PLAN2ME_SEED');

Future<void> seedDemoData({
  required PersonRepository people,
  required ProjectRepository projects,
  required BoardRepository board,
  required List<String> defaultColumns,
}) async {
  if ((await projects.watchOverviews().first).isNotEmpty) return;

  final me = await people.create(
    const PersonInput(
      name: 'Sinan Kerim',
      role: 'Yazılım',
      colorHex: '#7CB342',
      isMe: true,
    ),
  );
  final ayse = await people.create(
    const PersonInput(
      name: 'Ayşe Yılmaz',
      role: 'Pazarlama',
      colorHex: '#FB8C00',
    ),
  );
  final mehmet = await people.create(
    const PersonInput(name: 'Mehmet Demir', role: 'Satış', colorHex: '#1E88E5'),
  );
  final zeynep = await people.create(
    const PersonInput(
      name: 'Zeynep Kaya',
      role: 'Tasarım',
      colorHex: '#8E24AA',
    ),
  );

  final now = today();
  final web = await projects.create(
    ProjectDraft(
      title: 'Kurumsal web sitesi yenileme',
      description: 'Yeni marka kimliğiyle responsive site',
      priority: Priority.high,
      status: ProjectStatus.inProgress,
      startDate: now.subtract(const Duration(days: 10)),
      dueDate: now.add(const Duration(days: 12)),
      responsiblePersonId: me.id,
      requesterIds: [ayse.id, zeynep.id],
      details: 'Kapsam: ana sayfa, ürünler, iletişim.\nCMS: Payload. Yayın öncesi SEO kontrolü yapılacak.',
    ),
    defaultColumns: defaultColumns,
  );
  await projects.create(
    ProjectDraft(
      title: 'Mobil uygulama v2',
      description: 'Bildirimler ve karanlık tema',
      priority: Priority.critical,
      status: ProjectStatus.planned,
      dueDate: now.subtract(const Duration(days: 2)),
      responsiblePersonId: me.id,
      requesterIds: [mehmet.id],
    ),
    defaultColumns: defaultColumns,
  );
  await projects.create(
    ProjectDraft(
      title: 'Bayi portalı raporları',
      priority: Priority.medium,
      status: ProjectStatus.backlog,
      dueDate: now.add(const Duration(days: 30)),
      requesterIds: [mehmet.id, ayse.id],
    ),
    defaultColumns: defaultColumns,
  );
  await projects.create(
    const ProjectDraft(
      title: 'Ofis ağ altyapısı',
      priority: Priority.low,
      status: ProjectStatus.onHold,
    ),
    defaultColumns: defaultColumns,
  );

  final lanes = (await board.watchBoard(web).first).lanes;
  final todo = lanes[0].column.id,
      doing = lanes[1].column.id,
      done = lanes[2].column.id;
  final urgent = await board.createLabel(web, 'Acil', '#E53935');
  final design = await board.createLabel(web, 'Tasarım', '#8E24AA');
  final backend = await board.createLabel(web, 'Backend', '#1E88E5');

  final c1 = await board.addCard(todo, 'İletişim formu e-posta entegrasyonu');
  await board.setCardLabel(c1, backend.id, enabled: true);
  final c2 = await board.addCard(todo, 'Ürün sayfası görselleri');
  await board.setCardLabel(c2, design.id, enabled: true);
  await board.addCard(todo, 'SEO meta etiketleri');
  final c4 = await board.addCard(doing, 'Ana sayfa hero bölümü');
  await board.setCardLabel(c4, design.id, enabled: true);
  await board.setCardLabel(c4, urgent.id, enabled: true);
  for (final t in ['Mobil düzen', 'Animasyonlar', 'Metin onayı']) {
    await board.addChecklistItem(c4, t);
  }
  final detail = (await board.watchCard(c4).first)!;
  await board.setChecklistItemDone(detail.checklist.first.id, done: true);
  final c5 = await board.addCard(doing, 'CMS koleksiyonları');
  await board.setCardLabel(c5, backend.id, enabled: true);
  await board.addCard(done, 'Tasarım sistemi');
  await board.addCard(done, 'Alan adı ve hosting');
}
