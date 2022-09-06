import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qr_attendance_desktop_client/models/attendance_model.dart';
import 'package:qr_attendance_desktop_client/screens/android/mobile_verify_student_screen.dart';
import 'package:qr_attendance_desktop_client/utils/in_app_colors.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class MQRSScreenArguments {
  final AttendanceModel attendanceModel;

  MQRSScreenArguments(this.attendanceModel);
}

class MobileQRScanningScreen extends StatefulWidget {
  const MobileQRScanningScreen({Key? key}) : super(key: key);
  static const routeName = '/mobile/qr_scanning_screen';

  @override
  State<StatefulWidget> createState() => _MobileQRScanningScreenState();
}

class _MobileQRScanningScreenState extends State<MobileQRScanningScreen> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as MQRSScreenArguments;
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(flex: 4, child: _buildQrView(context)),
          Expanded(
            flex: 1,
            child: FittedBox(
              fit: BoxFit.contain,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  const SizedBox(height: 20),
                  if (result != null)
                    Text('${result!.code}',
                        style: const TextStyle(fontSize: 32))
                  // 'Barcode Type: ${describeEnum(result!.format)}   Data: ${result!.code}')
                  else
                    const Text('Scan a code'),
                  Container(
                    margin: const EdgeInsets.all(8),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: InAppColors.secondaryColor),
                      onPressed: () async {
                        if (result != null) {
                          Navigator.pushNamed(
                            context,
                            MobileVerifyStudentScreen.routeName,
                            arguments: MVSSScreenArguments(
                                result!.code.toString(), args.attendanceModel),
                          );
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => MobileVerifyStudentScreen(
                          //               matricNumber: result!.code.toString(),
                          //               attendanceList: widget.attendanceModel,
                          //             )));
                        }
                      },
                      child: const Text('SEARCH STUDENT QR',
                          style: TextStyle(fontSize: 40)),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.all(8),
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: InAppColors.secondaryColor),
                            onPressed: () async {
                              await controller?.toggleFlash();
                              setState(() {});
                            },
                            child: FutureBuilder(
                              future: controller?.getFlashStatus(),
                              builder: (context, snapshot) {
                                return Text('Flash: ${snapshot.data}');
                              },
                            )),
                      ),
                      Container(
                        margin: const EdgeInsets.all(8),
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: InAppColors.secondaryColor),
                            onPressed: () async {
                              await controller?.flipCamera();
                              setState(() {});
                            },
                            child: FutureBuilder(
                              future: controller?.getCameraInfo(),
                              builder: (context, snapshot) {
                                if (snapshot.data != null) {
                                  return Text(
                                      'Camera facing ${describeEnum(snapshot.data!)}');
                                } else {
                                  return const Text('loading');
                                }
                              },
                            )),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.all(8),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: InAppColors.secondaryColor),
                          onPressed: () async {
                            await controller?.pauseCamera();
                          },
                          child: const Text('pause',
                              style: TextStyle(fontSize: 20)),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.all(8),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: InAppColors.secondaryColor),
                          onPressed: () async {
                            await controller?.resumeCamera();
                          },
                          child: const Text('resume',
                              style: TextStyle(fontSize: 20)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 300.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.red,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
