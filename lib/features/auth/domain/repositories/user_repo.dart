import 'package:dartz/dartz.dart';
import 'package:solaifrontend/features/auth/data/models/User_model.dart';
import 'package:solaifrontend/features/auth/domain/core/failure.dart';
import '../entities/user_entity.dart';


abstract class UserRepository {
  Future<Either<Failure, UserEntity>> register(String email, String password);
  Future<Either<Failure, UserEntity>> login(String email, String password);
  Future<Either<Failure, void>> logout();
}
