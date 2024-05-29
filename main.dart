import 'package:flutter/material.dart';
import 'package:flutter_staff/home_page/adding_a_person.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_staff/home_page/user.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  Hive.registerAdapter(UserAdapter());
  await Hive.openBox<User>('usersBox');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: AddingAPerson(),
    );
  }
}
