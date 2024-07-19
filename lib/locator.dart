import 'package:deliver_it_captin/services/authentication_service.dart';
import 'package:deliver_it_captin/services/firestore_service.dart';

import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => AuthenticationService());
  locator.registerLazySingleton(() => FirestoreService());
}