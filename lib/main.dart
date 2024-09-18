import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:users_app/firebase_options.dart';
import 'package:users_app/injection.dart';
import 'package:users_app/src/presentation/features/auth/bloc/login/login_bloc.dart';
import 'package:users_app/src/presentation/features/auth/bloc/register/register_bloc.dart';
import 'package:users_app/src/presentation/features/auth/pages/login_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await initLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LoginBloc(locator()),
        ),
        BlocProvider(
          create: (context) => RegisterBloc(locator()),
        ),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: LoginPage(),
      ),
    );
  }
}
