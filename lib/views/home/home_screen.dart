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
          // 🔹 Language Toggle Icon
          IconButton(
            onPressed: () {
              context.read<LanguageBloc>().add(ToggleLanguageEvent(context));
            },
            icon: Icon(Icons.language, color: Colors.black),
          ),

          // 🔹 Profile
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, RoutesName.profileScreen);
            },
            icon: const Icon(Icons.person),
          ),

          // 🔹 Movies
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, RoutesName.moviesScreen);
            },
            icon: const Icon(Icons.movie),
          ),

          // 🔹 Theme Toggle Icon
          BlocBuilder<ThemeBloc, ThemeState>(
            buildWhen: (previous, current) =>
                previous.isDarkMode != current.isDarkMode,
            builder: (context, themeState) {
              return IconButton(
                icon: Icon(
                  themeState.isDarkMode ? Icons.dark_mode : Icons.light_mode,
                ),
                onPressed: () {
                  context.read<ThemeBloc>().add(ToggleThemeEvent());
                },
              );
            },
          ),
        ],
      ),

      body: Center(child: Text(tr("Login Screen"))),
    );
  }
}
