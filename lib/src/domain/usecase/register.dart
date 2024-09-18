import 'package:dartz/dartz.dart';
import 'package:users_app/src/data/repositories/authentication.dart';

class Register {
  final Authentication authentication;
  Register(this.authentication);
  Future<Either<String, String>> execute({
    required String email,
    required String password,
    required String username,
  }) async {
    return await authentication.register(
      email: email,
      password: password,
      username: username,
    );
  }
}
