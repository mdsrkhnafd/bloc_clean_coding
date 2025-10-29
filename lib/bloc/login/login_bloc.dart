import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../data/exceptions/app_exceptions.dart';
import '../../data/response/enums.dart';
import '../../models/user/user_model.dart';
import '../../repository/auth/login_repository.dart';
import '../../services/app_storage/app_storage.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  // TODO: Add LoginRepository
  LoginRepository loginRepository;
  // TODO: Add dependency injection
  LoginBloc({required this.loginRepository}) : super(LoginState()) {
    on<EmailChangedEvent>(_onEmailChanged);
    on<PasswordChangedEvent>(_onPasswordChanged);
    on<LoginSubmitEvent>(_onLoginSubmit);
    on<TogglePasswordVisibilityEvent>(_onTogglePasswordVisibility);
    on<FetchUserEvent>(_onFetchUser);
    on<UserLogoutEvent>(_onUserLogout);
  }

  void _onEmailChanged(EmailChangedEvent event, Emitter<LoginState> emit) {
    emit(state.copyWith(email: event.email.trim()));
  }

  void _onPasswordChanged(
    PasswordChangedEvent event,
    Emitter<LoginState> emit,
  ) {
    emit(state.copyWith(password: event.password.trim()));
  }

  void _onTogglePasswordVisibility(
    TogglePasswordVisibilityEvent event,
    Emitter<LoginState> emit,
  ) {
    emit(state.copyWith(isPasswordVisible: !state.isPasswordVisible));
  }

  // TODO: call apis
  Future<void> _onLoginSubmit(
      LoginSubmitEvent event,
      Emitter<LoginState> emit,
      ) async {
    emit(state.copyWith(loginStatus: PostApiStatus.loading));

    final data = {"email": state.email, "password": state.password};

    try {
      final response = await loginRepository.loginApiService(data);

      if (response['success'] == true) {
        final token = response['token'];
        final email = response['user']['email'];

        // final prefs = await SharedPreferences.getInstance();
        // await prefs.setString('token', token);
        // await prefs.setString('email', email);
        // Create storage
        // final storage = FlutterSecureStorage();
        // // Write value
        // await storage.write(key: 'token', value: token);
        // await storage.write(key: 'email', value: email);

        await AppStorage.setItem('token', token);
        await AppStorage.setItem('email', email);

        emit(
          state.copyWith(
            loginStatus: PostApiStatus.completed,
            message: response['message'] ?? 'Login Successful!',
            isLoggedIn: true, // ✅ indicate login success
          ),
        );
      } else {
        emit(
          state.copyWith(
            loginStatus: PostApiStatus.error,
            message: response['message'] ?? 'Invalid credentials',
            isLoggedIn: false,
          ),
        );
      }
    } on AppException catch (e) {
      emit(
        state.copyWith(
          loginStatus: PostApiStatus.error,
          message: e.toString(),
          isLoggedIn: false,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          loginStatus: PostApiStatus.error,
          message: "Something went wrong",
          isLoggedIn: false,
        ),
      );
    }
  }

  Future<void> _onFetchUser(
      FetchUserEvent event,
      Emitter<LoginState> emit,
      ) async {
    emit(state.copyWith(loginStatus: PostApiStatus.loading));

    try {
      final response = await loginRepository.checkLoginApiService();

      // 🧠 Check if response and data are not null
      if (response != null && response['success'] == true && response['user'] != null) {
        final user = UserModel.fromJson(response['user']);
        debugPrint("✅ User data found: ${response['user']}");

        emit(
          state.copyWith(
            loginStatus: PostApiStatus.completed,
            user: user,
            message: response['message'] ?? 'User fetched successfully',
          ),
        );
      } else {
        debugPrint("⚠️ No user data found in response: $response");
        emit(
          state.copyWith(
            loginStatus: PostApiStatus.error,
            message: response?['message'] ?? 'No user data available',
          ),
        );
      }
    } on AppException catch (e) {
      emit(state.copyWith(loginStatus: PostApiStatus.error, message: e.toString()));
    } catch (e) {
      debugPrint("❌ Exception while fetching user: $e");
      emit(
        state.copyWith(
          loginStatus: PostApiStatus.error,
          message: "Something went wrong",
        ),
      );
    }
  }

  Future<void> _onUserLogout(
      UserLogoutEvent event,
      Emitter<LoginState> emit,
      ) async {
    // emit(state.copyWith(loginStatus: Status.loading));

    try {
     // final prefs = await SharedPreferences.getInstance();
      // Create storage
      //final storage = FlutterSecureStorage();
      final response = await loginRepository.logoutApiService();

      if (response['success'] == true) {

        // Clear local storage
       // await prefs.clear();
        // Delete all
        //await storage.deleteAll();

        await AppStorage.clear();

        emit(
          state.copyWith(
            loginStatus: PostApiStatus.completed,
            message: response['message'] ?? 'Logged out successfully',
          ),
        );
      }
    } on AppException catch (e) {
      emit(state.copyWith(loginStatus: PostApiStatus.error, message: e.toString()));
    } catch (e) {
      emit(
        state.copyWith(
          loginStatus: PostApiStatus.error,
          message: "Something went wrong",
        ),
      );
    }
  }
}
