import 'package:get_it/get_it.dart';
import 'package:portal_layanan_publik_mobile/core/di/injection_container.dart';
import 'package:portal_layanan_publik_mobile/core/network/api_client.dart';
import 'fake_api_client.dart';

/// Initialise all dependencies for widget tests.
///
/// Same as [setupDependencies] but replaces every [ApiClient] with a
/// [FakeApiClient] so no real HTTP requests are made during tests.
Future<void> setupTestDependencies() async {
  final getIt = GetIt.instance;

  // Register the full dependency graph first
  await setupDependencies();

  // ── Override ApiClients with fakes ──
  // Unregister both real instances, then re-register fakes in-place.

  // Default ApiClient (JSONPlaceholder)
  getIt.unregister<ApiClient>();
  getIt.registerLazySingleton<ApiClient>(() => FakeApiClient());

  // Named "PortalApiClient"
  getIt.unregister<ApiClient>(instanceName: 'PortalApiClient');
  getIt.registerLazySingleton<ApiClient>(
    () => FakeApiClient(),
    instanceName: 'PortalApiClient',
  );
}
