import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:path/path.dart';
import 'package:users_app/src/data/repositories/employe_repository.dart';
import 'package:users_app/src/domain/entities/employee.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseEmployee implements EmployeRepository {
  @override
  Future<Either<String, String>> createEmploye({
    required Employee data,
    required String idUser,
    required File imageFile,
  }) async {
    String fileName = basename(imageFile.path);
    Reference reference = FirebaseStorage.instance.ref().child(fileName);
    String date = DateTime.now().toString();
    String id = 'cpl-$date-$idUser';
    CollectionReference<Map<String, dynamic>> complaint =
        FirebaseFirestore.instance.collection('employee');
    String downloadUrl = await reference.getDownloadURL();
    await complaint.doc(id).set(
      {
        'name': data.name,
        'idUser': idUser,
        'gender': data.gender,
        'dateOfBirth': data.dateOfBirth,
        'photoUrl': downloadUrl,
      },
    );

    DocumentSnapshot<Map<String, dynamic>> result =
        await complaint.doc(id).get();
    if (result.exists) {
      return right("Success");
    } else {
      return left('failed to create complaint');
    }
  }

  @override
  Future<Either<String, List<Employee>>> getAllEmployee({
    required String uid,
    required String query,
  }) async {
    try {
      CollectionReference<Map<String, dynamic>> tasksRef =
          FirebaseFirestore.instance.collection("employee");

      QuerySnapshot<Map<String, dynamic>> querySnapshot = await tasksRef
          .where('title', isGreaterThanOrEqualTo: query)
          .where('title', isLessThanOrEqualTo: '$query\uf8ff')
          .get();

      List<Employee> data = querySnapshot.docs
          .map((doc) => Employee.fromJson(doc.data()))
          .toList();

      return right(data);
    } catch (e) {
      return left(e.toString());
    }
  }

  @override
  Future<Either<String, Employee>> getEmployee(String uid) {
    throw UnimplementedError();
  }

  @override
  Future<Either<String, String>> updateEmploye(Employee data) {
    throw UnimplementedError();
  }
}
