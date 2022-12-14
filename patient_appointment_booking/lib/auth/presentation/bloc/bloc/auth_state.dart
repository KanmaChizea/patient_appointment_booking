part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthSignedIn extends AuthState {
  final String uid;
  const AuthSignedIn(
    this.uid,
  );

  @override
  List<Object> get props => [uid];
}

class AuthLoading extends AuthState {}

class AuthSignedOut extends AuthState {}

class AuthFailed extends AuthState {
  final String errorMessage;
  const AuthFailed(
    this.errorMessage,
  );
}
