import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_attendance_desktop_client/models/global_data.dart';
import 'package:qr_attendance_desktop_client/screens/android/mobile_attendance_student_list_screen.dart';
import 'package:qr_attendance_desktop_client/screens/android/mobile_images_preview_screen.dart';
import 'package:qr_attendance_desktop_client/screens/android/mobile_class_attendance_screen.dart';
import 'package:qr_attendance_desktop_client/screens/android/mobile_classes_screen.dart';
import 'package:qr_attendance_desktop_client/screens/android/mobile_qr_scanning_screen.dart';
import 'package:qr_attendance_desktop_client/screens/android/mobile_splash_screen.dart';
import 'package:qr_attendance_desktop_client/screens/android/mobile_verify_student_screen.dart';
import 'package:qr_attendance_desktop_client/screens/android/mobile_warning_screen.dart';
import 'package:qr_attendance_desktop_client/screens/home.dart';
import 'package:qr_attendance_desktop_client/screens/pc/desktop_attendances_screen.dart';
import 'package:qr_attendance_desktop_client/screens/pc/desktop_classes_screen.dart';
import 'package:qr_attendance_desktop_client/screens/pc/desktop_students_screen.dart';
// import 'package:qr_attendance_desktop_client/screens/pc/new_class.dart';

void main() {
  runApp(const MyApp());
  // runApp(MultiProvider(
  //   providers: [
  //     ChangeNotifierProvider(
  //       create: (context) => GlobalDataBase(),
  //       child: const DesktopStudentsScreen(),
  //     ),
  //     ChangeNotifierProvider(
  //       create: (context) => GlobalDataBase(),
  //       child: const HomeScreen(),
  //     ),
  //     ChangeNotifierProvider(
  //       create: (context) => GlobalDataBase(),
  //       child: const DesktopClassesScreen(),
  //     ),
  //     ChangeNotifierProvider(
  //       create: (context) => GlobalDataBase(),
  //       child: const DesktopAttendancesScreen(),
  //     ),
  //     ChangeNotifierProvider(
  //       create: (context) => GlobalDataBase(),
  //       child: const NewClassData(),
  //     ),

  //   ],
  //   child: const MyApp(),
  // ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // context.read<FileController>().readText();
    return ChangeNotifierProvider(
      create: (context) => GlobalDataBase(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/',
        routes: {
          // When navigating to the "/" route, build the FirstScreen widget.
          '/': (context) => const HomeScreen(),
          // When navigating to the "/second" route, build the SecondScreen widget.

          //Desktop Screens
          DesktopClassesScreen.routeName: (context) =>
              const DesktopClassesScreen(),
          DesktopStudentsScreen.routeName: (context) =>
              const DesktopStudentsScreen(),
          DesktopAttendancesScreen.routeName: (context) =>
              const DesktopAttendancesScreen(),

          //Mobile Screens
          MobileClassesScreen.routeName: (context) =>
              const MobileClassesScreen(),
          MobileClassAttendanceScreen.routeName: (context) =>
              const MobileClassAttendanceScreen(),
          MobileStudentAttendanceListScreen.routeName: (context) =>
              const MobileStudentAttendanceListScreen(),
          MobileQRScanningScreen.routeName: (context) =>
              const MobileQRScanningScreen(),
          MobileVerifyStudentScreen.routeName: (context) =>
              const MobileVerifyStudentScreen(),
          MobileImagesPreviewScreen.routeName: (context) =>
              const MobileImagesPreviewScreen(),
          MobileWarningScreen.routeName: (context) => const MobileSplashScreen()
        },
      ),
    );
  }
}
