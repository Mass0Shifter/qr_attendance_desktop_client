import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:qr_attendance_desktop_client/models/student_model.dart';
import 'package:qr_attendance_desktop_client/screens/pc/desktop_students_screen.dart';
import 'package:qr_attendance_desktop_client/utils/api_services.dart';
import 'package:qr_attendance_desktop_client/utils/in_app_colors.dart';
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
  String department = 'Building Technology';
  final TextEditingController _matricNumberController = TextEditingController();
  final List<String> _departments = [
    "Building Technology",
    "Civil Engineering",
    "Mass Communication",
    "Bio-Technology"
  ];
  String textOne = "Student Data";
  String textTwo = "Profile";
  String imageBlob = InAppImages.blobHolder;
  late File image;
  late APIService apiService;
  bool imaged = false;

  @override
  void initState() {
    department = 'Building Technology';
    apiService = APIService();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: InAppColors.secondaryBackgroundColor,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(100),
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
          // width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    blurRadius: 4,
                    offset: const Offset(-12, 12),
                    color: InAppColors.primaryDropShowdow)
              ],
              color: InAppColors.secondaryBackgroundColor,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(50),
                  bottomLeft: Radius.circular(50)),
              border: Border.all(width: 4, color: InAppColors.quadirayColor)),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(clipBehavior: Clip.none, children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: (imaged == false
                          ? Image.memory(
                              const Base64Codec().decode(imageBlob),
                              height: 150,
                              width: 150,
                              fit: BoxFit.cover,
                            )
                          : Image.file(
                              image,
                              height: 150,
                              width: 150,
                              fit: BoxFit.cover,
                            )),
                    ),
                    Positioned(
                      right: -10,
                      bottom: -10,
                      child: TextButton(
                          style: TextButton.styleFrom(
                              backgroundColor: InAppColors.primaryColor,
                              primary: Colors.white,
                              shape: const CircleBorder(),
                              elevation: 1,
                              padding: const EdgeInsets.all(20)),
                          onPressed: () async {
                            FilePickerResult? result =
                                await FilePicker.platform.pickFiles();

                            if (result != null) {
                              File file =
                                  File(result.files.single.path.toString());
                              setState(() {
                                image = file;
                                imaged = true;
                              });
                            } else {
                              // User canceled the picker
                            }
                          },
                          child: const Icon(
                            Icons.add,
                            color: Colors.white,
                          )),
                    )
                  ]),
                  const SizedBox(height: 20),
                  Text(
                    textOne,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 40,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    textTwo,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // First Name Input
                Container(
                  decoration: const BoxDecoration(
                    border: Border(
                        bottom: BorderSide(color: Colors.white, width: 1)),
                  ),
                  child: TextFormField(
                    controller: _firstNameController,
                    keyboardType: TextInputType.text,
                    style: _hintStyle(),
                    decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Icons.person,
                        color: Colors.white,
                      ),
                      border: InputBorder.none,
                      hintText: "Frist Name",
                      hintStyle: _hintStyle(),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // Middle Name Input
                Container(
                  decoration: const BoxDecoration(
                    border: Border(
                        bottom: BorderSide(color: Colors.white, width: 1)),
                  ),
                  child: TextFormField(
                    controller: _middleNameController,
                    keyboardType: TextInputType.text,
                    style: _hintStyle(),
                    decoration: InputDecoration(
                        prefixIcon: const Icon(
                          Icons.person,
                          color: Colors.white,
                        ),
                        border: InputBorder.none,
                        hintText: "Middle Name",
                        hintStyle: _hintStyle()),
                  ),
                ),
                const SizedBox(height: 20),
                // Last Name Input
                Container(
                  decoration: const BoxDecoration(
                    border: Border(
                        bottom: BorderSide(color: Colors.white, width: 1)),
                  ),
                  child: TextFormField(
                    controller: _lastNameController,
                    keyboardType: TextInputType.text,
                    style: _hintStyle(),
                    decoration: InputDecoration(
                        prefixIcon: const Icon(
                          Icons.person,
                          color: Colors.white,
                        ),
                        border: InputBorder.none,
                        hintText: "Last Name",
                        hintStyle: _hintStyle()),
                  ),
                ),
                const SizedBox(height: 20),
                // Email Input

                // Confirm Password Input
                Container(
                  decoration: const BoxDecoration(
                    border: Border(
                        bottom: BorderSide(color: Colors.white, width: 1)),
                  ),
                  child: TextFormField(
                    controller: _matricNumberController,
                    keyboardType: TextInputType.text,
                    style: _hintStyle(),
                    decoration: InputDecoration(
                        prefixIcon: const Icon(
                          Icons.numbers,
                          color: Colors.white,
                        ),
                        border: InputBorder.none,
                        hintText: "Matric Number",
                        hintStyle: _hintStyle()),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  "Department",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                    border: Border(
                        bottom: BorderSide(color: Colors.white, width: 1)),
                  ),
                  child: DropdownButton(
                    items: _departments
                        .map((e) => DropdownMenuItem(
                              child: Text(e),
                              value: e,
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        department = value.toString();
                      });
                    },
                    style: const TextStyle(
                      color: Colors.white,
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
                ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: TextButton(
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 120, vertical: 20),
                        primary: Colors.white,
                        backgroundColor: InAppColors.primaryColor,
                      ),
                      onPressed: () {
                        int id = 0;
                        String fn = _firstNameController.text;
                        String mn = _middleNameController.text;
                        String ln = _lastNameController.text;
                        String dept = department;
                        String matn = _matricNumberController.text;

                        StudentModel student = StudentModel(
                            id: id,
                            firstName: fn,
                            middleName: mn,
                            lastName: ln,
                            department: dept,
                            matricNumber: matn);

                        apiService.createStudent(student, image).then((value) {
                          if (value) {
                            // STUDENT CREATED
                            Navigator.pushNamed(
                                context, DesktopStudentsScreen.routeName,
                                arguments: DSScreenArguments("create"));
                          }
                        });
                      },
                      child: const Center(
                        child: Text(
                          "Create Student",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w600),
                        ),
                      )),
                ),
              ],
            ),
          ]),
        ),
      ),
    );
  }

  TextStyle _hintStyle() {
    return const TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w400,
      fontSize: 24,
    );
  }
}
