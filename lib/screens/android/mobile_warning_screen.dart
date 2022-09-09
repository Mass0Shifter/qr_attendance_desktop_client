import 'package:flutter/material.dart';
import 'package:qr_attendance_desktop_client/utils/in_app_colors.dart';

class MWScreenArguments {
  final String message;

  MWScreenArguments(this.message);
}

class MobileWarningScreen extends StatefulWidget {
  const MobileWarningScreen({Key? key}) : super(key: key);
  static const String routeName = "/mobile/warning";

  @override
  State<MobileWarningScreen> createState() => _MobileWarningScreenState();
}

class _MobileWarningScreenState extends State<MobileWarningScreen> {
  String pageHeader = "MENU";
  @override
  Widget build(BuildContext context) {
    // final args =
    //     ModalRoute.of(context)!.settings.arguments as MWScreenArguments;
    // GlobalDataBase globalData = Provider.of<GlobalDataBase>(context);

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
                        " Message ",
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

            const Text(
              "Choose class:",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 10),

            const SizedBox(height: 30),
          ]),
        ),
      ),
    );
  }
}
