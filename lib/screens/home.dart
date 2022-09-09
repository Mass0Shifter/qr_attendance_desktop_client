import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_attendance_desktop_client/models/global_data.dart';
import 'package:qr_attendance_desktop_client/screens/pc/desktop_students_screen.dart';
import 'package:qr_attendance_desktop_client/utils/api_services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late APIService _apiService;

  @override
  void initState() {
    _apiService = APIService();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    GlobalDataBase globalData = Provider.of<GlobalDataBase>(context);
    if (!globalData.isNotActuallyEmpty) {
      // globalData.setLoadingStatus(true);
      _apiService.getAllData().then((value) {
        globalData.addUpAll(value);
        // globalData.setLoadingStatus(false);
      });
    }
    // final List<Widget> _pages = [
    //   const MobileClassesScreen(),
    //   const MobileClassAttendanceScreen(),
    //   const MobileStudentAttendanceListScreen()
    // ];
    // return const MobileSplashScreen();
    return const DesktopStudentsScreen();
  }
}
