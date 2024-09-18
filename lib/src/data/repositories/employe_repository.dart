import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:users_app/src/domain/entities/employee.dart';

abstract class EmployeRepository {
  Future<Either<String, String>> createEmploye({
    required Employee data,
    required String idUser,
    required File imageFile,
  });
  Future<Either<String, String>> updateEmploye(Employee data);
  Future<Either<String, Employee>> getEmployee(String uid);
  Future<Either<String, List<Employee>>> getAllEmployee({
    required String uid,
    required String query,
  });
}
