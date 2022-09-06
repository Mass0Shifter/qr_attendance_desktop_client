import 'package:flutter/material.dart';
import 'package:qr_attendance_desktop_client/models/student_model.dart';
import 'package:qr_attendance_desktop_client/screens/pc/desktop_attendances_screen.dart';
import 'package:qr_attendance_desktop_client/screens/pc/desktop_classes_screen.dart';
import 'package:qr_attendance_desktop_client/screens/pc/new_student.dart';
import 'package:qr_attendance_desktop_client/utils/api_services.dart';

class DesktopStudentsScreen extends StatefulWidget {
  // final dynamic drawer;
  const DesktopStudentsScreen({Key? key}) : super(key: key);
  static const routeName = '/desktop/students';

  @override
  State<DesktopStudentsScreen> createState() => _DesktopStudentsScreenState();
}

class _DesktopStudentsScreenState extends State<DesktopStudentsScreen> {
  late APIService apiService;
  final String _appBarTitle = "Students";
  final TextEditingController _searchController = TextEditingController();
  final double gapping = 20;
  List<StudentModel> _students = [];

  @override
  void initState() {
    apiService = APIService();
    apiService.getAllStudents().then((value) {
      setState(() {
        _students = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 30, 30, 30),
        title: Text(_appBarTitle),
      ),
      drawer: _drawer(),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                //Search Students Card
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        gradient: const LinearGradient(colors: <Color>[
                          Color.fromARGB(255, 30, 30, 30),
                          Color.fromARGB(255, 27, 78, 89)
                        ]),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: const [
                          BoxShadow(
                              color: Colors.black12,
                              offset: Offset(0, 5),
                              blurRadius: 1,
                              spreadRadius: 2)
                        ]),
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    // height: 150,
                    child: Column(children: [
                      Container(
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(colors: <Color>[
                            Color.fromARGB(255, 30, 30, 30),
                            Color.fromARGB(255, 27, 78, 89)
                          ]),
                          color: const Color.fromARGB(255, 30, 30, 30),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 50),
                        height: 40,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: _searchController,
                                  keyboardType: TextInputType.text,
                                  // textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    // fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  // expands: true,
                                  // maxLength: null,
                                  // maxLines: null,
                                  decoration: InputDecoration(
                                    hintText: "Search Student",
                                    hintStyle: const TextStyle(
                                      fontWeight: FontWeight.w300,
                                      height: 1,
                                    ),
                                    fillColor: Colors.white,
                                    filled: true,
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                        width: 1,
                                        color: Colors.green,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                        width: 1,
                                        color: Colors.blue,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              TextButton(
                                  onPressed: () async {
                                    setState(() {
                                      apiService
                                          .getAllStudents()
                                          .then((value) => _students = value);
                                    });
                                  },
                                  child: Container(
                                    height: 50,
                                    width: 120,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.teal,
                                    ),
                                    child: Row(
                                      children: const [
                                        Icon(
                                          Icons.search,
                                          color: Colors.black,
                                        ),
                                        SizedBox(width: 10),
                                        Text(
                                          "Search",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ))
                            ]),
                      ),
                      const SizedBox(height: 10),
                    ]),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                //Students Card
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: const [
                          BoxShadow(
                              color: Colors.black12,
                              offset: Offset(0, 5),
                              blurRadius: 1,
                              spreadRadius: 2)
                        ]),
                    height: 150,
                    child: Column(children: [
                      Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(colors: <Color>[
                            Color.fromARGB(255, 30, 30, 30),
                            Color.fromARGB(255, 27, 78, 89)
                          ]),
                          color: Color.fromARGB(255, 30, 30, 30),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 50),
                        height: 50,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text(
                                "Students",
                                style: TextStyle(color: Colors.white),
                              ),
                              Icon(Icons.person, color: Colors.white)
                            ]),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        "50",
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text("Total - Students"),
                    ]),
                  ),
                ),
                const SizedBox(width: 20),
                //Classes Card
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: const [
                          BoxShadow(
                              color: Colors.black12,
                              offset: Offset(0, 5),
                              blurRadius: 1,
                              spreadRadius: 2)
                        ]),
                    height: 150,
                    child: Column(children: [
                      Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(colors: <Color>[
                            Color.fromARGB(255, 30, 30, 30),
                            Color.fromARGB(255, 27, 78, 89)
                          ]),
                          color: Color.fromARGB(255, 30, 30, 30),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 50),
                        height: 50,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text(
                                "Classes",
                                style: TextStyle(color: Colors.white),
                              ),
                              Icon(Icons.class_, color: Colors.white)
                            ]),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        "5",
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text("Total - Classes"),
                    ]),
                  ),
                ),
                const SizedBox(width: 20),
                //Attendances Card
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            offset: Offset(0, 5),
                            blurRadius: 1,
                            spreadRadius: 2,
                          ),
                        ]),
                    height: 150,
                    child: Column(children: [
                      Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(colors: <Color>[
                            Color.fromARGB(255, 30, 30, 30),
                            Color.fromARGB(255, 27, 78, 89)
                          ]),
                          color: Color.fromARGB(255, 30, 30, 30),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 50),
                        height: 50,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text(
                                "Attendance Collections",
                                style: TextStyle(color: Colors.white),
                              ),
                              Icon(Icons.view_list, color: Colors.white)
                            ]),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        "13",
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text("Total - Attendances"),
                    ]),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 50),
            Row(
              children: [
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const NewStudentData()));
                    },
                    child: const Text("Create Student Data"))
              ],
            ),
            const SizedBox(height: 50),
            DataTable(
                dividerThickness: 1,
                columns: const [
                  DataColumn(label: Text("Image")),
                  DataColumn(label: Text("First Name")),
                  DataColumn(label: Text("Middle Name")),
                  DataColumn(label: Text("Last Name")),
                  DataColumn(label: Text("Full Name")),
                  DataColumn(label: Text("Department")),
                  DataColumn(label: Text("Metric Number")),
                  // DataColumn(label: Text("Actions")),
                ],
                rows: _students
                    .map((e) => DataRow(cells: [
                          DataCell(
                              // Image.network(e.imageURL)
                              Container(
                            height: 80,
                            width: 80,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40),
                              border: Border.all(
                                width: 1,
                                // color: Colors.amberAccent,
                              ),
                            ),
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(40),
                                child: Image.network(
                                  e.imageURL,
                                  fit: BoxFit.cover,
                                )),
                          )),
                          DataCell(Text(e.firstName)),
                          DataCell(Text(e.middleName)),
                          DataCell(Text(e.lastName)),
                          DataCell(Text(e.getFullName())),
                          DataCell(Text(e.department)),
                          DataCell(Text(e.matricNumber)),
                          // DataCell(Row(
                          //   children: [
                          //     TextButton(
                          //       child: const Text("Edit"),
                          //       onPressed: () {},
                          //     ),
                          //     const SizedBox(width: 5),
                          //     TextButton(
                          //         child: const Text("Delete"),
                          //         onPressed: () {}),
                          //   ],
                          // )),
                        ]))
                    .toList()),
          ],
        ),
      )),
    );
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
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: (context) => const DesktopStudentsScreen()));
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
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const DesktopClassesScreen()));
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
          //Attendence
          TextButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const DesktopAttendancesScreen()));
            },
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
