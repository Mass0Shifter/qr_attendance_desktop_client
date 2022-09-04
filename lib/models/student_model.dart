import 'dart:convert';

class StudentModel {
  late int id;
  late String firstName;
  late String middleName;
  late String lastName;
  late String department;
  late String matricNumber;
  // late String imageBlob;
  late String imageURL;

  StudentModel({
    required this.id,
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.department,
    required this.matricNumber,
    required this.imageURL,
  });

  // getImage() {
  //   // image is a Uint8List
  //   // var image = const Base64Codec().decode(imageBlob);
  //   // toByteData
  //   // return Container(child: new Image.memory(image));
  //   return const Base64Codec().decode(imageBlob);
  // }
  getFullName() {
    return firstName + " " + middleName + " " + lastName;
  }

  StudentModel.fromJson(Map<String, dynamic> json) {
    id = int.parse(json['id']);
    firstName = json['first_name'];
    middleName = json['middle_name'];
    lastName = json['last_name'];
    department = json['department'];
    matricNumber = json['matric_number'];
    imageURL = "https://vg3ds.com/qr_php/public/" + json['img_src'];
  }
}
