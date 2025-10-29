import 'package:bloc_clean_coding/repository/movies/movies_repository.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'bloc/language/language_bloc.dart';
import 'bloc/login/login_bloc.dart';
import 'bloc/movies_bloc/movies_bloc.dart';
import 'config/routes/routes.dart';
import 'config/routes/routes_name.dart';
import 'repository/auth/login_repository.dart';

GetIt getIt = GetIt.instance;

Future<void> main() async {

  serviceLocator();

  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();
  final savedLang = prefs.getString('langCode') ?? 'en';

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ur')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      startLocale: Locale(savedLang),
      child: MultiBlocProvider(
        providers: [
          // TODO: if not work then add this
          // BlocProvider(create: (_) => LanguageBloc()..add(LoadLanguageEvent())),
          // TODO: either this
          BlocProvider(create: (_) => LanguageBloc()),
          BlocProvider(create: (_) => LoginBloc(loginRepository: LoginRepository())),
         // BlocProvider(create: (_) => MoviesBloc(moviesRepository: MoviesRepository())),
        ],
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Bloc Clean Code',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      localizationsDelegates: context.localizationDelegates,
      initialRoute: RoutesName.splashScreen,
      onGenerateRoute: Routes.generateRoute,
    );
  }
}

void serviceLocator() {
  getIt.registerLazySingleton<LoginRepository>(() => LoginRepository());
  getIt.registerLazySingleton<MoviesRepository>(() => MoviesRepository());
}
