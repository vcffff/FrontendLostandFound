import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:solaifrontend/features/auth/domain/core/failure.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/user_repo.dart';
import '../models/user_model.dart';

class UserRepositoryImpl implements UserRepository {
  final FirebaseAuth _firebaseAuth;

  UserRepositoryImpl({FirebaseAuth? firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  @override
  Future<Either<Failure, UserEntity>> register(String email, String password) async {
    try {
      final cred = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = cred.user;
      if (user == null) {
        return Left(Failure("Registration failed"));
      }

      final entity = UserModel.fromFirebase(user);
      return Right(entity as UserEntity);
    } on FirebaseAuthException catch (e) {
      return Left(Failure(e.message ?? "Firebase error"));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> login(String email, String password) async {
    try {
      final cred = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = cred.user;
      if (user == null) {
        return Left(Failure("Login failed"));
      }

      final entity = UserModel.fromFirebase(user);
      return Right(entity as UserEntity);
    } on FirebaseAuthException catch (e) {
      return Left(Failure(e.message ?? "Firebase error"));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      await _firebaseAuth.signOut();
      return const Right(null);
    } catch (e) {
      return Left(Failure("Logout failed: $e"));
    }
  }
}
