import 'package:dio/dio.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/network/api_exceptions.dart';
import '../../domain/entities/informasi_layanan_entity.dart';
import '../../domain/entities/informasi_layanan_ulasan_entity.dart';
import '../../domain/entities/ulasan_aggregasi_entity.dart';
import '../../domain/repositories/informasi_layanan_repository.dart';
import '../datasources/informasi_layanan_remote_datasource.dart';

class InformasiLayananRepositoryImpl implements InformasiLayananRepository {
  final InformasiLayananRemoteDatasource _remoteDatasource;

  InformasiLayananRepositoryImpl(this._remoteDatasource);

  @override
  Future<(List<InformasiLayananEntity>?, Failure?)> getInformasiLayanan({
    int page = 1,
    int limit = 5,
    String? query,
  }) async {
    try {
      final items = await _remoteDatasource.getInformasiLayanan(
        page: page,
        limit: limit,
        query: query,
      );

      return (items.cast<InformasiLayananEntity>(), null);
    } on DioException catch (e) {
      return (null, ApiExceptions.fromDioError(e));
    } catch (e) {
      return (null, ServerFailure('Unexpected error: $e'));
    }
  }

  @override
  Future<(InformasiLayananEntity?, Failure?)> getInformasiLayananById(
      int id,
      ) async {
    try {
      final item = await _remoteDatasource.getInformasiLayananById(id);
      return (item, null);
    } on DioException catch (e) {
      return (null, ApiExceptions.fromDioError(e));
    } catch (e) {
      return (null, ServerFailure('Unexpected error: $e'));
    }
  }

  @override
  Future<(List<InformasiLayananUlasanEntity>?, Failure?)>
  getUlasanInformasiLayanan(int informasiLayananId) async {
    try {
      final items = await _remoteDatasource.getUlasanInformasiLayanan(
        informasiLayananId,
      );

      return (items.cast<InformasiLayananUlasanEntity>(), null);
    } on DioException catch (e) {
      return (null, ApiExceptions.fromDioError(e));
    } catch (e) {
      return (null, ServerFailure('Unexpected error: $e'));
    }
  }

  @override
  Future<(UlasanAggregasiEntity?, Failure?)> getUlasanAggregasi(
      int informasiLayananId,
      ) async {
    try {
      final item = await _remoteDatasource.getUlasanAggregasi(
        informasiLayananId,
      );

      return (item, null);
    } on DioException catch (e) {
      return (null, ApiExceptions.fromDioError(e));
    } catch (e) {
      return (null, ServerFailure('Unexpected error: $e'));
    }
  }
}