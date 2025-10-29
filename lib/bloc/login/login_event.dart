part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object?> get props => [];
}

class EmailChangedEvent extends LoginEvent {
  final String email;

  const EmailChangedEvent({required this.email});

  @override
  List<Object?> get props => [email];
}

class PasswordChangedEvent extends LoginEvent {
  final String password;

  const PasswordChangedEvent({required this.password});

  @override
  List<Object?> get props => [password];
}

class EmailUnFocusedEvent extends LoginEvent {}

class PasswordUnFocusedEvent extends LoginEvent {}

class LoginSubmitEvent extends LoginEvent {}

class TogglePasswordVisibilityEvent extends LoginEvent {}

// TODO: check login auth
class FetchUserEvent extends LoginEvent {}
class UserLogoutEvent extends LoginEvent {}
