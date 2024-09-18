import 'package:get_it/get_it.dart';
import 'package:users_app/src/data/firebase/firebase_authentication.dart';
import 'package:users_app/src/data/repositories/authentication.dart';
import 'package:users_app/src/domain/usecase/login.dart';
import 'package:users_app/src/domain/usecase/register.dart';
import 'package:users_app/src/presentation/features/auth/bloc/login/login_bloc.dart';
import 'package:users_app/src/presentation/features/auth/bloc/register/register_bloc.dart';

final locator = GetIt.instance;

Future<void> initLocator() async {
  // Bloc
  locator.registerFactory(() => LoginBloc(locator()));
  locator.registerFactory(() => RegisterBloc(locator()));

  // Usecase
  locator.registerLazySingleton(() => Login(locator()));
  locator.registerLazySingleton(() => Register(locator()));

  // Datasource
  locator.registerLazySingleton<Authentication>(() => FirebaseAuthentication());
}
