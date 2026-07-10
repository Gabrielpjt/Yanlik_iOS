import '../../domain/entities/informasi_layanan_entity.dart';

class InformasiLayananModel extends InformasiLayananEntity {
  const InformasiLayananModel({
    required super.id,
    required super.judul,
    required super.deskripsi,
    super.imageUrl,
    super.thumbnailUrl,
    required super.kategoriInformasiLayananId,
    super.kategoriInformasiLayananNama,
    required super.dibuatOleh,
    super.dibuatOlehNama,
    super.diubahOleh,
    super.diubahOlehNama,
    required super.editor,
    super.editorNama,
    super.dibuatPada,
    super.diubahPada,
  });

  factory InformasiLayananModel.fromJson(Map<String, dynamic> json) {
    final kategori = _asMap(json['kategori_informasi_layanan']);

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

    final editorDetail = _asMap(
      json['editor_detail'] ??
          json['editor_by'] ??
          json['edited_by'],
    );

    return InformasiLayananModel(
      id: _toInt(json['id']),
      judul: _toString(json['judul']),
      deskripsi: _toString(json['deskripsi']),
      imageUrl: _toNullableString(json['image_url']),
      thumbnailUrl: _toNullableString(json['thumbnail_url']),
      kategoriInformasiLayananId: _toInt(
        json['kategori_informasi_layanan_id'],
      ),
      kategoriInformasiLayananNama: _toNullableString(
        json['kategori_informasi_layanan_nama'] ?? kategori?['nama'],
      ),
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
      editor: _toInt(json['editor']),
      editorNama: _toNullableString(
        editorDetail?['name'] ?? editorDetail?['nama'],
      ),
      dibuatPada: _parseDate(json['tgl_dibuat'] ?? json['dibuat_pada']),
      diubahPada: _parseDate(json['tgl_diubah'] ?? json['diubah_pada']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'judul': judul,
      'deskripsi': deskripsi,
      'image_url': imageUrl,
      'thumbnail_url': thumbnailUrl,
      'kategori_informasi_layanan_id': kategoriInformasiLayananId,
      'kategori_informasi_layanan_nama': kategoriInformasiLayananNama,
      'dibuat_oleh': dibuatOleh,
      'diubah_oleh': diubahOleh,
      'editor': editor,
      'tgl_dibuat': dibuatPada?.toIso8601String(),
      'tgl_diubah': diubahPada?.toIso8601String(),
    };
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