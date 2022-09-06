import 'dart:io';
import 'package:flutter/material.dart';
import 'package:qr_attendance_desktop_client/models/class_model.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:qr_attendance_desktop_client/models/student_model.dart';
import 'package:qr_attendance_desktop_client/utils/api_services.dart';

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

    apiService.getAllStudents().then((value) {
      setState(() {
        _allStudents = value;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Colors.blue,
      body: SafeArea(
        child: SizedBox(
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
                  margin: const EdgeInsets.all(100),
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  // width: MediaQuery.of(context).size.width,
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
                                controller: _nameController,
                                keyboardType: TextInputType.text,
                                decoration: const InputDecoration(
                                    prefixIcon: Icon(Icons.person),
                                    border: InputBorder.none,
                                    hintText:
                                        "Class Name : All Computer Students A Class",
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
                                controller: _courseCodeController,
                                keyboardType: TextInputType.text,
                                decoration: const InputDecoration(
                                    prefixIcon: Icon(Icons.person),
                                    border: InputBorder.none,
                                    hintText: "Course Code : Ohio",
                                    hintStyle:
                                        TextStyle(color: Colors.black12)),
                              ),
                            ),
                            const SizedBox(height: 20),
                            const Text("STUDENT",
                                style: TextStyle(color: Colors.black)),
                            Container(
                              decoration: const BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        color: Colors.black26, width: 1)),
                              ),
                              child: DropdownSearch<String>.multiSelection(
                                dropdownSearchDecoration: const InputDecoration(
                                    labelText: "Pick Student",
                                    hintText: "Search Student Matric Number"),
                                // popupItemDisabled:
                                //     (DropdownMenuItem<String> d) {
                                //   return false;
                                // },
                                showSearchBox: true,
                                showClearButton: true,
                                selectedItems: _selectedStudents,
                                items: _allStudents
                                    .map((e) => e.matricNumber)
                                    .toList(),
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
                                            int id = 0;
                                            String n = _nameController.text;
                                            String cc =
                                                _courseCodeController.text;
                                            String list =
                                                studentMatricNumbers.substring(
                                                    1,
                                                    studentMatricNumbers
                                                            .length -
                                                        1);
                                            String lecturer = "1";
                                            ClassModel class_ = ClassModel(
                                                id: id,
                                                name: n,
                                                courseCode: cc,
                                                lecturer: lecturer,
                                                studentIds: list);

                                            apiService
                                                .createClass(class_)
                                                .then((value) {
                                              if (value) {
                                                Navigator.pop(context);
                                                // showDialog(
                                                //   context: context,
                                                //   builder:
                                                //       (BuildContext context) {
                                                //     return SimpleDialog(
                                                //         title: const Text(
                                                //             'Students In Attendance'),
                                                //         children: [
                                                //           SimpleDialogOption(
                                                //               onPressed: () {
                                                //                 Navigator.popUntil(
                                                //                     context,
                                                //                     ModalRoute
                                                //                         .withName(
                                                //                             '/classes'));
                                                //               },
                                                //               child: Row(
                                                //                   children: const [
                                                //                     Text(
                                                //                         "CLASS LIST CREATED : CLICK TO RETURN TO CLASS MENU"),
                                                //                     SizedBox(
                                                //                         width:
                                                //                             10),
                                                //                   ]))
                                                //         ]);
                                                //   },
                                                // );
                                              }
                                            });
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
