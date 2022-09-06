class StudentModel {
  late int id;
  late String firstName;
  late String middleName;
  late String lastName;
  late String department;
  late String matricNumber;
  late String imageURL;

  StudentModel({
    required this.id,
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.department,
    required this.matricNumber,
  });

  getFullName() {
    return "$firstName $lastName";
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

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      "first_name": firstName,
      "middle_name": middleName,
      "last_name": lastName,
      "department": department,
      "matric_number": matricNumber
    };
  }

  StudentModel.fromDummy() {
    id = 0;
    firstName = 'first_dummy';
    middleName = 'middle_dummy';
    lastName = 'last_dummy';
    department = 'department_dummy';
    matricNumber = 'matric_dummy';
    imageURL = "https://vg3ds.com/qr_php/public/uploads/dummy.jpg";
  }
}
