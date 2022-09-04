import 'package:flutter/material.dart';
import 'package:qr_attendance_desktop_client/screens/home.dart';

void main() {
  runApp(const MyApp());
  // runApp(MultiProvider(
  //   providers: [
  //     ChangeNotifierProvider(
  //       create: (_) => FileController(),
  //       child: const NewStudentData(),
  //     )
  //   ],
  //   child: const MyApp(),
  // ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // context.read<FileController>().readText();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: const StudentsScreen(),
      home: const HomeScreen(),
    );
  }
}
