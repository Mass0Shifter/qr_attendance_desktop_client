import 'package:qr_attendance_desktop_client/models/class_model.dart';
import 'package:qr_attendance_desktop_client/models/student_model.dart';

class AttendanceModel {
  late int id;
  late String name;
  late ClassModel theClassList;
  late List<StudentModel> theAttendance;

  AttendanceModel({
    required this.id,
    required this.name,
    required this.theClassList,
    required this.theAttendance,
  });

  AttendanceModel.fromJson(Map<String, dynamic> json) {
    id = int.parse(json['id']);
    name = json['name'];
    theClassList = json['class_id'];
    theAttendance = json['lecturer_id'];
  }
}

class AttendanceItemModel {
  late int id;
  late int attendanceListId;
  late String studentId;
  late DateTime timeRecord;

  AttendanceItemModel(
      {required this.id,
      required this.attendanceListId,
      required this.studentId,
      required this.timeRecord});

  AttendanceItemModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    attendanceListId = json['attendance_list_id'];
    studentId = json['student_id'];
    timeRecord = DateTime(json['time_record']);
  }
}
