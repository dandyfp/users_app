import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:users_app/src/data/repositories/employe_repository.dart';
import 'package:users_app/src/domain/entities/employee.dart';

class CreateEmployee {
  final EmployeRepository employeRepository;
  CreateEmployee(this.employeRepository);
  Future<Either<String, String>> execute({
    required Employee data,
    required String idUser,
    required File imageFile,
  }) async {
    return await employeRepository.createEmploye(
      data: data,
      idUser: idUser,
      imageFile: imageFile,
    );
  }
}
