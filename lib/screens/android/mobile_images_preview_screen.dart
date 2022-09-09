import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_attendance_desktop_client/models/global_data.dart';
import 'package:qr_attendance_desktop_client/models/student_model.dart';
import 'package:qr_attendance_desktop_client/utils/api_services.dart';
import 'package:qr_attendance_desktop_client/utils/in_app_colors.dart';
import 'package:cached_network_image/cached_network_image.dart';

// class MIPScreenArguments {
//   final AttendanceModel attendanceModel;

//   MIPScreenArguments(this.attendanceModel);
// }

class MobileImagesPreviewScreen extends StatefulWidget {
  // final AttendanceModel attendanceModel;
  const MobileImagesPreviewScreen({Key? key}) : super(key: key);
  static const routeName = '/mobile/all_students';

  @override
  State<MobileImagesPreviewScreen> createState() =>
      _MobileImagesPreviewScreenState();
}

class _MobileImagesPreviewScreenState extends State<MobileImagesPreviewScreen> {
  String get pageHeader => ('All Students In Database');
  late List<StudentModel> _students;
  late APIService apiService;

  @override
  void initState() {
    _students = [];
    apiService = APIService();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final args =
    //     ModalRoute.of(context)!.settings.arguments as MIPScreenArguments;

    // apiService.getAllStudents().then((value) {
    //   setState(() {
    //     _students = value;
    //   });
    // });
    GlobalDataBase globalData = Provider.of<GlobalDataBase>(context);
    setState(() {
      _students = globalData.students;
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
                    children: const [
                      Text(
                        "CLASS",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            fontFamily: "Ubuntu"),
                      ),
                      Text(
                        "ALL STUDENTS ",
                        style: TextStyle(
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

            // const Text(
            //   "Choose class:",
            //   style: TextStyle(
            //     fontSize: 15,
            //     fontWeight: FontWeight.w600,
            //   ),
            // ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                  children: _students
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
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return SimpleDialog(
                                          alignment: Alignment.center,
                                          title: Text(item.matricNumber,
                                              textAlign: TextAlign.center),
                                          children: [
                                            Stack(
                                              alignment: Alignment.center,
                                              children: [
                                                ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                  child: CachedNetworkImage(
                                                    imageUrl: item.imageURL,
                                                    height: 400,
                                                    // width: 100,
                                                    fit: BoxFit.fitWidth,
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
                                                  ),
                                                ),
                                                Positioned(
                                                  right: 0,
                                                  left: 0,
                                                  bottom: 10,
                                                  child: Container(
                                                    margin: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 50),
                                                    decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20)),
                                                    alignment: Alignment.center,
                                                    height: 40,
                                                    child: Text(
                                                        item.getFullName()),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ]);
                                    },
                                  );
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
                                          Stack(
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                                child: CachedNetworkImage(
                                                  imageUrl: item.imageURL,
                                                  height: 60,
                                                  width: 60,
                                                  fit: BoxFit.cover,
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
                                                ),
                                              ),
                                              Positioned(
                                                  right: 0,
                                                  bottom: 0,
                                                  child: Container(
                                                    height: 20,
                                                    width: 20,
                                                    alignment: Alignment.center,
                                                    decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(50)),
                                                    child: Text(
                                                        item.id.toString()),
                                                  ))
                                            ],
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
                                                item.matricNumber,
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
                                                item.getFullName(),
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
                                              Icon(Icons.abc,
                                                  color:
                                                      InAppColors.primaryColor),
                                              const SizedBox(width: 10),
                                              Text(
                                                item.department,
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

            const SizedBox(height: 30),
          ]),
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     Navigator.pushNamed(
      //       context,
      //       MobileQRScanningScreen.routeName,
      //       arguments: MQRSScreenArguments(args.attendanceModel),
      //     );
      //   },
      //   backgroundColor: const Color.fromARGB(255, 27, 74, 84),
      //   child: const Icon(Icons.qr_code),
      // ),
    );
  }
}
