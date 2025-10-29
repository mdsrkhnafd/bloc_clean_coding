import 'package:bloc_clean_coding/utils/utils.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/language/language_bloc.dart';
import '../../bloc/login/login_bloc.dart';
import '../../config/components/round_button.dart';
import '../../config/routes/routes_name.dart';
import '../../data/response/enums.dart';
import '../../utils/validations.dart';
import 'widgets/custom_text_form_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(tr("Login Screen")),
        actions: [
          IconButton(
            onPressed: () {
              context.read<LanguageBloc>().add(ToggleLanguageEvent(context));
            },
            icon: Icon(Icons.language, color: Colors.black),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 60),
                BlocBuilder<LoginBloc, LoginState>(
                  buildWhen: (previous, current) =>
                      previous.email != current.email,
                  builder: (context, state) {
                    return CustomTextFormField(
                      hintText: tr("Email"),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) =>
                          Validations.validateEmail(value ?? ''),
                      prefixIcon: Icons.email,
                      onChanged: (value) {
                        context.read<LoginBloc>().add(
                          EmailChangedEvent(email: value),
                        );
                      },
                      focusNode: _emailFocusNode,
                      textInputAction: TextInputAction.next,
                    );
                  },
                ),
                const SizedBox(height: 16),
              BlocBuilder<LoginBloc, LoginState>(
                buildWhen: (previous, current) =>
                previous.isPasswordVisible != current.isPasswordVisible ||
                    previous.password != current.password,
                builder: (context, state) {
                  return CustomTextFormField(
                    hintText: tr("Password"),
                    obscureText: !state.isPasswordVisible, // 🔹 toggle
                    prefixIcon: Icons.lock,
                    suffixIcon: state.isPasswordVisible
                        ? Icons.remove_red_eye
                        : Icons.remove_red_eye_outlined,
                    onSuffixTap: () {
                      // toggle password visibility
                      context.read<LoginBloc>().add(
                        TogglePasswordVisibilityEvent(),
                      );
                    },
                    onChanged: (value) {
                      context.read<LoginBloc>().add(
                        PasswordChangedEvent(password: value),
                      );
                    },
                    validator: (value) => Validations.validatePassword(value ?? ''),
                    focusNode: _passwordFocusNode,
                    textInputAction: TextInputAction.done,
                  );
                },
              ),
                const SizedBox(height: 30),
                BlocConsumer<LoginBloc, LoginState>(
                  listenWhen: (previous, current) =>
                  previous.loginStatus != current.loginStatus,
                  listener: (context, state) {
                    if (state.loginStatus == PostApiStatus.completed) {
                      // Show success message
                      Utils.flushBarSuccessMessage(state.message, context);

                      // ✅ Add short delay before navigating
                      Future.delayed(const Duration(seconds: 1), () {
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          RoutesName.homeScreen,
                              (route) => false,
                        );
                      });
                    } else if (state.loginStatus == PostApiStatus.error) {
                      // Show error message
                      Utils.flushBarErrorMessage(state.message, context);
                    }
                  },
                  buildWhen: (previous, current) =>
                  previous.loginStatus != current.loginStatus,
                  builder: (context, state) {
                    if (state.loginStatus == PostApiStatus.loading) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    return RoundButton(
                      title: tr("Login"),
                      onPress: () {
                        if (_formKey.currentState!.validate()) {
                          // ✅ Trigger login event without passing context
                          context.read<LoginBloc>().add(LoginSubmitEvent());
                        } else {
                          Utils.flushBarErrorMessage(
                            tr("Please fill all fields correctly"),
                            context,
                          );
                        }
                      },
                    );
                  },
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
