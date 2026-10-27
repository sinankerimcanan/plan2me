import 'package:uuid/uuid.dart';

const _uuid = Uuid();

/// Zamana göre sıralanabilir UUID v7 üretir. Tüm varlık kimlikleri buradan gelir,
/// böylece ileride backend senkronunda istemci tarafında üretilen id'ler çakışmaz.
String newId() => _uuid.v7();
