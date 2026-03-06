import 'package:bloc/bloc.dart';

import 'auth_event.dart';
import 'auth_state.dart';

/// BLoC d'authentification minimal pour l'application mobile.
/// Il sera branché plus tard sur le repository d'auth et le stockage sécurisé.
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(const AuthState.unknown()) {
    on<AuthCheckRequested>(_onCheckRequested);
    on<AuthLoggedIn>(_onLoggedIn);
    on<AuthLoggedOut>(_onLoggedOut);
  }

  Future<void> _onCheckRequested(
    AuthCheckRequested event,
    Emitter<AuthState> emit,
  ) async {
    // TODO: vérifier la présence d'un token JWT valide en local.
    emit(const AuthState.unauthenticated());
  }

  void _onLoggedIn(
    AuthLoggedIn event,
    Emitter<AuthState> emit,
  ) {
    emit(const AuthState.authenticated());
  }

  void _onLoggedOut(
    AuthLoggedOut event,
    Emitter<AuthState> emit,
  ) {
    emit(const AuthState.unauthenticated());
  }
}

