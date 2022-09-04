import 'package:flutter/material.dart';
import 'package:qr_attendance_desktop_client/models/student_model.dart';
import 'package:qr_attendance_desktop_client/utils/api_services.dart';

class StudentsScreen extends StatefulWidget {
  final dynamic drawer;
  const StudentsScreen({Key? key, required this.drawer}) : super(key: key);

  @override
  State<StudentsScreen> createState() => _StudentsScreenState();
}

class _StudentsScreenState extends State<StudentsScreen> {
  late APIService apiService;
  final String _appBarTitle = "Students";
  final TextEditingController _searchController = TextEditingController();
  final double gapping = 20;
  List<StudentModel> _students = [];

  @override
  void initState() {
    apiService = APIService();
    apiService.getAllStudents().then((value) => _students = value);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 30, 30, 30),
        title: Text(_appBarTitle),
      ),
      drawer: widget.drawer(),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                //Search Students Card
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        gradient: const LinearGradient(colors: <Color>[
                          Color.fromARGB(255, 30, 30, 30),
                          Color.fromARGB(255, 27, 78, 89)
                        ]),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: const [
                          BoxShadow(
                              color: Colors.black12,
                              offset: Offset(0, 5),
                              blurRadius: 1,
                              spreadRadius: 2)
                        ]),
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    // height: 150,
                    child: Column(children: [
                      Container(
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(colors: <Color>[
                            Color.fromARGB(255, 30, 30, 30),
                            Color.fromARGB(255, 27, 78, 89)
                          ]),
                          color: const Color.fromARGB(255, 30, 30, 30),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 50),
                        height: 40,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: _searchController,
                                  keyboardType: TextInputType.text,
                                  // textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    // fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  // expands: true,
                                  // maxLength: null,
                                  // maxLines: null,
                                  decoration: InputDecoration(
                                    hintText: "Search Student",
                                    hintStyle: const TextStyle(
                                      fontWeight: FontWeight.w300,
                                      height: 1,
                                    ),
                                    fillColor: Colors.white,
                                    filled: true,
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                        width: 1,
                                        color: Colors.green,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                        width: 1,
                                        color: Colors.blue,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              TextButton(
                                  onPressed: () async {
                                    setState(() {
                                      apiService
                                          .getAllStudents()
                                          .then((value) => _students = value);
                                    });
                                  },
                                  child: Container(
                                    height: 50,
                                    width: 120,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.teal,
                                    ),
                                    child: Row(
                                      children: const [
                                        Icon(
                                          Icons.search,
                                          color: Colors.black,
                                        ),
                                        SizedBox(width: 10),
                                        Text(
                                          "Search",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ))
                            ]),
                      ),
                      const SizedBox(height: 10),
                    ]),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                //Students Card
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: const [
                          BoxShadow(
                              color: Colors.black12,
                              offset: Offset(0, 5),
                              blurRadius: 1,
                              spreadRadius: 2)
                        ]),
                    height: 150,
                    child: Column(children: [
                      Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(colors: <Color>[
                            Color.fromARGB(255, 30, 30, 30),
                            Color.fromARGB(255, 27, 78, 89)
                          ]),
                          color: Color.fromARGB(255, 30, 30, 30),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 50),
                        height: 50,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text(
                                "Students",
                                style: TextStyle(color: Colors.white),
                              ),
                              Icon(Icons.person, color: Colors.white)
                            ]),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        "50",
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text("Total - Students"),
                    ]),
                  ),
                ),
                const SizedBox(width: 20),
                //Classes Card
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: const [
                          BoxShadow(
                              color: Colors.black12,
                              offset: Offset(0, 5),
                              blurRadius: 1,
                              spreadRadius: 2)
                        ]),
                    height: 150,
                    child: Column(children: [
                      Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(colors: <Color>[
                            Color.fromARGB(255, 30, 30, 30),
                            Color.fromARGB(255, 27, 78, 89)
                          ]),
                          color: Color.fromARGB(255, 30, 30, 30),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 50),
                        height: 50,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text(
                                "Classes",
                                style: TextStyle(color: Colors.white),
                              ),
                              Icon(Icons.class_, color: Colors.white)
                            ]),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        "5",
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text("Total - Classes"),
                    ]),
                  ),
                ),
                const SizedBox(width: 20),
                //Attendances Card
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            offset: Offset(0, 5),
                            blurRadius: 1,
                            spreadRadius: 2,
                          ),
                        ]),
                    height: 150,
                    child: Column(children: [
                      Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(colors: <Color>[
                            Color.fromARGB(255, 30, 30, 30),
                            Color.fromARGB(255, 27, 78, 89)
                          ]),
                          color: Color.fromARGB(255, 30, 30, 30),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 50),
                        height: 50,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text(
                                "Attendance Collections",
                                style: TextStyle(color: Colors.white),
                              ),
                              Icon(Icons.view_list, color: Colors.white)
                            ]),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        "13",
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text("Total - Attendances"),
                    ]),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 50),
            Row(
              children: [
                DataTable(
                    columns: const [
                      DataColumn(label: Text("Image")),
                      DataColumn(label: Text("Full Name")),
                      DataColumn(label: Text("Department")),
                      DataColumn(label: Text("Metric Number")),
                      DataColumn(label: Text("Actions")),
                    ],
                    rows: _students
                        .map((e) => DataRow(cells: [
                              DataCell(
                                  // Image.network(e.imageURL)
                                  Container(
                                height: 80,
                                width: 80,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(40),
                                  border: Border.all(
                                    width: 1,
                                    // color: Colors.amberAccent,
                                  ),
                                ),
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(40),
                                    child: Image.network(
                                      e.imageURL,
                                      fit: BoxFit.cover,
                                    )),
                              )),
                              DataCell(Text(e.getFullName())),
                              DataCell(Text(e.department)),
                              DataCell(Text(e.matricNumber)),
                              DataCell(Row(
                                children: [
                                  TextButton(
                                    child: const Text("Edit"),
                                    onPressed: () {},
                                  ),
                                  const SizedBox(width: 5),
                                  TextButton(
                                      child: const Text("Delete"),
                                      onPressed: () {}),
                                ],
                              )),
                            ]))
                        .toList())
              ],
            ),
            // Row(
            //   children: [
            //     Expanded(
            //       child: SizedBox(
            //         height: 300,
            //         child: ListView.builder(
            //           itemCount: _students.length,
            //           itemBuilder: (context, index) {
            //             var currentStudent = _students[index];
            //             return Container(
            //               decoration: const BoxDecoration(
            //                   color: Colors.white,
            //                   boxShadow: [
            //                     BoxShadow(
            //                         color: Colors.black12,
            //                         blurRadius: 1,
            //                         offset: Offset(0, 3))
            //                   ]),
            //               padding: const EdgeInsets.symmetric(
            //                   vertical: 10, horizontal: 30),
            //               child: Row(
            //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //                   children: [
            //                     Container(
            //                       height: 80,
            //                       width: 80,
            //                       decoration: BoxDecoration(
            //                         borderRadius: BorderRadius.circular(40),
            //                         border: Border.all(
            //                           width: 1,
            //                           // color: Colors.amberAccent,
            //                         ),
            //                       ),
            //                       child: ClipRRect(
            //                           borderRadius: BorderRadius.circular(40),
            //                           child: Image.network(
            //                             currentStudent.imageURL,
            //                             fit: BoxFit.cover,
            //                           )),
            //                     ),
            //                     SizedBox(width: gapping),
            //                     Container(
            //                       width: 1,
            //                       height: 80,
            //                       color: Colors.black,
            //                     ),
            //                     SizedBox(width: gapping),
            //                     Text(
            //                       currentStudent.firstName +
            //                           " " +
            //                           currentStudent.middleName +
            //                           " " +
            //                           currentStudent.lastName,
            //                       style: const TextStyle(
            //                         fontSize: 12,
            //                         fontWeight: FontWeight.w700,
            //                       ),
            //                     ),
            //                     SizedBox(width: gapping),
            //                     Container(
            //                       width: 1,
            //                       height: 80,
            //                       color: Colors.black,
            //                     ),
            //                     SizedBox(width: gapping),
            //                     Text(
            //                       currentStudent.department,
            //                       style: const TextStyle(
            //                         fontSize: 12,
            //                         fontWeight: FontWeight.w700,
            //                       ),
            //                     ),
            //                     SizedBox(width: gapping),
            //                     Container(
            //                       width: 1,
            //                       height: 80,
            //                       color: Colors.black,
            //                     ),
            //                     SizedBox(width: gapping),
            //                     Text(
            //                       currentStudent.matricNumber,
            //                       style: const TextStyle(
            //                         fontSize: 12,
            //                         fontWeight: FontWeight.w700,
            //                       ),
            //                     ),
            //                     SizedBox(width: gapping),
            //                     Container(
            //                       width: 1,
            //                       height: 80,
            //                       color: Colors.black,
            //                     ),
            //                     SizedBox(width: gapping),
            //                     TextButton(
            //                       child: const Text("Edit"),
            //                       onPressed: () {},
            //                     ),
            //                     SizedBox(width: gapping),
            //                     TextButton(
            //                         child: const Text("Delete"),
            //                         onPressed: () {}),
            //                   ]),
            //             );
            //           },
            //         ),
            //       ),
            //     ),
            //   ],
            // )
            // FutureBuilder(
            //     future: apiService.getAllStudents(),
            //     builder: (BuildContext context,
            //         AsyncSnapshot<List<StudentModel>> responseModel) {
            //       if (responseModel.hasData) {
            //         var students  =  responseModel.data;
            //       }
            //       return const Text("NO YET");
            //     })
            // FutureBuilder(
            //   future: apiService.getAllStudents(),
            //   builder: (BuildContext context,
            //       AsyncSnapshot<List<StudentModel>> responseModel) {
            //     // print(loginModel.hasData);
            //     if (responseModel.hasData) {
            //       // if (responseModel.data) {
            //       return ListView.builder(
            //         itemCount: _students.length,
            //         itemBuilder: (context, index) {
            //           var currentStudent = responseModel.data![index];
            //           return Container(
            //             decoration: const BoxDecoration(
            //                 color: Colors.white,
            //                 boxShadow: [
            //                   BoxShadow(
            //                       color: Colors.black12,
            //                       blurRadius: 1,
            //                       offset: Offset(0, 3))
            //                 ]),
            //             padding: const EdgeInsets.symmetric(
            //                 vertical: 10, horizontal: 30),
            //             child: Row(
            //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //                 children: [
            //                   Container(
            //                     height: 80,
            //                     width: 80,
            //                     decoration: BoxDecoration(
            //                       borderRadius: BorderRadius.circular(40),
            //                       border: Border.all(
            //                         width: 1,
            //                         // color: Colors.amberAccent,
            //                       ),
            //                     ),
            //                     child: ClipRRect(
            //                         borderRadius: BorderRadius.circular(40),
            //                         child: Image.memory(
            //                           currentStudent.getImage(),
            //                           fit: BoxFit.fitHeight,
            //                         )),
            //                   ),
            //                   SizedBox(width: gapping),
            //                   Container(
            //                     width: 1,
            //                     height: 80,
            //                     color: Colors.black,
            //                   ),
            //                   SizedBox(width: gapping),
            //                   Text(
            //                     currentStudent.firstName +
            //                         " " +
            //                         currentStudent.middleName +
            //                         " " +
            //                         currentStudent.lastName,
            //                     style: const TextStyle(
            //                       fontSize: 12,
            //                       fontWeight: FontWeight.w700,
            //                     ),
            //                   ),
            //                   SizedBox(width: gapping),
            //                   Container(
            //                     width: 1,
            //                     height: 80,
            //                     color: Colors.black,
            //                   ),
            //                   SizedBox(width: gapping),
            //                   Text(
            //                     currentStudent.department,
            //                     style: const TextStyle(
            //                       fontSize: 12,
            //                       fontWeight: FontWeight.w700,
            //                     ),
            //                   ),
            //                   SizedBox(width: gapping),
            //                   Container(
            //                     width: 1,
            //                     height: 80,
            //                     color: Colors.black,
            //                   ),
            //                   SizedBox(width: gapping),
            //                   Text(
            //                     currentStudent.matricNumber,
            //                     style: const TextStyle(
            //                       fontSize: 12,
            //                       fontWeight: FontWeight.w700,
            //                     ),
            //                   ),
            //                   SizedBox(width: gapping),
            //                   Container(
            //                     width: 1,
            //                     height: 80,
            //                     color: Colors.black,
            //                   ),
            //                   SizedBox(width: gapping),
            //                   TextButton(
            //                     child: const Text("Edit"),
            //                     onPressed: () {},
            //                   ),
            //                   SizedBox(width: gapping),
            //                   TextButton(
            //                       child: const Text("Delete"),
            //                       onPressed: () {}),
            //                 ]),
            //           );
            //         },
            //       );
            //     } else {
            //       return Container();
            //     }
            //     // }
            //   },
            // ),
          ],
        ),
      )),
    );
  }
}
