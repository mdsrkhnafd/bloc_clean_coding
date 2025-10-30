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


class ForgotPasswordSubmitEvent extends ForgotPasswordEvent {
  final String email;

  const ForgotPasswordSubmitEvent({required this.email});

  @override
  List<Object?> get props => [email];
}

