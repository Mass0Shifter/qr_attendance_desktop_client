import 'package:flutter/material.dart';
import 'package:qr_attendance_desktop_client/utils/in_app_colors.dart';
import 'package:qr_attendance_desktop_client/utils/in_app_images.dart';

class ProgressHUD extends StatelessWidget {
  final Widget child;
  final bool inAsyncCall;
  final double opacity;
  final Color color;
  // final Animation<Color> valueColor;

  const ProgressHUD({
    Key? key,
    required this.child,
    required this.inAsyncCall,
    this.opacity = 0.3,
    this.color = Colors.grey,
    // required this.valueColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> widgetList = [];
    widgetList.add(child);
    if (inAsyncCall) {
      final modal = Stack(
        children: [
          Opacity(
            opacity: opacity,
            child: ModalBarrier(dismissible: false, color: color),
          ),
          Center(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InAppImages.appLogoImage,
              const SizedBox(
                height: 20,
              ),
              CircularProgressIndicator(
                backgroundColor: InAppColors.primaryColor,
              )
            ],
          )),
        ],
      );
      widgetList.add(modal);
    }
    return Stack(
      children: widgetList,
    );
  }
}
