import 'package:dio/dio.dart';
import 'package:portal_layanan_publik_mobile/core/network/api_client.dart';

/// A test double for [ApiClient] that intercepts all HTTP requests
/// and returns appropriate fake JSON responses immediately — no real
/// network calls, no pending timers.
///
/// It overrides get, post, put, delete directly so Dio's internal
/// fetch (which creates Timers) is bypassed entirely.
class FakeApiClient extends ApiClient {
  FakeApiClient() : super();

  @override
  void setBaseUrl(String url) {}

  @override
  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    return _fakeResponse(path, 'GET');
  }

  @override
  Future<Response> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    return _fakeResponse(path, 'POST');
  }

  @override
  Future<Response> put(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    return _fakeResponse(path, 'PUT');
  }

  @override
  Future<Response> delete(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    return _fakeResponse(path, 'DELETE');
  }

  Response _fakeResponse(String path, String method) {
    Map<String, dynamic> body;

    if (method == 'POST' && path.contains('/pengguna/login')) {
      // Fake login success: return a token so the bloc reaches loginSuccess.
      body = {
        "success": true,
        "data": {"token": "fake-test-token-123"}
      };
    } else if (method == 'GET' && path.contains('/pengguna/profile')) {
      // Fake profile so the profile page shows 'Ahmad Andrawan'.
      body = {
        "success": true,
        "data": {
          "id": 1,
          "username": "Ahmad Andrawan",
          "email": "ahmad@example.com",
          "name": "Ahmad Andrawan"
        }
      };
    } else if (method == 'POST' && path.contains('/pengguna/logout')) {
      body = {"success": true};
    } else {
      // Default: empty list response for all other GET endpoints.
      body = {"data": [], "success": true};
    }

    return Response(
      requestOptions: RequestOptions(path: path),
      statusCode: 200,
      data: body,
    );
  }
}
