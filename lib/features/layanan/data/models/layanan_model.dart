import '../../domain/entities/layanan_entity.dart';

class LayananModel extends LayananEntity {
  const LayananModel({
    required super.id,
    required super.nama,
    required super.deskripsi,
    super.ikonLayanan,
  });

  factory LayananModel.fromJson(Map<String, dynamic> json) {
    final deskripsi = _toString(json['deskripsi']);

    return LayananModel(
      id: _toInt(json['id']),
      nama: _toString(
        json['nama'] ?? json['deskripsi'],
        fallback: 'Tanpa Nama',
      ),
      deskripsi: deskripsi,
      ikonLayanan: _toNullableString(json['ikon_layanan']),
    );
  }

  static int _toInt(dynamic value) {
    if (value is int) return value;
    if (value is String) return int.tryParse(value) ?? 0;
    return 0;
  }

  static String _toString(dynamic value, {String fallback = ''}) {
    if (value == null) return fallback;

    final text = value.toString().trim();
    if (text.isEmpty) return fallback;

    return text;
  }

  static String? _toNullableString(dynamic value) {
    if (value == null) return null;

    final text = value.toString().trim();
    if (text.isEmpty) return null;

    return text;
  }
}