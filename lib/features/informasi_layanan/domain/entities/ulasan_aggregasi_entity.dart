import 'package:equatable/equatable.dart';

class UlasanAggregasiEntity extends Equatable {
  final int informasiLayananId;
  final int totalUlasan;
  final double rataRataRating;
  final Map<String, int> distribusiRating;

  const UlasanAggregasiEntity({
    required this.informasiLayananId,
    required this.totalUlasan,
    required this.rataRataRating,
    required this.distribusiRating,
  });

  @override
  List<Object?> get props => [
    informasiLayananId,
    totalUlasan,
    rataRataRating,
    distribusiRating,
  ];
}