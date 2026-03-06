import 'package:equatable/equatable.dart';

enum AuthStatus { unknown, authenticated, unauthenticated }

class AuthState extends Equatable {
  const AuthState({
    this.status = AuthStatus.unknown,
  });

  final AuthStatus status;

  AuthState copyWith({
    AuthStatus? status,
  }) {
    return AuthState(
      status: status ?? this.status,
    );
  }

  const AuthState.unknown() : status = AuthStatus.unknown;
  const AuthState.authenticated() : status = AuthStatus.authenticated;
  const AuthState.unauthenticated() : status = AuthStatus.unauthenticated;

  @override
  List<Object?> get props => [status];
}

