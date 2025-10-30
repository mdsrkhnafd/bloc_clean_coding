import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../bloc/login/login_bloc.dart';
import '../../../utils/validations.dart';
import 'custom_text_form_field.dart';

class EmailField extends StatelessWidget {
  final FocusNode emailFocusNode;
  const EmailField({super.key, required this.emailFocusNode});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return CustomTextFormField(
          hintText: tr("Email"),
          keyboardType: TextInputType.emailAddress,
          validator: (value) => Validations.validateEmail(value ?? ''),
          prefixIcon: Icons.email,
          onChanged: (value) {
            context.read<LoginBloc>().add(EmailChangedEvent(email: value));
          },
          focusNode: emailFocusNode,
          textInputAction: TextInputAction.next,
        );
      },
    );
  }
}
