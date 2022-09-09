import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:qr_attendance_desktop_client/models/attendance_model.dart';
import 'package:qr_attendance_desktop_client/models/class_model.dart';
import 'package:qr_attendance_desktop_client/models/global_data.dart';
import 'package:qr_attendance_desktop_client/screens/android/mobile_attendance_student_list_screen.dart';
import 'package:qr_attendance_desktop_client/utils/api_services.dart';
import 'package:qr_attendance_desktop_client/utils/in_app_colors.dart';

class MCASScreenArguments {
  final ClassModel class_;

  MCASScreenArguments(this.class_);
}

class MobileClassAttendanceScreen extends StatefulWidget {
  // final ClassModel class_;
  const MobileClassAttendanceScreen({Key? key}) : super(key: key);
  static const routeName = '/mobile/attendance_list_screen';

  @override
  State<MobileClassAttendanceScreen> createState() =>
      _MobileClassAttendanceScreenState();
}

class _MobileClassAttendanceScreenState
    extends State<MobileClassAttendanceScreen> {
  String get pageHeader => ('Lecture Schedule');
  late List<AttendanceModel> _attendanceList;
  late APIService apiService;
  bool noClassYet = false;

  @override
  void initState() {
    _attendanceList = [];
    apiService = APIService();
    noClassYet = false;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as MCASScreenArguments;
    GlobalDataBase globalData = Provider.of<GlobalDataBase>(context);

    setState(() {
      _attendanceList = globalData.attendance
          .where((element) => element.classId == args.class_.id)
          .toList();
      if (_attendanceList.isEmpty) {
        noClassYet = true;
      }
    });

    // apiService.getAllAttendanceByClass(args.class_.id).then((value) {
    //   setState(() {
    //     _attendanceList = value;
    //     if (value[0].count == 0) {
    //       noClassYet = true;
    //     }
    //   });
    // });

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(children: [
            //App Bar Start
            Column(
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  decoration: BoxDecoration(
                      color: InAppColors.secondaryColor,
                      borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20))),
                  // height: 200,
                  child: Column(
                    children: [
                      const Text(
                        "CLASS",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            fontFamily: "Ubuntu"),
                      ),
                      Text(
                        "${args.class_.name.toUpperCase()} : ${args.class_.courseCode.toUpperCase()} ",
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            fontFamily: "Ubuntu"),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back),
                    ),
                    Text(
                      pageHeader,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(
                      width: 30,
                      height: 1,
                    )
                  ],
                )
              ],
            ),
            //App Bar End

            const Text(
              "Choose class:",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 10),
            Visibility(
                visible: noClassYet,
                child: const Text("NO CLASS LIST YET, Create One")),
            Visibility(
              visible: !noClassYet,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                    children: _attendanceList
                        .map((item) => Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: TextButton(
                                  style: TextButton.styleFrom(
                                      alignment: Alignment.center,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 20),
                                      backgroundColor:
                                          InAppColors.secondaryColor),
                                  onPressed: () {
                                    Navigator.pushNamed(
                                        context,
                                        MobileStudentAttendanceListScreen
                                            .routeName,
                                        arguments: MSALScreenArguments(item));
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "Class ${item.count}",
                                              style: const TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.white),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            //Date Start
                                            Row(
                                              children: [
                                                Icon(Icons.calendar_month,
                                                    color: InAppColors
                                                        .primaryColor),
                                                const SizedBox(width: 10),
                                                Text(
                                                  DateFormat('dd-MM-yyyy')
                                                      .format(item.date)
                                                      .toString(),
                                                  style: const TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: Colors.white),
                                                ),
                                              ],
                                            ),
                                            //Date End
                                            const SizedBox(height: 10),
                                            //Time Start
                                            Row(
                                              children: [
                                                Icon(Icons.access_time,
                                                    color: InAppColors
                                                        .primaryColor),
                                                const SizedBox(width: 10),
                                                Text(
                                                  DateFormat('hh:mm aaa')
                                                      .format(item.date)
                                                      .toString(),
                                                  style: const TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: Colors.white),
                                                ),
                                              ],
                                            ),
                                            //Time End
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ))
                        .toList()),
              ),
            ),

            const SizedBox(height: 30),
            // Container(
            //   alignment: Alignment.center,
            //   margin: const EdgeInsets.symmetric(horizontal: 112),
            //   height: 49,
            //   // decoration: BoxDecoration,
            //   decoration: const BoxDecoration(
            //     color: Color.fromARGB(255, 27, 74, 84),
            //     borderRadius: BorderRadius.all(Radius.circular(10)),
            //   ),
            //   child: const Text(
            //     "Add Class",
            //     style: TextStyle(
            //         fontSize: 15,
            //         fontWeight: FontWeight.w600,
            //         color: Colors.white),
            //   ),
            // )
          ]),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // if(){

          // }
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Create New Attendance List'),
                content: const Text(
                    'Are you sure you want to create a New Attendance List'),
                actions: [
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: InAppColors.secondaryColor),
                      onPressed: () {
                        if (globalData.needToReload != false) {
                          if (_attendanceList[0].count != 0) {
                            int classCount = _attendanceList.last.count + 1;
                            AttendanceModel model = AttendanceModel(
                                id: 0,
                                count: classCount,
                                theClassList: args.class_,
                                theAttendance: [
                                  AttendanceItemModel.fromDummy()
                                ]);
                            apiService.createAttendance(model).then((value) {
                              globalData.needToReload = true;
                              globalData.refreshData(false).then((value) {
                                int count = 0;
                                Navigator.of(context)
                                    .popUntil((_) => count++ >= 2);
                              });
                            });
                          }
                        }
                      },
                      child: const Text("Create Class"))
                ],
              );
            },
          );
        },
        backgroundColor: const Color.fromARGB(255, 27, 74, 84),
        child: const Icon(Icons.add),
      ),
    );
  }
}
