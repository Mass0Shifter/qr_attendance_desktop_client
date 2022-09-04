import 'package:qr_attendance_desktop_client/models/student_model.dart';

class ClassModel {
  late int id;
  late String name;
  late String courseCode;
  late String lecturer;
  late List<StudentModel> students;

  ClassModel(
      {required this.id,
      required this.name,
      required this.courseCode,
      required this.lecturer,
      required this.students});

  ClassModel.fromJson(Map<String, dynamic> json) {
    id = int.parse(json['id']);
    name = json['name'];
    courseCode = json['course_code'];
    lecturer = json['lecturer_id'];
  }
}
