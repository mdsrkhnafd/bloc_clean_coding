import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../bloc/login/login_bloc.dart';
import '../../../config/components/round_button.dart';
import '../../../config/routes/routes_name.dart';
import '../../../data/response/enums.dart';
import '../../../utils/utils.dart';

class LoginButton extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  const LoginButton({super.key, required this.formKey});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState>(
      listenWhen: (previous, current) =>
      previous.loginStatus != current.loginStatus,
      listener: (context, state) {
        if (state.loginStatus == PostApiStatus.completed) {
          Utils.flushBarSuccessMessage(state.message, context);

          Future.delayed(const Duration(seconds: 1), () {
            Navigator.pushNamedAndRemoveUntil(
              context,
              RoutesName.homeScreen,
                  (route) => false,
            );
          });
        } else if (state.loginStatus == PostApiStatus.error) {
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
            if (formKey.currentState!.validate()) {
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
    );
  }
}
