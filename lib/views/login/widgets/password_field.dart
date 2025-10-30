import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../bloc/login/login_bloc.dart';
import '../../../utils/validations.dart';
import 'custom_text_form_field.dart';

class PasswordField extends StatelessWidget {
  final FocusNode passwordFocusNode;
  const PasswordField({super.key, required this.passwordFocusNode});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) =>
      previous.isPasswordVisible != current.isPasswordVisible ||
          previous.password != current.password,
      builder: (context, state) {
        return CustomTextFormField(
          hintText: tr("Password"),
          obscureText: !state.isPasswordVisible,
          prefixIcon: Icons.lock,
          suffixIcon: state.isPasswordVisible
              ? Icons.remove_red_eye
              : Icons.remove_red_eye_outlined,
          onSuffixTap: () {
            context.read<LoginBloc>().add(TogglePasswordVisibilityEvent());
          },
          onChanged: (value) {
            context.read<LoginBloc>().add(PasswordChangedEvent(password: value));
          },
          validator: (value) => Validations.validatePassword(value ?? ''),
          focusNode: passwordFocusNode,
          textInputAction: TextInputAction.done,
        );
      },
    );
  }
}
