import 'dart:io';

import 'package:app_clone/firebase_options.dart';
import 'package:app_clone/src/application/app_initial/app_initial_bloc.dart';
import 'package:app_clone/src/application/auth/auth_bloc.dart';
import 'package:app_clone/src/application/theme/theme_bloc.dart';
import 'package:app_clone/src/core/routes.dart';
import 'package:app_clone/src/domain/core/repository_provider.dart';
import 'package:app_clone/src/presentation/core/theme/app_theme.dart';
import 'package:app_clone/src/presentation/feature/auth/ui/login.dart';
import 'package:app_clone/src/presentation/feature/home/home_main.dart';
import 'package:app_clone/src/utils/bloc_observer_util.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(builder: (context, state) {
      return MaterialApp(
        onGenerateRoute: AppRouter.generateRoute,
        debugShowCheckedModeBanner: false,
        themeMode: state.themeMode,
        darkTheme: AppTheme.darkTheme,
        theme: AppTheme.lightTheme,
        home: BlocBuilder<AppInitialBloc, AppInitialState>(
          builder: (context, authState) {
            if (authState is AppLoadingState) {
              return const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
            if (authState is UnauthenticatedState) {
              debugPrint("UNAUTHCALL_MAIN");
              return const AuthFlow();
            }
            if (authState is AppNotInitializedState) {
              debugPrint("AUTHNOTINITIALISEDCALL_MAIN");
              return const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
            if (authState is AuthenticatedState) {
              debugPrint("AUTHENTICATEDCALL_MAIN");
              return const HomePage();
            }
            return const Scaffold(
                body: Center(child: Text("DEFAULTSTATE_MAIN")));
          },
        ),
      );
    });
  }

  static Widget runWidget() {
    WidgetsFlutterBinding.ensureInitialized();

    Bloc.observer = SimpleBlocObserver();
    Future<void> initApp() async {
      WidgetsFlutterBinding.ensureInitialized();

      if (kIsWeb || Platform.isWindows || Platform.isMacOS) {
        await Firebase.initializeApp(
            options: DefaultFirebaseOptions.currentPlatform);
      } else {
        await Firebase.initializeApp();
      }

      final appDocumentDir = await getApplicationDocumentsDirectory();
      await Hive.initFlutter(appDocumentDir.path);
      await provideRemoteConfigRepository().initializeFirebaseAndRemoteConfig();
    }

    return FutureBuilder(
      future: initApp(),
      builder: (context, snapshot) {
        print("_snapshotState${snapshot.connectionState}");
        if (snapshot.connectionState == ConnectionState.done) {
          print("COnnectionData");
          return MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => ThemeBloc()),
              BlocProvider(
                  create: (context) => AppInitialBloc(
                      provideAuthRepository(), provideRemoteConfigRepository())
                    ..add(AuthStartedEvent())),
              BlocProvider(
                  create: (context) => AuthBloc(
                      provideAuthRepository(), context.read<AppInitialBloc>()))
            ],
            child: const MyApp(),
          );
        } else if (snapshot.hasError) {
          print("Snapshot error${snapshot.error}");
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
