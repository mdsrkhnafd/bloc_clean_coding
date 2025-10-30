part of 'change_password_bloc.dart';

abstract class ChangePasswordEvent extends Equatable {
  const ChangePasswordEvent();

  @override
  List<Object?> get props => [];
}

class PasswordChangedEvent extends ChangePasswordEvent {
  final String password;

  const PasswordChangedEvent({required this.password});

  @override
  List<Object?> get props => [password];
}

class PasswordConfirmChangedEvent extends ChangePasswordEvent {
  final String passwordConfirm;

  const PasswordConfirmChangedEvent({required this.passwordConfirm});

  @override
  List<Object?> get props => [passwordConfirm];
}

class OtpChangedEvent extends ChangePasswordEvent {
  final String otp;

  const OtpChangedEvent({required this.otp});

  @override
  List<Object?> get props => [otp];
}

class ChangePasswordSubmitEvent extends ChangePasswordEvent {
  final String email;

  const ChangePasswordSubmitEvent({required this.email});

  @override
  List<Object?> get props => [email];
}

