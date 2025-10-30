part of 'forgot_password_bloc.dart';

abstract class ForgotPasswordEvent extends Equatable {
  const ForgotPasswordEvent();

  @override
  List<Object?> get props => [];
}

class EmailChangedEvent extends ForgotPasswordEvent {
  final String email;
  const EmailChangedEvent({required this.email});

  @override
  List<Object?> get props => [email];
}

class OtpChangedEvent extends ForgotPasswordEvent {
  final String otp;
  const OtpChangedEvent({required this.otp});

  @override
  List<Object?> get props => [otp];
}

class PasswordChangedEvent extends ForgotPasswordEvent {
  final String password;
  const PasswordChangedEvent({required this.password});

  @override
  List<Object?> get props => [password];
}

class ForgotPasswordSubmitEvent extends ForgotPasswordEvent {
  final String email;
  final String otp;
  final String password;
  const ForgotPasswordSubmitEvent({required this.email, required this.otp, required this.password});

  @override
  List<Object?> get props => [email, otp, password];
}

