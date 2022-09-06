import 'package:qr_attendance_desktop_client/models/student_model.dart';

class ClassModel {
  late int id;
  late String name;
  late String courseCode;
  late String lecturer;
  late String studentIds;
  late List<StudentModel> studentObjects;

  ClassModel(
      {required this.id,
      required this.name,
      required this.courseCode,
      required this.lecturer,
      required this.studentIds});

  ClassModel.fromJson(Map<String, dynamic> json) {
    id = int.parse(json['id']);
    name = json['name'];
    courseCode = json['course_code'];
    studentIds = json['student_ids'];
    lecturer = json['lecturer_id'];
    studentObjects = (json['students'] as List)
        .map((i) => StudentModel.fromJson(i))
        .toList();
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      "name": name,
      "course_code": courseCode,
      "student_ids": studentIds,
      "lecturer_id": lecturer
    };
  }

  ClassModel.fromDummy() {
    id = 0;
    name = 'name_dummy';
    courseCode = 'course_code';
    studentIds = 'student_ids';
    lecturer = 'lecturer_id';
    studentObjects = [StudentModel.fromDummy(), StudentModel.fromDummy()];
  }
}
