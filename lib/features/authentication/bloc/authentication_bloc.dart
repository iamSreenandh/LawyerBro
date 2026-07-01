import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:lawyer_bro/features/authentication/model/user_model.dart';
import 'package:lawyer_bro/features/authentication/respository/authentication_repo.dart';
import 'package:lawyer_bro/utils/local_storage.dart';
import 'package:meta/meta.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthenticationRepo _authenticationRepo;

  AuthenticationBloc(this._authenticationRepo)
    : super(AuthenticationInitial()) {
    on<AuthenticationSignUpRequested>(_onSignUpRequested);
    on<AuthenticationSignInRequested>(_onSignInRequested);
  }

  Future<void> _onSignUpRequested(
    AuthenticationSignUpRequested event,
    Emitter<AuthenticationState> emit,
  ) async {
    try {
      emit(AuthenticationLoading());

      final userCredential = await _authenticationRepo.createUser(
        email: event.email,
        password: event.password,
      );

      log(userCredential.toString());

      if (userCredential.user != null) {
        final user = UserModel(
          id: userCredential.user?.uid,
          email: userCredential.user?.email,
          name: event.name,
        );
        LocalDB.instance.setUser(user);
        emit(AuthenticationSuccess(user));
      }
    } catch (e) {
      emit(AuthenticationFailure(e.toString()));
    }
  }

  Future<void> _onSignInRequested(
    AuthenticationSignInRequested event,
    Emitter<AuthenticationState> emit,
  ) async {
    try {
      emit(AuthenticationLoading());

      final userCredential = await _authenticationRepo.signIn(
        email: event.email,
        password: event.password,
      );

      if (userCredential.user != null) {
        final user = UserModel(
          id: userCredential.user?.uid,
          email: userCredential.user?.email,
          
        );
        LocalDB.instance.setUser(user);
        emit(AuthenticationSuccess(user));
      }
    } catch (e) {
      emit(AuthenticationFailure(e.toString()));
    }
  }
}
