part of 'login_bloc.dart';

class LoginState extends Equatable {
  final UserModel? user;
  final String email;
  final String password;
  final String message;
  final PostApiStatus loginStatus;
  final bool isPasswordVisible;
  final bool isLoggedIn; // ✅ New flag
  const LoginState({
    this.user,
    this.email = '',
    this.password = '',
    this.message = '',
    this.loginStatus = PostApiStatus.initial, // ✅ correct default
    this.isPasswordVisible = false,
    this.isLoggedIn = false, // ✅ correct default
  });

  LoginState copyWith({
    UserModel? user,
    String? email,
    String? password,
    String? message,
    PostApiStatus? loginStatus,
    bool? isPasswordVisible,
    bool? isLoggedIn,
  }) {
    return LoginState(
      user: user ?? this.user,
      email: email ?? this.email,
      password: password ?? this.password,
      message: message ?? this.message,
      loginStatus: loginStatus ?? this.loginStatus,
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
    );
  }

  @override
  List<Object?> get props => [
    user,
    email,
    password,
    message,
    loginStatus,
    isPasswordVisible,
    isLoggedIn,
  ];
}
