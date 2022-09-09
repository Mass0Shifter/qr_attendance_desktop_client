import 'package:flutter/material.dart';
import 'package:qr_attendance_desktop_client/screens/android/mobile_classes_screen.dart';

class MobileSplashScreen extends StatefulWidget {
  const MobileSplashScreen({Key? key}) : super(key: key);

  @override
  State<MobileSplashScreen> createState() => _MobileSplashScreenState();
}

class _MobileSplashScreenState extends State<MobileSplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      body: Stack(children: [
        Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    // transform: GradientTransform(),
                    colors: [
                  Color.fromARGB(255, 35, 135, 212),
                  Color.fromARGB(255, 27, 73, 78)
                ])),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                SizedBox(
                  height: 50,
                ),
                Text(
                  "QR",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  "ATTENDANCE",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            )),
        Positioned(
          width: MediaQuery.of(context).size.width,
          bottom: 100,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 100),
            child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                ),
                onPressed: () {
                  Navigator.pushNamed(context, MobileClassesScreen.routeName);
                },
                child: const Text(
                  "Welcome",
                  style: TextStyle(color: Colors.white),
                )),
          ),
        ),
        // Consumer<GlobalDataBase>(
        //   builder: (context, value, child) {
        //     return ProgressHUD(
        //       child: Positioned(
        //         width: MediaQuery.of(context).size.width,
        //         bottom: 100,
        //         child: Padding(
        //           padding: const EdgeInsets.symmetric(horizontal: 100),
        //           child: TextButton(
        //               style: TextButton.styleFrom(
        //                 backgroundColor: Colors.blueAccent,
        //               ),
        //               onPressed: () {
        //                 Navigator.pushNamed(
        //                     context, MobileClassesScreen.routeName);
        //               },
        //               child: const Text(
        //                 "Welcome",
        //                 style: TextStyle(color: Colors.white),
        //               )),
        //         ),
        //       ),
        //       inAsyncCall: value.isApiCallProcess,
        //       opacity: 0.3,
        //     );
        //   },
        // )
      ]),
    );
  }
}
