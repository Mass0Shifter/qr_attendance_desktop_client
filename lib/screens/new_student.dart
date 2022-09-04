import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:qr_attendance_desktop_client/utils/in_app_images.dart';

class NewStudentData extends StatefulWidget {
  const NewStudentData({Key? key}) : super(key: key);

  @override
  State<NewStudentData> createState() => _NewStudentDataState();
}

class _NewStudentDataState extends State<NewStudentData> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _middleNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  String department = 'building';
  final TextEditingController _matricNumberController = TextEditingController();
  int currentScreen = 0;
  bool hidePassword = true;
  bool acceptTerms = true;
  bool notNormalUser = true;
  String textUser = "";
  String textOne = "Student Data";
  String textTwo = "Please fill in the fields";
  String imageBlob = InAppImages.blobHolder;

  @override
  void initState() {
    department = 'building';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Welcome Text
                Container(
                  margin: const EdgeInsets.only(top: 100),
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50),
                      )),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 80),
                        Text(
                          textOne,
                          style: const TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          textTwo,
                          style: const TextStyle(
                            color: Colors.blueGrey,
                            fontWeight: FontWeight.bold,
                            fontSize: 11,
                          ),
                        ),
                        const SizedBox(height: 30),
                        Column(
                          children: [
                            // First Name Input
                            Container(
                              decoration: const BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        color: Colors.black26, width: 1)),
                              ),
                              child: TextFormField(
                                controller: _firstNameController,
                                keyboardType: TextInputType.text,
                                decoration: const InputDecoration(
                                    prefixIcon: Icon(Icons.person),
                                    border: InputBorder.none,
                                    hintText: "Frist Name : John",
                                    hintStyle:
                                        TextStyle(color: Colors.black12)),
                              ),
                            ),
                            const SizedBox(height: 20),
                            // Middle Name Input
                            Container(
                              decoration: const BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        color: Colors.black26, width: 1)),
                              ),
                              child: TextFormField(
                                controller: _middleNameController,
                                keyboardType: TextInputType.text,
                                decoration: const InputDecoration(
                                    prefixIcon: Icon(Icons.person),
                                    border: InputBorder.none,
                                    hintText: "Middle Name : Ohio",
                                    hintStyle:
                                        TextStyle(color: Colors.black12)),
                              ),
                            ),
                            const SizedBox(height: 20),
                            // Last Name Input
                            Container(
                              decoration: const BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        color: Colors.black26, width: 1)),
                              ),
                              child: TextFormField(
                                controller: _lastNameController,
                                keyboardType: TextInputType.text,
                                decoration: const InputDecoration(
                                    prefixIcon: Icon(Icons.person),
                                    border: InputBorder.none,
                                    hintText: "Last Name : Doe",
                                    hintStyle:
                                        TextStyle(color: Colors.black12)),
                              ),
                            ),
                            const SizedBox(height: 20),
                            // Email Input

                            // Confirm Password Input
                            Container(
                              decoration: const BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        color: Colors.black26, width: 1)),
                              ),
                              child: TextFormField(
                                controller: _matricNumberController,
                                keyboardType: TextInputType.text,
                                decoration: const InputDecoration(
                                    prefixIcon: Icon(Icons.numbers),
                                    border: InputBorder.none,
                                    hintText: "Matric Number",
                                    hintStyle:
                                        TextStyle(color: Colors.black12)),
                              ),
                            ),
                            const SizedBox(height: 20),
                            const Text("Department",
                                style: TextStyle(color: Colors.black)),
                            Container(
                              decoration: const BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        color: Colors.black26, width: 1)),
                              ),
                              child: DropdownButton(
                                items: const [
                                  DropdownMenuItem(
                                    child: Text("Civil"),
                                    value: "civil",
                                  ),
                                  DropdownMenuItem(
                                    child: Text("Building"),
                                    value: "building",
                                  )
                                ],
                                onChanged: (value) {
                                  setState(() {
                                    department = value.toString();
                                  });
                                },
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontFamily: "Ubuntu",
                                  fontWeight: FontWeight.w700,
                                  fontSize: 18,
                                ),
                                dropdownColor: Colors.blue[200],
                                borderRadius: BorderRadius.circular(20),
                                iconEnabledColor: Colors.white,
                                iconSize: 40,
                                value: department,
                                isExpanded: true,
                                underline: Container(
                                  height: 2,
                                  // color: Colors.black,
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            // Forgot Password
                            // Login Button
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(30),
                                  child: Stack(
                                    children: <Widget>[
                                      Positioned.fill(
                                          child: Container(
                                        decoration: const BoxDecoration(
                                            color: Colors.blue),
                                        // height: 50,
                                      )),
                                      TextButton(
                                          style: TextButton.styleFrom(
                                            padding: const EdgeInsets.all(16.0),
                                            primary: Colors.white,
                                            textStyle:
                                                const TextStyle(fontSize: 20),
                                          ),
                                          onPressed: () {
                                            // String id = 0.toString();
                                            // String fn =
                                            //     _firstNameController.text;
                                            // String mn =
                                            //     _middleNameController.text;
                                            // String ln =
                                            //     _lastNameController.text;
                                            // String dept = department;
                                            // String matn =
                                            //     _matricNumberController.text;

                                            // String studentDataHeader =
                                            //     'ID,FIRSTNAME,MIDDLENAME,LASTNAME,DEPARTMENT,MATRICNUMBER';
                                            // String studentData =
                                            //     '$id,$fn,$mn,$ln,$dept,$matn';
                                            // context
                                            //     .read<FileController>()
                                            //     .writeText(<String>[
                                            //   studentDataHeader,
                                            //   studentData
                                            // ]);
                                          },
                                          child: const Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child: Text(
                                              "Create Student Data",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ))
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 40),
                        Image.memory(const Base64Codec().decode(imageBlob)),
                        IconButton(
                            onPressed: () async {
                              // FilePickerResult? result =
                              //     await FilePicker.platform.pickFiles();

                              // if (result != null) {
                              //   DB.File file = DB.File(
                              //       result.files.single.path.toString());
                              //   Uint8List bytes =
                              //       await file.readAsBytes(); // Uint8List
                              //   // final byteData =
                              //   //     bytes.buffer.asByteData(); // ByteData
                              //   Blob blob = Blob(bytes);
                              //   setState(() {
                              //     imageBlob = blob.toString();
                              //     // ByteData.view(bytes.buffer).toString();
                              //   });
                              // } else {
                              //   // User canceled the picker
                              // }
                            },
                            icon: const Icon(Icons.abc))
                      ]),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
