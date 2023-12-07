import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:to_do_list/pages/home_page.dart';

void main() async {
  // инициализация базы данных
  await Hive.initFlutter();
  var box = await Hive.openBox('mybox');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TO DO LIST',
      theme: ThemeData(
        primarySwatch: Colors.grey,
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 52, 102, 89)),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Список дел'),
    );
  }
}
