import '../../../../core/errors/failure.dart';
import '../entities/informasi_layanan_entity.dart';
import '../entities/informasi_layanan_ulasan_entity.dart';
import '../entities/ulasan_aggregasi_entity.dart';

abstract class InformasiLayananRepository {
  Future<(List<InformasiLayananEntity>?, Failure?)> getInformasiLayanan({
    int page = 1,
    int limit = 5,
    String? query,
  });

  Future<(InformasiLayananEntity?, Failure?)> getInformasiLayananById(int id);

  Future<(List<InformasiLayananUlasanEntity>?, Failure?)>
  getUlasanInformasiLayanan(int informasiLayananId);

  Future<(UlasanAggregasiEntity?, Failure?)> getUlasanAggregasi(
      int informasiLayananId,
      );
}