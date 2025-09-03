import 'package:solaifrontend/features/auth/domain/entities/user_entity.dart';

abstract class AuthState {}

class InitialState extends AuthState {}

class AuthLoading extends AuthState {}

class AuthFailed extends AuthState {
  final String failMessage;
  AuthFailed(this.failMessage);
}

class AuthSuccess extends AuthState {
  final UserEntity user; 
  AuthSuccess(this.user);
}

class Unauthenticated extends AuthState {}

