import '../../domain/entities/informasi_layanan_ulasan_entity.dart';

class InformasiLayananUlasanModel extends InformasiLayananUlasanEntity {
  const InformasiLayananUlasanModel({
    required super.id,
    required super.informasiLayananId,
    required super.rating,
    required super.ulasan,
    required super.dibuatOleh,
    super.dibuatOlehNama,
    super.diubahOleh,
    super.diubahOlehNama,
    super.dibuatPada,
    super.diubahPada,
  });

  factory InformasiLayananUlasanModel.fromJson(Map<String, dynamic> json) {
    final dibuatDetail = _asMap(
      json['dibuat_detail'] ??
          json['dibuat_oleh_detail'] ??
          json['created_by'],
    );
    final diubahDetail = _asMap(
      json['diubah_detail'] ??
          json['diubah_oleh_detail'] ??
          json['updated_by'],
    );

    return InformasiLayananUlasanModel(
      id: _toInt(json['id']),
      informasiLayananId: _toInt(json['informasi_layanan_id']),
      rating: _toInt(json['rating']),
      ulasan: _toString(json['ulasan']),
      dibuatOleh: _toInt(json['dibuat_oleh']),
      dibuatOlehNama: _toNullableString(
        dibuatDetail?['name'] ?? dibuatDetail?['nama'],
      ),
      diubahOleh: json['diubah_oleh'] == null
          ? null
          : _toInt(json['diubah_oleh']),
      diubahOlehNama: _toNullableString(
        diubahDetail?['name'] ?? diubahDetail?['nama'],
      ),
      dibuatPada: _parseDate(json['tgl_dibuat'] ?? json['dibuat_pada']),
      diubahPada: _parseDate(json['tgl_diubah'] ?? json['diubah_pada']),
    );
  }

  static Map<String, dynamic>? _asMap(dynamic value) {
    if (value is Map<String, dynamic>) return value;
    if (value is Map) return Map<String, dynamic>.from(value);
    return null;
  }

  static int _toInt(dynamic value) {
    if (value is int) return value;
    if (value is String) return int.tryParse(value) ?? 0;
    return 0;
  }

  static String _toString(dynamic value, {String fallback = ''}) {
    if (value == null) return fallback;
    final text = value.toString().trim();
    return text.isEmpty ? fallback : text;
  }

  static String? _toNullableString(dynamic value) {
    if (value == null) return null;
    final text = value.toString().trim();
    return text.isEmpty ? null : text;
  }

  static DateTime? _parseDate(dynamic value) {
    if (value == null) return null;
    return DateTime.tryParse(value.toString());
  }
}