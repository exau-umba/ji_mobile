import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

/// Vérifie si l'utilisateur est déjà authentifié (token présent en local, etc.).
class AuthCheckRequested extends AuthEvent {
  const AuthCheckRequested();
}

/// L'utilisateur vient de se connecter avec succès.
class AuthLoggedIn extends AuthEvent {
  const AuthLoggedIn();
}

/// L'utilisateur s'est déconnecté.
class AuthLoggedOut extends AuthEvent {
  const AuthLoggedOut();
}

