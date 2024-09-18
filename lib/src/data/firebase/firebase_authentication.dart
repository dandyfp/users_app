import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'package:users_app/src/data/repositories/authentication.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:users_app/src/domain/entities/user.dart';

class FirebaseAuthentication implements Authentication {
  final firebase_auth.FirebaseAuth _firebaseAuth;

  FirebaseAuthentication({firebase_auth.FirebaseAuth? firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance;

  @override
  String? getLoggedInUserId() => _firebaseAuth.currentUser?.uid;

  @override
  Future<Either<String, String>> login({
    required String email,
    required String password,
  }) async {
    try {
      var userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return right(userCredential.user!.uid);
    } on firebase_auth.FirebaseException catch (e) {
      return left(e.message!);
    }
  }

  @override
  Future<Either<String, String>> register({
    required String email,
    required String password,
    required String username,
  }) async {
    try {
      var userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (userCredential.user?.uid != null) {
        CollectionReference<Map<String, dynamic>> users =
            FirebaseFirestore.instance.collection("users");
        await users.doc(userCredential.user?.uid).set({
          'uid': userCredential.user?.uid,
          'name': username,
          'email': email,
          'imageProfile': '',
          'dateOfbirth': '',
          'gender': '',
        });
      }
      return right(userCredential.user!.uid);
    } on firebase_auth.FirebaseAuthException catch (e) {
      return left("${e.message}");
    }
  }

  @override
  Future<Either<String, void>> logout() async {
    await _firebaseAuth.signOut();
    if (_firebaseAuth.currentUser == null) {
      return right(null);
    } else {
      return left("failed to sign out");
    }
  }

  @override
  Future<Either<String, User>> getUser(String uid) async {
    DocumentReference<Map<String, dynamic>> documentReference =
        FirebaseFirestore.instance.doc('users/$uid');

    DocumentSnapshot<Map<String, dynamic>> result =
        await documentReference.get();
    if (result.exists) {
      return right(User.fromJson(result.data()!));
    } else {
      return const Left('User not found');
    }
  }

  @override
  Future<Either<String, String>> updateUser({
    required String uid,
    required User userData,
    required File imageFile,
  }) async {
    try {
      String fileName = basename(imageFile.path);
      Reference reference = FirebaseStorage.instance.ref().child(fileName);
      DocumentReference<Map<String, dynamic>> documentReference =
          FirebaseFirestore.instance.doc('users/$uid');
      String downloadUrl = await reference.getDownloadURL();
      await documentReference.update({
        "email": userData.email,
        "username": userData.name,
        'imageProfile': downloadUrl,
        'dateOfbirth': userData.dateOfBirth,
        'gender': userData.gender,
      });
      return right("Success update data");
    } catch (e) {
      return left(e.toString());
    }
  }
}
