import 'package:flutter/material.dart';
import 'package:qr_attendance_desktop_client/models/attendance_model.dart';
import 'package:qr_attendance_desktop_client/models/student_model.dart';
import 'package:qr_attendance_desktop_client/screens/android/mobile_attendance_student_list_screen.dart';
import 'package:qr_attendance_desktop_client/utils/api_services.dart';
import 'package:qr_attendance_desktop_client/utils/in_app_colors.dart';

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
  StudentModel student = StudentModel.fromDummy();
  bool inList = false;
  bool marked = false;

  @override
  void initState() {
    apiService = APIService();
    inList = false;
    marked = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as MVSSScreenArguments;

    apiService
        .getStudentByMatricForAttendance(
            args.matricNumber, args.attendanceList.id)
        .then((_student) {
      setState(() {
        if (_student != null) {
          student = _student;
          apiService
              .getStudentByMatricForAttendanceConfirm(
                  args.matricNumber, args.attendanceList.id)
              .then((value) {
            setState(() {
              marked = value;
              if (marked) {
                Navigator.pop(context);
              }
            });
          });
          inList = true;
        }
      });
    });

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
              child: Image.network(
                student.imageURL,
                fit: BoxFit.cover,
                width: 242,
                height: 305,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              student.matricNumber,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              student.getFullName(),
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w300,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              student.department,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 30),
            Visibility(
              visible: inList && !marked,
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
                        Navigator.pushNamed(
                          context,
                          MobileStudentAttendanceListScreen.routeName,
                          arguments: MSALScreenArguments(args.attendanceList),
                        );
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) =>
                        //         MobileStudentAttendanceListScreen(
                        //       attendanceModel: widget.attendanceList,
                        //     ),
                        //   ),
                        // );
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
            )
          ]),
        ),
      ),
    );
  }
}
