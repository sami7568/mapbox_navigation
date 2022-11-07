import 'package:eztransport/core/enums/env.dart';
import 'package:eztransport/core/services/api_services.dart';
import 'package:eztransport/core/services/auth_service.dart';
import 'package:eztransport/core/services/database_service.dart';
import 'package:eztransport/core/services/local_storage_service.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;
setupLocator(Env env) async {
  locator.registerSingleton(LocalStorageService());
  locator.registerSingleton<ApiServices>(ApiServices());
  locator.registerLazySingleton<DatabaseService>(() => DatabaseService());
  locator.registerSingleton<AuthService>(AuthService());
}
