import '../../domain/entities/ulasan_aggregasi_entity.dart';

class UlasanAggregasiModel extends UlasanAggregasiEntity {
  const UlasanAggregasiModel({
    required super.informasiLayananId,
    required super.totalUlasan,
    required super.rataRataRating,
    required super.distribusiRating,
  });

  factory UlasanAggregasiModel.fromJson(Map<String, dynamic> json) {
    final rawDistribusi = json['distribusi_rating'];

    return UlasanAggregasiModel(
      informasiLayananId: _toInt(json['informasi_layanan_id']),
      totalUlasan: _toInt(json['total_ulasan']),
      rataRataRating: _toDouble(json['rata_rata_rating']),
      distribusiRating: rawDistribusi is Map
          ? rawDistribusi.map(
            (key, value) => MapEntry(
          key.toString(),
          _toInt(value),
        ),
      )
          : const {},
    );
  }

  static int _toInt(dynamic value) {
    if (value is int) return value;
    if (value is String) return int.tryParse(value) ?? 0;
    return 0;
  }

  static double _toDouble(dynamic value) {
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) return double.tryParse(value) ?? 0;
    return 0;
  }
}