import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solaifrontend/features/auth/data/repositories/user_repository_impl.dart';
import 'package:solaifrontend/features/auth/presentation/Bloc/signupBloc.dart';
import 'package:solaifrontend/features/auth/presentation/pages/loginpage.dart';

void main() async {
  final userRepository=UserRepositoryImpl();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    BlocProvider(
      create: (context) => AuthBloc(userRepository),
      child: MaterialApp(home: MyApp()),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: LoginPage(),);
  }
}