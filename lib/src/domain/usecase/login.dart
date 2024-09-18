import 'package:dartz/dartz.dart';
import 'package:users_app/src/data/repositories/authentication.dart';

class Login {
  final Authentication authentication;
  Login(this.authentication);
  Future<Either<String, String>> execute(String email, String password) async {
    return await authentication.login(email: email, password: password);
  }
}
