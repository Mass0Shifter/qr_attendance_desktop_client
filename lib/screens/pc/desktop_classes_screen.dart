import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_attendance_desktop_client/models/attendance_model.dart';
import 'package:qr_attendance_desktop_client/models/class_model.dart';
import 'package:qr_attendance_desktop_client/models/global_data.dart';
import 'package:qr_attendance_desktop_client/models/student_model.dart';
import 'package:qr_attendance_desktop_client/screens/pc/desktop_attendances_screen.dart';
import 'package:qr_attendance_desktop_client/screens/pc/desktop_students_screen.dart';
import 'package:qr_attendance_desktop_client/screens/pc/new_class.dart';
import 'package:qr_attendance_desktop_client/utils/api_services.dart';
import 'package:cached_network_image/cached_network_image.dart';

class DesktopClassesScreen extends StatefulWidget {
  // final dynamic drawer;
  const DesktopClassesScreen({Key? key}) : super(key: key);
  static const routeName = '/desktop/classes';

  @override
  State<DesktopClassesScreen> createState() => _DesktopClassesScreenState();
}

class _DesktopClassesScreenState extends State<DesktopClassesScreen> {
  late APIService apiService;
  final String _appBarTitle = "Classes";
  final TextEditingController _searchController = TextEditingController();
  final double gapping = 20;
  List<ClassModel> _classes = [];
  List<StudentModel> _students = [];
  List<AttendanceModel> _attendanceRecords = [];

  @override
  void initState() {
    apiService = APIService();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    GlobalDataBase globalData = Provider.of<GlobalDataBase>(context);

    setState(() {
      _students = globalData.students;
      _classes = globalData.classes;
      _attendanceRecords = globalData.attendance;
    });
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
                                          .getAllClasses()
                                          .then((value) => _classes = value);
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
                      Text(
                        _students.length.toString(),
                        style: const TextStyle(
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
                      Text(
                        _classes.length.toString(),
                        style: const TextStyle(
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
                      Text(
                        _attendanceRecords.length.toString(),
                        style: const TextStyle(
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
                              builder: (context) => const NewClassData()));
                    },
                    child: const Text("Create Class Data"))
              ],
            ),
            const SizedBox(height: 50),
            DataTable(
                dividerThickness: 1,
                columns: const [
                  DataColumn(label: Text("Name")),
                  DataColumn(label: Text("Course Code")),
                  DataColumn(label: Text("Student IDs")),
                  DataColumn(label: Text("Lecturer ID")),
                  DataColumn(label: Text("Actions")),
                ],
                rows: _classes.map((e) {
                  // e.studentObjects = (e.studentIds
                  //         .replaceAll(" ", "")
                  //         .split(","))
                  //     .map((e) => globalData.students
                  //         .firstWhere((element) => element.matricNumber == (e)))
                  //     .toList();
                  return DataRow(cells: [
                    DataCell(Text(e.name)),
                    DataCell(Text(e.courseCode)),
                    DataCell(Text(e.studentIds)),
                    DataCell(Text(e.lecturer)),
                    DataCell(Row(
                      children: [
                        TextButton(
                          child: const Text("View Students"),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return SimpleDialog(
                                    title: const Text('Students In Attendance'),
                                    children: e.studentObjects
                                        .map((st) => SimpleDialogOption(
                                            onPressed: () {},
                                            child: Row(children: [
                                              SizedBox(
                                                width: 50,
                                                height: 50,
                                                child: CachedNetworkImage(
                                                  imageUrl: st.imageURL,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                              const SizedBox(width: 10),
                                              Text(
                                                st.getFullName(),
                                              ),
                                              const SizedBox(width: 10),
                                              Text(
                                                st.matricNumber,
                                              ),
                                              const SizedBox(width: 10),
                                            ])))
                                        .toList());
                              },
                            );
                          },
                        ),
                        const SizedBox(width: 5),
                        TextButton(
                          child: const Text("View Attendances"),
                          onPressed: () {
                            Navigator.pushNamed(
                                context, DesktopAttendancesScreen.routeName,
                                arguments: DASScreenArguments(e.id));
                          },
                        ),
                        const SizedBox(width: 5),
                        TextButton(
                            child: const Text("Delete"),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text('Delete Class'),
                                    content: Text(
                                        "Are you sure want to delete '${e.name}'? Because all attendances under it will be deleted as well."),
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            apiService
                                                .deleteClass(e.id)
                                                .then((value) {
                                              globalData
                                                  .refreshData(false)
                                                  .then((nono) {
                                                setState(() {});
                                                Navigator.pop(context);
                                              });
                                            });
                                          },
                                          child: const Text("Delete"))
                                    ],
                                  );
                                },
                              );
                            }),
                      ],
                    )),
                  ]);
                }).toList()),
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
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const DesktopStudentsScreen()));
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
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: (context) => const DesktopClassesScreen()));
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
