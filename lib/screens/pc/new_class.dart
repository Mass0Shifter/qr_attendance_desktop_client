import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_attendance_desktop_client/models/class_model.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:qr_attendance_desktop_client/models/global_data.dart';
import 'package:qr_attendance_desktop_client/models/student_model.dart';
import 'package:qr_attendance_desktop_client/utils/api_services.dart';
import 'package:qr_attendance_desktop_client/utils/in_app_colors.dart';

class NewClassData extends StatefulWidget {
  const NewClassData({Key? key}) : super(key: key);

  @override
  State<NewClassData> createState() => _NewClassDataState();
}

class _NewClassDataState extends State<NewClassData> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _courseCodeController = TextEditingController();
  // final TextEditingController _studentIdsController = TextEditingController();
  String studentMatricNumbers = "";
  String textUser = "";
  String textOne = "Class Data";
  String textTwo = "Please fill in the fields";
  late File image;
  late APIService apiService;
  bool imaged = false;
  late List<StudentModel> _allStudents = [];
  late List<String> _selectedStudents = [];

  @override
  void initState() {
    studentMatricNumbers = '';
    apiService = APIService();
    _allStudents = [];
    _selectedStudents = [];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    GlobalDataBase globalData = Provider.of<GlobalDataBase>(context);
    setState(() {
      _allStudents = globalData.students;
    });
    return Scaffold(
      appBar: AppBar(
        backgroundColor: InAppColors.secondaryBackgroundColor,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(100),
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
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
            const SizedBox(height: 80),
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
            const SizedBox(height: 30),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // First Name Input
                Container(
                  decoration: const BoxDecoration(
                    border: Border(
                        bottom: BorderSide(color: Colors.white, width: 1)),
                  ),
                  child: TextFormField(
                    controller: _nameController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Icons.person,
                        color: Colors.white,
                      ),
                      border: InputBorder.none,
                      hintText: "Class Name",
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
                    controller: _courseCodeController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Icons.qr_code_rounded,
                        color: Colors.white,
                      ),
                      border: InputBorder.none,
                      hintText: "Course Code",
                      hintStyle: _hintStyle(),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Text("STUDENT LIST",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 24,
                    )),
                Container(
                  decoration: const BoxDecoration(
                    border: Border(
                        bottom: BorderSide(color: Colors.white, width: 1)),
                  ),
                  child: DropdownSearch<String>.multiSelection(
                    dropdownSearchDecoration: InputDecoration(
                        labelText: "Pick Student",
                        labelStyle: _hintStyle(),
                        hintText: "Search Student Matric Number",
                        hintStyle: _hintStyle()),
                    // popupItemDisabled:
                    //     (DropdownMenuItem<String> d) {
                    //   return false;
                    // },
                    showSearchBox: true,
                    showClearButton: true,
                    selectedItems: _selectedStudents,
                    items: _allStudents.map((e) => e.matricNumber).toList(),
                    onChanged: (value) {
                      setState(() {
                        studentMatricNumbers = value.toString();
                      });
                    },
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
                      child: TextButton(
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 120, vertical: 20),
                            primary: Colors.white,
                            backgroundColor: InAppColors.primaryColor,
                          ),
                          onPressed: () {
                            int id = 0;
                            String n = _nameController.text;
                            String cc = _courseCodeController.text;
                            String list = studentMatricNumbers.substring(
                                1, studentMatricNumbers.length - 1);
                            String lecturer = "1";
                            ClassModel class_ = ClassModel(
                                id: id,
                                name: n,
                                courseCode: cc,
                                lecturer: lecturer,
                                studentIds: list);

                            apiService.createClass(class_).then((value) {
                              if (value) {
                                globalData.refreshData(false).then((value) {
                                  Navigator.pop(context);
                                });
                              }
                            });
                          },
                          child: const Center(
                            child: Text(
                              "Create Class",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600),
                            ),
                          )),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 40),
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
