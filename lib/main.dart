import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sorotangame/pages/categories_laga_page.dart';

<<<<<<< HEAD
import 'server/firebase_options.dart';
=======
import 'firebase_options.dart';
>>>>>>> 7886a56aa30fb3dd0b92fe27dc20c1fb389e0d30

FirebaseApp? app;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Home2(),
    );
  }
}
