import 'package:equatable/equatable.dart';

class InformasiLayananUlasanEntity extends Equatable {
  final int id;
  final int informasiLayananId;
  final int rating;
  final String ulasan;
  final int dibuatOleh;
  final String? dibuatOlehNama;
  final int? diubahOleh;
  final String? diubahOlehNama;
  final DateTime? dibuatPada;
  final DateTime? diubahPada;

  const InformasiLayananUlasanEntity({
    required this.id,
    required this.informasiLayananId,
    required this.rating,
    required this.ulasan,
    required this.dibuatOleh,
    this.dibuatOlehNama,
    this.diubahOleh,
    this.diubahOlehNama,
    this.dibuatPada,
    this.diubahPada,
  });

  @override
  List<Object?> get props => [
    id,
    informasiLayananId,
    rating,
    ulasan,
    dibuatOleh,
    dibuatOlehNama,
    diubahOleh,
    diubahOlehNama,
    dibuatPada,
    diubahPada,
  ];
}