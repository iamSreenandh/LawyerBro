part of 'authentication_bloc.dart';

@immutable
sealed class AuthenticationEvent {}

class AuthenticationSignUpRequested extends AuthenticationEvent {
  final String email;
  final String password;
  final String name;
  AuthenticationSignUpRequested({
    required this.email,
    required this.password,
    required this.name,
  });
}

class AuthenticationSignInRequested extends AuthenticationEvent {
  final String email;
  final String password;
  AuthenticationSignInRequested({required this.email, required this.password});
}
