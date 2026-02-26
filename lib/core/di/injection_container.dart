import 'package:get_it/get_it.dart';

// Auth Imports
import 'package:matger_core_logic/core/auth/repos/auth_repo.dart';
import 'package:matger_core_logic/core/auth/source/auth_source.dart';
import 'package:matger_core_logic/core/auth/repos/test_repo.dart';
import 'package:matger_core_logic/core/auth/source/test_page_source.dart';

// Organization Imports
import 'package:matger_core_logic/core/orgnization/repo/organization_repo.dart';
import 'package:matger_core_logic/core/orgnization/source/organization_source.dart';

// Commerce Imports (Category, Order, Product)
import 'package:matger_core_logic/features/commrec/repo/category_repo.dart';
import 'package:matger_core_logic/features/commrec/source/category_source.dart';
import 'package:matger_core_logic/features/commrec/repo/order_repo.dart';
import 'package:matger_core_logic/features/commrec/source/order_source.dart';
import 'package:matger_core_logic/features/commrec/repo/product_repo.dart';
import 'package:matger_core_logic/features/commrec/source/product_source.dart';

final GetIt sl = GetIt.instance; // sl stands for Service Locator

Future<void> initCoreLocator() async {
  // ==========================================
  // 1. Data Sources
  // ==========================================

  // Auth Source
  sl.registerLazySingleton<AuthSource>(() => AuthSource());
  sl.registerLazySingleton<TestPageSource>(() => TestPageSource());

  // Organization Source
  sl.registerLazySingleton<OrganizationSource>(() => OrganizationSource());

  // Commerce Sources
  sl.registerLazySingleton<CategorySource>(() => CategorySource());
  sl.registerLazySingleton<OrderSource>(() => OrderSource());
  sl.registerLazySingleton<ProductSource>(() => ProductSource());

  // ==========================================
  // 2. Repositories
  // ==========================================

  // Auth Repo
  sl.registerLazySingleton<AuthRepo>(() => AuthRepo(authSource: sl()));
  sl.registerLazySingleton<TestRepo>(() => TestRepo(landingPageSource: sl()));

  // Organization Repo
  sl.registerLazySingleton<OrganizationRepo>(
    () => OrganizationRepo(organizationSource: sl()),
  );

  // Commerce Repos
  sl.registerLazySingleton<CategoryRepo>(
    () => CategoryRepo(categorySource: sl()),
  );
  sl.registerLazySingleton<OrderRepo>(() => OrderRepo(orderSource: sl()));
  sl.registerLazySingleton<ProductRepo>(() => ProductRepo(productSource: sl()));
}
