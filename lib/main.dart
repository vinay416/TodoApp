import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/firebase_options.dart';
import 'package:todo_app/model/auth_model.dart';
import 'package:todo_app/model/base_model.dart';
import 'package:todo_app/repository/database_repo.dart';
import 'package:todo_app/utils.dart';
import 'package:todo_app/views/auth_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  setStatusBarIconColor(iconColor: Brightness.dark);
  runApp(const TodoApp());
}

class TodoApp extends StatelessWidget {
  const TodoApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => BaseModel(),
        ),
        Provider<AuthModel>(
          create: (context) => AuthModel(),
        ),
        ProxyProvider<AuthModel, DataBaseRepo>(
          update: (context, auth, previous) => DataBaseRepo(authModel: auth),
          lazy: true,
        ),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: AuthView(),
      ),
    );
  }
}
