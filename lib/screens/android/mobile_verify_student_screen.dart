import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_attendance_desktop_client/models/attendance_model.dart';
import 'package:qr_attendance_desktop_client/models/global_data.dart';
import 'package:qr_attendance_desktop_client/models/student_model.dart';
import 'package:qr_attendance_desktop_client/screens/android/mobile_attendance_student_list_screen.dart';
import 'package:qr_attendance_desktop_client/utils/api_services.dart';
import 'package:qr_attendance_desktop_client/utils/in_app_colors.dart';
import 'package:cached_network_image/cached_network_image.dart';

class MVSSScreenArguments {
  final String matricNumber;
  final AttendanceModel attendanceList;

  MVSSScreenArguments(this.matricNumber, this.attendanceList);
}

class MobileVerifyStudentScreen extends StatefulWidget {
  const MobileVerifyStudentScreen({Key? key}) : super(key: key);
  static const routeName = '/mobile/verify_student_screen';

  @override
  State<MobileVerifyStudentScreen> createState() =>
      _MobileVerifyStudentScreenState();
}

class _MobileVerifyStudentScreenState extends State<MobileVerifyStudentScreen> {
  String get pageHeader => ('');
  late APIService apiService;
  late StudentModel student;
  bool inList = false;
  bool marked = false;
  bool redirect = false;
  late AttendanceModel theAttendanceModel;

  @override
  void initState() {
    apiService = APIService();
    inList = false;
    marked = false;
    super.initState();
  }

  // @override
  // void didUpdateWidget(covariant MobileVerifyStudentScreen oldWidget) {
  //   final args =
  //       ModalRoute.of(context)!.settings.arguments as MVSSScreenArguments;
  //   GlobalDataBase globalData = Provider.of<GlobalDataBase>(context);

  //   setState(() {
  //     // Get the attendance object
  //     theAttendanceModel = globalData.attendance.firstWhere((attendanceModel) {
  //       if (attendanceModel.id == args.attendanceList.id) {
  //         return true;
  //       }
  //       return false;
  //     });

  //     // Check if the student is for the class
  //     student = theAttendanceModel.theClassList.studentObjects.firstWhere(
  //       (_student) => _student.matricNumber == args.matricNumber,
  //       orElse: () => StudentModel.fromDummy(),
  //     );
  //     if (student.id != 0) {
  //       // Check if attendance has been marked for student before
  //       AttendanceItemModel inRecords =
  //           theAttendanceModel.theAttendance.firstWhere(
  //         (attRecord) => attRecord.studentMatric == args.matricNumber,
  //         orElse: () {
  //           return AttendanceItemModel.fromDummy();
  //         },
  //       );

  //       if (inRecords.id != 0) {
  //         globalData.message = "STUDENT IN LIST ALREADY";
  //         redirect = true;
  //       }
  //       inList = true;
  //     } else {
  //       redirect = true;
  //       globalData.message = "STUDENT NOT IN CLASS LIST";
  //     }
  //   });
  //   if (redirect) {
  //     Navigator.pushReplacementNamed(context, MobileWarningScreen.routeName,
  //         arguments: MWScreenArguments(globalData.message));
  //   }
  //   super.didUpdateWidget(oldWidget);
  // }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as MVSSScreenArguments;
    GlobalDataBase globalData = Provider.of<GlobalDataBase>(context);

    setState(() {
      // Get the attendance object
      theAttendanceModel = globalData.attendance.firstWhere((attendanceModel) {
        if (attendanceModel.id == args.attendanceList.id) {
          return true;
        }
        return false;
      });

      // Check if the student is for the class
      student = theAttendanceModel.theClassList.studentObjects.firstWhere(
        (_student) => _student.matricNumber == args.matricNumber,
        orElse: () => StudentModel.fromDummy(),
      );
      if (student.id != 0) {
        // Check if attendance has been marked for student before
        AttendanceItemModel inRecords =
            theAttendanceModel.theAttendance.firstWhere(
          (attRecord) => attRecord.studentMatric == args.matricNumber,
          orElse: () {
            return AttendanceItemModel.fromDummy();
          },
        );

        if (inRecords.id != 0) {
          globalData.message = "STUDENT IN LIST ALREADY";
          redirect = true;
        }
        inList = true;
      } else {
        redirect = true;
        globalData.message = "STUDENT NOT IN CLASS LIST";
      }
    });

    // apiService
    //     .getStudentByMatricForAttendance(
    //         args.matricNumber, args.attendanceList.id)
    //     .then((_student) {
    //   setState(() {
    //     if (_student != null) {
    //       student = _student;
    //       apiService
    //           .getStudentByMatricForAttendanceConfirm(
    //               args.matricNumber, args.attendanceList.id)
    //           .then((value) {
    //         setState(() {
    //           marked = value;
    //           if (marked) {
    //             Navigator.pop(context);
    //           }
    //         });
    //       });
    //       inList = true;
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
                        "${args.attendanceList.theClassList.name.toUpperCase()} : ${args.attendanceList.theClassList.courseCode.toUpperCase()} ",
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
                    // IconButton(
                    //   onPressed: () {},
                    //   icon: const Icon(Icons.arrow_back),
                    // ),
                    const SizedBox(
                      width: 5,
                      height: 1,
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
                      width: 5,
                      height: 1,
                    )
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 1,
            ),
            //App Bar End
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CachedNetworkImage(
                imageUrl: student.imageURL,
                height: 305,
                width: 242,
                fit: BoxFit.cover,
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    CircularProgressIndicator(value: downloadProgress.progress),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              student.matricNumber == StudentModel.fromDummy().matricNumber
                  ? globalData.message
                  : student.matricNumber,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              student.getFullName() == StudentModel.fromDummy().getFullName()
                  ? "Check QR Code"
                  : student.getFullName(),
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w300,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              student.department == StudentModel.fromDummy().department
                  ? "_______________"
                  : student.department,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 30),
            Visibility(
              visible: inList && !marked && !redirect,
              child: TextButton(
                onPressed: () async {
                  int id = 0;
                  if (!marked) {
                    AttendanceItemModel at = AttendanceItemModel(
                        id: id,
                        attendanceListId: args.attendanceList.id,
                        studentId: student.id,
                        studentMatric: student.matricNumber,
                        timeRecord: DateTime.now());
                    apiService.createAttendanceItem(at).then((created) {
                      if (created) {
                        globalData.refreshData(false).then((value) {
                          Navigator.pushNamed(
                            context,
                            MobileStudentAttendanceListScreen.routeName,
                            arguments: MSALScreenArguments(args.attendanceList),
                          );
                        });
                      }
                    });
                  }
                },
                style: TextButton.styleFrom(
                    backgroundColor: InAppColors.secondaryColor,
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20)),
                child: const Text(
                  "Mark Attendance",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Visibility(
              visible: redirect,
              child: Text(globalData.message),
            ),
            Visibility(
              visible: redirect,
              child: TextButton(
                onPressed: () {
                  if (redirect) {
                    // Navigator.pop(context);
                    int count = 0;
                    Navigator.of(context).popUntil((_) => count++ >= 2);
                  }
                },
                style: TextButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20)),
                child: const Text(
                  "Return To List Page",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
