import 'package:qr_attendance_desktop_client/models/class_model.dart';
import 'package:qr_attendance_desktop_client/models/student_model.dart';

class AttendanceModel {
  late int id;
  late int count;
  late int classId;
  late ClassModel theClassList;
  late List<AttendanceItemModel> theAttendance;
  late DateTime date;

  AttendanceModel({
    required this.id,
    required this.count,
    required this.theClassList,
    required this.theAttendance,
  });

  AttendanceModel.fromJson(Map<String, dynamic> json) {
    id = int.parse(json['id']);
    count = int.parse(json['class_count']);
    classId = int.parse(json['class_id']);
    // theClassList = ClassModel.fromJson(json['class']);
    // theAttendance = json['attendances'] == false
    //     ? [AttendanceItemModel.fromDummy()]
    //     : (json['attendances'] as List)
    //         .map((i) => AttendanceItemModel.fromJson(i))
    //         .toList();
    date = DateTime.parse(json['date']);
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      "class_id": theClassList.id,
      "class_count": count,
    };
  }

  AttendanceModel.fromDummy() {
    id = 1;
    count = 0;
    theClassList = ClassModel.fromDummy();
    theAttendance = [
      AttendanceItemModel.fromDummy(),
      AttendanceItemModel.fromDummy()
    ];
    date = DateTime.now();
  }

  // getAttRecords(){
  //   this.theAttendance = json['attendances'] == false
  //       ? [AttendanceItemModel.fromDummy()]
  //       : (json['attendances'] as List)
  //           .map((i) => AttendanceItemModel.fromJson(i))
  //           .toList();
  // }
}

class AttendanceItemModel {
  late int id;
  late int attendanceListId;
  late int studentId;
  late String studentMatric;
  late StudentModel student;
  late DateTime timeRecord;

  AttendanceItemModel(
      {required this.id,
      required this.attendanceListId,
      required this.studentId,
      required this.studentMatric,
      required this.timeRecord});

  AttendanceItemModel.fromJson(Map<String, dynamic> json) {
    id = int.parse(json['id']);
    attendanceListId = int.parse(json['attendance_list_id']);
    studentId = int.parse(json['student_id']);
    studentMatric = json['student_matric'];
    // student = StudentModel.fromJson(json['student']);
    // studentId = student.id;
    // studentMatric = student.matricNumber;
    timeRecord = DateTime.parse(json['time_record']);
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      "attendance_list_id": attendanceListId,
      "student_id": studentId,
      "student_matric": studentMatric,
      "time_record": timeRecord.toString()
    };
    // "time_record" : "1997-10-14 12:00:00"
  }

  AttendanceItemModel.fromDummy() {
    id = 0;
    attendanceListId = 0;
    studentId = 0;
    studentMatric = "matric_dummy";
    student = StudentModel.fromDummy();
    timeRecord = DateTime.now();
  }
}
