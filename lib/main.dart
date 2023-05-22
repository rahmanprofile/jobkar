import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jobkar/view/pages/splash_screen.dart';
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
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Jobkar',
        theme: appNewTheme,
        home: const SplashScreen(),
      ),
    );
  }
}
