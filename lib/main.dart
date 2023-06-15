import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jobkar/controller/category_controller.dart';
import 'package:jobkar/controller/project_controller.dart';
import 'package:jobkar/user/guidlines_pages.dart';
import 'package:jobkar/view/home.dart';
import 'package:provider/provider.dart';
import 'controller/add_in_favourite.dart';
import 'controller/data_controller.dart';
import 'controller/on_apply.dart';
import 'controller/phone_controller.dart';
import 'controller/theme_controller.dart';
import 'controller/update_controller.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Colors.black,
        systemNavigationBarColor: Colors.white),
    );
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Apply()),
        ChangeNotifierProvider(create: (_) => PhoneController()),
        ChangeNotifierProvider(create: (_) => AddInFavourite()),
        ChangeNotifierProvider(create: (_) => DataController()),
        ChangeNotifierProvider(create: (_) => UpdateController()),
        ChangeNotifierProvider(create: (_) => CategoryController()),
        ChangeNotifierProvider(create: (_) => ProjectController()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Jobkar',
        theme: appNewTheme,
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
            if (!snapshot.hasData) {
              return const WelcomePage();
            }
            return const Home();
          },
        ),
      ),
    );
  }
}
