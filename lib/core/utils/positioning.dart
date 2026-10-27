/// Sürükle-bırak sıralaması için REAL pozisyon hesaplama.
///
/// Araya ekleme komşuların ortalamasıdır; sona/başa ekleme [kPositionStep] kadar
/// uzaklaşır. Aralık [kMinPositionGap] altına düşerse liste yeniden numaralandırılır.
library;

const double kPositionStep = 1024;
const double kMinPositionGap = 1e-6;

/// Pozisyonu olan bir kardeş öğe.
typedef Positioned = ({String id, double position});

/// [siblings] taşınan öğe HARİÇ, pozisyona göre sıralı kardeşlerdir.
/// [beforeId] null ise öğe sona eklenir, aksi halde o öğenin hemen önüne.
double positionBefore(List<Positioned> siblings, String? beforeId) {
  if (siblings.isEmpty) return kPositionStep;
  final index =
      beforeId == null ? -1 : siblings.indexWhere((s) => s.id == beforeId);
  if (index < 0) return siblings.last.position + kPositionStep;
  if (index == 0) return siblings.first.position - kPositionStep;
  return (siblings[index - 1].position + siblings[index].position) / 2;
}

/// Sona ekleme pozisyonu.
double positionAtEnd(Iterable<double> positions) {
  if (positions.isEmpty) return kPositionStep;
  return positions.reduce((a, b) => a > b ? a : b) + kPositionStep;
}

/// Başa ekleme pozisyonu.
double positionAtStart(Iterable<double> positions) {
  if (positions.isEmpty) return kPositionStep;
  return positions.reduce((a, b) => a < b ? a : b) - kPositionStep;
}

/// Sıralı pozisyonlarda iki komşu arası fark çok küçüldüyse true.
bool needsRenormalize(List<double> sortedPositions) {
  for (var i = 1; i < sortedPositions.length; i++) {
    if ((sortedPositions[i] - sortedPositions[i - 1]).abs() < kMinPositionGap) {
      return true;
    }
  }
  return false;
}

/// [count] öğe için eşit aralıklı yeni pozisyonlar.
List<double> renormalized(int count) =>
    [for (var i = 0; i < count; i++) (i + 1) * kPositionStep];

/// ReorderableListView (oldIndex, newIndex) çiftini "şu id'nin önüne" biçimine çevirir.
/// [ids] taşımadan önceki sıradır. Dönen null, "sona taşı" demektir.
String? beforeIdForReorder(List<String> ids, int oldIndex, int newIndex) {
  final without = [...ids]..removeAt(oldIndex);
  final target = newIndex > oldIndex ? newIndex - 1 : newIndex;
  return target >= without.length ? null : without[target];
}
