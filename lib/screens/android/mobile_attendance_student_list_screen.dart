import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:qr_attendance_desktop_client/models/attendance_model.dart';
import 'package:qr_attendance_desktop_client/screens/android/mobile_qr_scanning_screen.dart';
import 'package:qr_attendance_desktop_client/utils/api_services.dart';
import 'package:qr_attendance_desktop_client/utils/in_app_colors.dart';

class MSALScreenArguments {
  final AttendanceModel attendanceModel;

  MSALScreenArguments(this.attendanceModel);
}

class MobileStudentAttendanceListScreen extends StatefulWidget {
  // final AttendanceModel attendanceModel;
  const MobileStudentAttendanceListScreen({Key? key}) : super(key: key);
  static const routeName = '/mobile/student_attendance_list_screen';

  @override
  State<MobileStudentAttendanceListScreen> createState() =>
      _MobileStudentAttendanceListScreenState();
}

class _MobileStudentAttendanceListScreenState
    extends State<MobileStudentAttendanceListScreen> {
  String get pageHeader => ('Lecture Schedule');
  late List<AttendanceItemModel> _attendanceItemList;
  late APIService apiService;

  @override
  void initState() {
    _attendanceItemList = [];
    apiService = APIService();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as MSALScreenArguments;

    apiService.getAttendanceByID(args.attendanceModel.id).then((value) {
      setState(() {
        _attendanceItemList = value.theAttendance;
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
                        "${args.attendanceModel.theClassList.name.toUpperCase()} : ${args.attendanceModel.theClassList.courseCode.toUpperCase()} ",
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                  children: _attendanceItemList
                      .map((item) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: TextButton(
                                style: TextButton.styleFrom(
                                    alignment: Alignment.center,
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 20),
                                    backgroundColor:
                                        InAppColors.secondaryColor),
                                onPressed: () {},
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
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            child: Image.network(
                                              item.student.imageURL,
                                              height: 60,
                                              width: 60,
                                              fit: BoxFit.cover,
                                            ),
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
                                              Icon(Icons.abc,
                                                  color:
                                                      InAppColors.primaryColor),
                                              const SizedBox(width: 10),
                                              Text(
                                                item.student.matricNumber,
                                                style: const TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.white),
                                              ),
                                            ],
                                          ),
                                          //Date End
                                          // const SizedBox(height: 5),
                                          //Date Start
                                          Row(
                                            children: [
                                              Icon(Icons.person,
                                                  color:
                                                      InAppColors.primaryColor),
                                              const SizedBox(width: 10),
                                              Text(
                                                item.student.getFullName(),
                                                style: const TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w300,
                                                    color: Colors.white),
                                              ),
                                            ],
                                          ),
                                          //Date End
                                          // const SizedBox(height: 5),
                                          //Time Start
                                          Row(
                                            children: [
                                              Icon(Icons.access_time,
                                                  color:
                                                      InAppColors.primaryColor),
                                              const SizedBox(width: 10),
                                              Text(
                                                DateFormat('hh:mm aaa')
                                                    .format(item.timeRecord)
                                                    .toString(),
                                                style: const TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w300,
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

            // ClipRRect(
            //   borderRadius: BorderRadius.circular(10),
            //   child: TextButton(
            //     style: TextButton.styleFrom(
            //         alignment: Alignment.center,
            //         padding: const EdgeInsets.symmetric(vertical: 20),
            //         backgroundColor: InAppColors.secondaryColor),
            //     onPressed: () {},
            //     child: Padding(
            //       padding: const EdgeInsets.symmetric(horizontal: 20),
            //       child: Row(
            //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //         children: [
            //           Column(
            //             mainAxisAlignment: MainAxisAlignment.center,
            //             children: const [
            //               Text(
            //                 "Class 1",
            //                 style: TextStyle(
            //                     fontSize: 15,
            //                     fontWeight: FontWeight.w600,
            //                     color: Colors.white),
            //               ),
            //             ],
            //           ),
            //           Column(
            //             mainAxisAlignment: MainAxisAlignment.center,
            //             crossAxisAlignment: CrossAxisAlignment.start,
            //             children: [
            //               //Date Start
            //               Row(
            //                 children: [
            //                   Icon(Icons.calendar_month,
            //                       color: InAppColors.primaryColor),
            //                   const SizedBox(width: 10),
            //                   const Text(
            //                     "12-12-2022",
            //                     style: TextStyle(
            //                         fontSize: 15,
            //                         fontWeight: FontWeight.w400,
            //                         color: Colors.white),
            //                   ),
            //                 ],
            //               ),
            //               //Date End
            //               const SizedBox(height: 10),
            //               //Time Start
            //               Row(
            //                 children: [
            //                   Icon(Icons.access_time,
            //                       color: InAppColors.primaryColor),
            //                   const SizedBox(width: 10),
            //                   const Text(
            //                     "8:00AM",
            //                     style: TextStyle(
            //                         fontSize: 15,
            //                         fontWeight: FontWeight.w400,
            //                         color: Colors.white),
            //                   ),
            //                 ],
            //               ),
            //               //Time End
            //             ],
            //           ),
            //         ],
            //       ),
            //     ),
            //   ),
            // ),

            const SizedBox(height: 30),
          ]),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(
            context,
            MobileQRScanningScreen.routeName,
            arguments: MQRSScreenArguments(args.attendanceModel),
          );
          // Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //         builder: ((context) =>
          //             MobileQRScanningScreen(attendanceModel: args.attendanceModel))));
        },
        backgroundColor: const Color.fromARGB(255, 27, 74, 84),
        child: const Icon(Icons.qr_code),
      ),
    );
  }
}
