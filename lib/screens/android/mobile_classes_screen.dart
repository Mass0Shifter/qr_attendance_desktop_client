import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_attendance_desktop_client/models/class_model.dart';
import 'package:qr_attendance_desktop_client/models/global_data.dart';
import 'package:qr_attendance_desktop_client/screens/android/mobile_class_attendance_screen.dart';
import 'package:qr_attendance_desktop_client/screens/android/mobile_images_preview_screen.dart';
import 'package:qr_attendance_desktop_client/utils/api_services.dart';
import 'package:qr_attendance_desktop_client/utils/in_app_colors.dart';

// class MCScreenArguments {
//   final ClassModel class_;

//   MCScreenArguments(this.class_);
// }

class MobileClassesScreen extends StatefulWidget {
  const MobileClassesScreen({Key? key}) : super(key: key);
  static const routeName = '/mobile/classes_screen';

  @override
  State<MobileClassesScreen> createState() => _MobileClassesScreenState();
}

class _MobileClassesScreenState extends State<MobileClassesScreen> {
  String pageHeader = "Lecture Schedule";
  String text1 = "Choose Class";
  late List<ClassModel> _classes;
  late APIService apiService;

  @override
  void initState() {
    _classes = [];
    apiService = APIService();

    // apiService.getAllClasses().then((value) {
    //   setState(() {
    //     _classes = value;
    //   });
    // });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    GlobalDataBase globalData = Provider.of<GlobalDataBase>(context);
    setState(() {
      _classes = globalData.classes;
    });
    return Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                //App Bar Start
                Column(
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 27, 74, 84),
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20))),
                      // height: 200,
                      child: Column(
                        children: const [
                          Text(
                            "HOME",
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
                        const SizedBox(
                          width: 30,
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
                          width: 30,
                          height: 1,
                        )
                      ],
                    )
                  ],
                ),
                //App Bar End
                const SizedBox(height: 80),

                Column(children: [
                  Text(
                    text1,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Button Sample
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      children: _classes
                          .map((item) => Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: TextButton(
                                      style: TextButton.styleFrom(
                                          alignment: Alignment.center,
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 32),
                                          backgroundColor:
                                              InAppColors.secondaryColor),
                                      onPressed: () {
                                        Navigator.pushNamed(
                                            context,
                                            MobileClassAttendanceScreen
                                                .routeName,
                                            arguments:
                                                MCASScreenArguments(item));
                                      },
                                      child: Center(
                                        child: Column(
                                          children: [
                                            Text(
                                              item.name,
                                              style: const TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.white),
                                            ),
                                            const SizedBox(height: 5),
                                            Text(
                                              item.courseCode,
                                              style: const TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w300,
                                                  color: Colors.white),
                                            ),
                                          ],
                                        ),
                                      )),
                                ),
                              ))
                          .toList(),
                    ),
                  ),
                ]),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(
              context,
              MobileImagesPreviewScreen.routeName,
            );
          },
          backgroundColor: const Color.fromARGB(255, 27, 74, 84),
          child: const Icon(Icons.settings),
        ));
  }
}
