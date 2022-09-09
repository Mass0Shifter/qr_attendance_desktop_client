import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_attendance_desktop_client/models/attendance_model.dart';
import 'package:qr_attendance_desktop_client/models/global_data.dart';
import 'package:qr_attendance_desktop_client/utils/api_services.dart';
import 'package:cached_network_image/cached_network_image.dart';

class DASScreenArguments {
  final int classId;

  DASScreenArguments(this.classId);
}

class DesktopAttendancesScreen extends StatefulWidget {
  // final dynamic drawer;
  const DesktopAttendancesScreen({Key? key}) : super(key: key);
  static const routeName = '/desktop/attendance';

  @override
  State<DesktopAttendancesScreen> createState() =>
      _DesktopAttendancesScreenState();
}

class _DesktopAttendancesScreenState extends State<DesktopAttendancesScreen> {
  late APIService apiService;
  final String _appBarTitle = "Attendances";
  // final TextEditingController _searchController = TextEditingController();
  final double gapping = 20;
  List<AttendanceModel> _attendanceList = [];

  @override
  void initState() {
    apiService = APIService();
    apiService.getAllAttendanceByClass(14).then((value) {
      setState(() {
        _attendanceList = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as DASScreenArguments;
    GlobalDataBase globalData = Provider.of<GlobalDataBase>(context);
    setState(() {
      _attendanceList = globalData.attendance
          .where((element) => element.classId == args.classId)
          .toList();
    });
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 30, 30, 30),
        title: Text(_appBarTitle),
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            const SizedBox(height: 50),
            DataTable(
                dividerThickness: 1,
                columns: const [
                  DataColumn(label: Text("Class Name")),
                  DataColumn(label: Text("Class Count")),
                  DataColumn(label: Text("Total Attendance")),
                  DataColumn(label: Text("Actions")),
                ],
                rows: _attendanceList.map((e) {
                  // Data MAPPING
                  return DataRow(cells: [
                    DataCell(Text(e.theClassList.name)),
                    DataCell(Text(e.count.toString())),
                    DataCell(Text(e.theAttendance.length.toString())),
                    DataCell(Row(
                      children: [
                        TextButton(
                            child: const Text("View List"),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return SimpleDialog(
                                      title:
                                          const Text('Students In Attendance'),
                                      children: e.theAttendance
                                          .map((st) => SimpleDialogOption(
                                              onPressed: () {},
                                              child: Row(children: [
                                                SizedBox(
                                                  width: 50,
                                                  height: 50,
                                                  child: CachedNetworkImage(
                                                    imageUrl:
                                                        st.student.imageURL,
                                                    progressIndicatorBuilder: (context,
                                                            url,
                                                            downloadProgress) =>
                                                        CircularProgressIndicator(
                                                            value:
                                                                downloadProgress
                                                                    .progress),
                                                    errorWidget: (context, url,
                                                            error) =>
                                                        const Icon(Icons.error),
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                                const SizedBox(width: 10),
                                                Text(
                                                  st.student.getFullName(),
                                                ),
                                                const SizedBox(width: 10),
                                                Text(
                                                  st.student.matricNumber,
                                                ),
                                                const SizedBox(width: 10),
                                                Text(
                                                  "${st.timeRecord.hour.toString()}:${st.timeRecord.minute.toString()}:${st.timeRecord.second.toString()}",
                                                ),
                                              ])))
                                          .toList());
                                },
                              );
                            }),
                        const SizedBox(width: 5),
                        // TextButton(
                        //     child: const Text("Delete"),
                        //     onPressed: () {}),
                      ],
                    )),
                  ]);
                }).toList()),
          ],
        ),
      )),
    );
  }

  // Drawer _drawer() {
  //   return Drawer(
  //     backgroundColor: const Color.fromARGB(255, 30, 30, 30),
  //     child: Padding(
  //       padding: const EdgeInsets.symmetric(vertical: 20),
  //       child: ListView(children: [
  //         DrawerHeader(
  //             decoration:
  //                 const BoxDecoration(color: Color.fromARGB(255, 27, 78, 89)),
  //             child: Column(
  //               children: [
  //                 const Icon(
  //                   Icons.camera,
  //                   color: Colors.white,
  //                   size: 42,
  //                 ),
  //                 const SizedBox(height: 20),
  //                 Text(
  //                   "QR Attendance".toUpperCase(),
  //                   style: const TextStyle(
  //                     fontSize: 26,
  //                     color: Colors.white,
  //                   ),
  //                 ),
  //               ],
  //             )),
  //         //Dashboard
  //         TextButton(
  //           onPressed: () {},
  //           child: Container(
  //             padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
  //             child: Row(
  //               children: const [
  //                 Icon(Icons.dashboard, color: Color.fromARGB(255, 27, 78, 89)),
  //                 SizedBox(width: 10),
  //                 Text(
  //                   "Dashboard",
  //                   style: TextStyle(
  //                       color: Colors.white, fontWeight: FontWeight.w600),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ),
  //         //Students
  //         TextButton(
  //           onPressed: () {
  //             Navigator.push(
  //                 context,
  //                 MaterialPageRoute(
  //                     builder: (context) => const DesktopStudentsScreen()));
  //           },
  //           child: Container(
  //             padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
  //             child: Row(
  //               children: const [
  //                 Icon(Icons.person, color: Color.fromARGB(255, 27, 78, 89)),
  //                 SizedBox(width: 10),
  //                 Text(
  //                   "Students",
  //                   style: TextStyle(
  //                       color: Colors.white, fontWeight: FontWeight.w600),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ),
  //         //Classes
  //         TextButton(
  //           onPressed: () {
  //             Navigator.push(
  //                 context,
  //                 MaterialPageRoute(
  //                     builder: (context) => const DesktopClassesScreen()));
  //           },
  //           child: Container(
  //             padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
  //             child: Row(
  //               children: const [
  //                 Icon(Icons.class_, color: Color.fromARGB(255, 27, 78, 89)),
  //                 SizedBox(width: 10),
  //                 Text(
  //                   "Classes",
  //                   style: TextStyle(
  //                       color: Colors.white, fontWeight: FontWeight.w600),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ),
  //         //Attendence
  //         TextButton(
  //           onPressed: () {
  //             Navigator.push(
  //                 context,
  //                 MaterialPageRoute(
  //                     builder: (context) => const DesktopAttendancesScreen()));
  //           },
  //           child: Container(
  //             padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
  //             child: Row(
  //               children: const [
  //                 Icon(Icons.view_list, color: Color.fromARGB(255, 27, 78, 89)),
  //                 SizedBox(width: 10),
  //                 Text(
  //                   "Attendence",
  //                   style: TextStyle(
  //                       color: Colors.white, fontWeight: FontWeight.w600),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ),
  //       ]),
  //     ),
  //   );
  // }
}
