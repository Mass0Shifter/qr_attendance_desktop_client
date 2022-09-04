import 'package:flutter/material.dart';
import 'package:qr_attendance_desktop_client/screens/students.dart';

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
      StudentsScreen(drawer: _drawer),
    ];
    return _pages[0];
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
            onPressed: () {},
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
            onPressed: () {},
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
          //Attendence
          TextButton(
            onPressed: () {},
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                children: const [
                  Icon(Icons.view_list, color: Color.fromARGB(255, 27, 78, 89)),
                  SizedBox(width: 10),
                  Text(
                    "Attendence",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
