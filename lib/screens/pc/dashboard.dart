import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  final dynamic drawer;
  const DashboardScreen({Key? key, required this.drawer}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final String _appBarTitle = "Home Screen";
  final TextEditingController _searchController = TextEditingController();
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
                        height: 50,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: TextFormField(
                                  onChanged: (value) {
                                    // if (value.isNotEmpty) {
                                    //   FocusScope.of(context)
                                    //       .nextFocus();
                                    // }
                                    // boxOne = value;
                                  },
                                  controller: _searchController,
                                  onSaved: (fBox) {
                                    // setState(() {
                                    //   boxOne = fBox.toString();
                                    // });
                                  },
                                  keyboardType: TextInputType.text,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    // fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  expands: true,
                                  maxLength: null,
                                  maxLines: null,
                                  decoration: InputDecoration(
                                    hintText: "Search Student",
                                    hintStyle: const TextStyle(
                                      // fontSize: 20,
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
                                  onPressed: () {},
                                  child: Row(
                                    children: const [
                                      Icon(Icons.search, color: Colors.white),
                                      Text("Search"),
                                    ],
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
            )
          ],
        ),
      )),
    );
  }
}
