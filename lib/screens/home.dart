import 'package:flutter/material.dart';
import 'package:qr_attendance_desktop_client/models/attendance_model.dart';
import 'package:qr_attendance_desktop_client/models/class_model.dart';
import 'package:qr_attendance_desktop_client/screens/android/mobile_attendance_student_list_screen.dart';
import 'package:qr_attendance_desktop_client/screens/android/mobile_class_attendance_screen.dart';
import 'package:qr_attendance_desktop_client/screens/android/mobile_classes_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // final String _currentArea = "Dashboard";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _pages = [
      const MobileClassesScreen(),
      const MobileClassAttendanceScreen(),
      const MobileStudentAttendanceListScreen()
    ];
    return const MobileClassesScreen();
  }
}
