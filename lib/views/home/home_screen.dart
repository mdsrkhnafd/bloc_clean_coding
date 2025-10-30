import 'package:bloc_clean_coding/bloc/login/login_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/language/language_bloc.dart';
import '../../bloc/theme/theme_bloc.dart';
import '../../bloc/theme/theme_event.dart';
import '../../bloc/theme/theme_state.dart';
import '../../config/routes/routes_name.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Screen"),
        centerTitle: true,
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
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, RoutesName.profileScreen);
            },
            icon: Icon(Icons.person),
          ),
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, RoutesName.moviesScreen);
            },
            icon: Icon(Icons.movie),
          ),
          IconButton(
            icon: Icon(
              context.read<ThemeBloc>().state.isDarkMode
                  ? Icons.dark_mode
                  : Icons.light_mode,
            ),
            onPressed: () {
              context.read<ThemeBloc>().add(ToggleThemeEvent());
            },
          ),
        ],
      ),

      body: Center(child: Text(tr("Login Screen"))),
    );
  }
}
