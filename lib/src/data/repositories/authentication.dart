import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:users_app/src/domain/entities/user.dart';

abstract interface class Authentication {
  Future<Either<String, String>> login({
    required String email,
    required String password,
  });
  Future<Either<String, String>> register({
    required String email,
    required String password,
    required String username,
  });

  Future<Either<String, void>> logout();

  String? getLoggedInUserId();

  Future<Either<String, User>> getUser(String uid);

  Future<Either<String, String>> updateUser({
    required String uid,
    required User userData,
    required File imageFile,
  });
}
