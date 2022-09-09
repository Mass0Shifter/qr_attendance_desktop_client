import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_attendance_desktop_client/providers/loader_provider.dart';
import 'package:qr_attendance_desktop_client/screens/pc/desktop_classes_screen.dart';
import 'package:qr_attendance_desktop_client/screens/pc/desktop_students_screen.dart';
import 'package:qr_attendance_desktop_client/utils/in_app_colors.dart';
import 'package:qr_attendance_desktop_client/utils/progress_hud.dart';

class DesktopBaseScreen extends StatefulWidget {
  const DesktopBaseScreen({Key? key}) : super(key: key);

  @override
  DesktopBaseScreenState createState() => DesktopBaseScreenState();
}

// class _DesktopBaseScreenState extends State<DesktopBaseScreen> {
class DesktopBaseScreenState<T extends DesktopBaseScreen> extends State<T> {
  bool isApiCallProcess = false;
  late String pageTitle;
  late String page = "dashboard";

  @override
  void initState() {
    super.initState();
    pageTitle = "QR ATTENDANCE";
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LoaderProvider>(builder: (context, loaderModel, child) {
      return Scaffold(
        appBar: _buildAppBar(),
        body: ProgressHUD(
          child: pageUI(),
          inAsyncCall: loaderModel.isApiCallProcess,
          opacity: 0.3,
        ),
      );
    });
  }

  AppBar _buildAppBar() {
    return AppBar(
      centerTitle: true,
      elevation: 0,
      iconTheme: const IconThemeData(color: Colors.white),
      backgroundColor: InAppColors.primaryBackgroundColor,
      automaticallyImplyLeading: true,
      title: Text(
        pageTitle,
        style: const TextStyle(color: Colors.white),
      ),
      actions: [],
      // bottom: _addBottom(),
    );
  }

  Widget pageUI() {
    return Container();
  }

  Drawer _drawer() {
    return Drawer(
      backgroundColor: const Color.fromARGB(255, 30, 30, 30),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: ListView(children: [
          DrawerHeader(
              decoration:
                  const BoxDecoration(color: Color.fromARGB(255, 27, 78, 89)),
              child: Column(
                children: [
                  const Icon(
                    Icons.camera,
                    color: Colors.white,
                    size: 42,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "QR Attendance".toUpperCase(),
                    style: const TextStyle(
                      fontSize: 26,
                      color: Colors.white,
                    ),
                  ),
                ],
              )),
          //Dashboard
          TextButton(
            onPressed: () {},
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                children: const [
                  Icon(Icons.dashboard, color: Color.fromARGB(255, 27, 78, 89)),
                  SizedBox(width: 10),
                  Text(
                    "Dashboard",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ),
          //Students
          TextButton(
            onPressed: () {
              if (page != "student") {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const DesktopStudentsScreen()));
              }
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                children: const [
                  Icon(Icons.person, color: Color.fromARGB(255, 27, 78, 89)),
                  SizedBox(width: 10),
                  Text(
                    "Students",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ),
          //Classes
          TextButton(
            onPressed: () {
              if (page != "class") {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const DesktopClassesScreen()));
              }
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                children: const [
                  Icon(Icons.class_, color: Color.fromARGB(255, 27, 78, 89)),
                  SizedBox(width: 10),
                  Text(
                    "Classes",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ),
          // //Attendence
          // TextButton(
          //   onPressed: () {
          //     Navigator.push(
          //         context,
          //         MaterialPageRoute(
          //             builder: (context) => const DesktopAttendancesScreen()));
          //   },
          //   child: Container(
          //     padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          //     child: Row(
          //       children: const [
          //         Icon(Icons.view_list, color: Color.fromARGB(255, 27, 78, 89)),
          //         SizedBox(width: 10),
          //         Text(
          //           "Attendence",
          //           style: TextStyle(
          //               color: Colors.white, fontWeight: FontWeight.w600),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
        ]),
      ),
    );
  }
}
