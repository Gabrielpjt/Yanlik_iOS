import '../../../../core/network/api_client.dart';
import '../models/informasi_layanan_model.dart';
import '../models/informasi_layanan_ulasan_model.dart';
import '../models/ulasan_aggregasi_model.dart';

class InformasiLayananRemoteDatasource {
  final ApiClient _apiClient;

  InformasiLayananRemoteDatasource(this._apiClient);

  Future<List<InformasiLayananModel>> getInformasiLayanan({
    int page = 1,
    int limit = 5,
    String? query,
  }) async {
    final response = await _apiClient.get(
      '/publik/kategori-informasi-layanan/preload',
    );

    final categories = _extractList(response.data);
    final items = <InformasiLayananModel>[];

    for (final categoryJson in categories) {
      if (categoryJson is! Map) {
        continue;
      }

      final category = Map<String, dynamic>.from(categoryJson);
      final categoryId = _toInt(category['id']);
      final categoryName = _toString(category['nama'], fallback: '-');

      final rawInformasi = category['informasi_layanan'];

      if (rawInformasi is! List) {
        continue;
      }

      for (final infoJson in rawInformasi) {
        if (infoJson is! Map) {
          continue;
        }

        final info = Map<String, dynamic>.from(infoJson);

        info['kategori_informasi_layanan_id'] =
            info['kategori_informasi_layanan_id'] ?? categoryId;
        info['kategori_informasi_layanan_nama'] = categoryName;

        items.add(InformasiLayananModel.fromJson(info));
      }
    }

    var filteredItems = items;

    if (query != null && query.trim().isNotEmpty) {
      final keyword = query.trim().toLowerCase();

      filteredItems = items.where((item) {
        return item.judul.toLowerCase().contains(keyword) ||
            item.deskripsi.toLowerCase().contains(keyword) ||
            (item.kategoriInformasiLayananNama ?? '')
                .toLowerCase()
                .contains(keyword);
      }).toList();
    }

    return filteredItems;
  }

  Future<InformasiLayananModel> getInformasiLayananById(int id) async {
    final response = await _apiClient.get('/publik/informasi-layanan/$id');
    final Map<String, dynamic> body = response.data as Map<String, dynamic>;

    return InformasiLayananModel.fromJson(
      body['data'] as Map<String, dynamic>,
    );
  }

  Future<List<InformasiLayananUlasanModel>> getUlasanInformasiLayanan(
      int informasiLayananId,
      ) async {
    final response = await _apiClient.get(
      '/publik/informasi-layanan/$informasiLayananId/ulasan',
    );

    final data = _extractList(response.data);

    return data
        .map(
          (json) => InformasiLayananUlasanModel.fromJson(
        json as Map<String, dynamic>,
      ),
    )
        .toList();
  }

  Future<UlasanAggregasiModel> getUlasanAggregasi(
      int informasiLayananId,
      ) async {
    final response = await _apiClient.get(
      '/publik/informasi-layanan/$informasiLayananId/ulasan/aggregasi',
    );

    final Map<String, dynamic> body = response.data as Map<String, dynamic>;
    final data = body['data'];

    if (data is Map<String, dynamic>) {
      return UlasanAggregasiModel.fromJson(data);
    }

    if (data is Map) {
      return UlasanAggregasiModel.fromJson(
        Map<String, dynamic>.from(data),
      );
    }

    return const UlasanAggregasiModel(
      informasiLayananId: 0,
      totalUlasan: 0,
      rataRataRating: 0,
      distribusiRating: {},
    );
  }

  List<dynamic> _extractList(dynamic responseData) {
    if (responseData is! Map<String, dynamic>) {
      return [];
    }

    final bodyData = responseData['data'];

    if (bodyData is List) {
      return bodyData;
    }

    if (bodyData is Map<String, dynamic>) {
      if (bodyData['items'] is List) {
        return bodyData['items'] as List<dynamic>;
      }

      if (bodyData['data'] is List) {
        return bodyData['data'] as List<dynamic>;
      }
    }

    return [];
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
}