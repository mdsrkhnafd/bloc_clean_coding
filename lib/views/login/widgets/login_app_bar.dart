import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../bloc/language/language_bloc.dart';

class LoginAppBar extends StatelessWidget implements PreferredSizeWidget {
  const LoginAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Text(tr("Login Screen")),
      actions: [
        IconButton(
          onPressed: () {
            context.read<LanguageBloc>().add(ToggleLanguageEvent(context));
          },
          icon: Icon(
            context.read<LanguageBloc>().state.locale.languageCode == 'en'
                ? Icons.language
                : Icons.translate,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
