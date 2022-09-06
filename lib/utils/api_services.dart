import 'dart:io';

import 'package:dio/dio.dart';
import 'package:qr_attendance_desktop_client/models/attendance_model.dart';
import 'package:qr_attendance_desktop_client/models/class_model.dart';
import 'package:qr_attendance_desktop_client/models/student_model.dart';
import 'package:qr_attendance_desktop_client/utils/config.dart';

class APIService {
  Future<List<StudentModel>> getAllStudents() async {
    List<StudentModel> students = [];
    var url = Config.url + "?student=all";
    try {
      var response = await Dio().get(url);

      if (response.statusCode == 200) {
        // print(url);
        students = (response.data as List)
            .map((i) => StudentModel.fromJson(i))
            .toList();
      }
    } on DioError catch (e) {
      // ignore: avoid_print
      print(e.message);
    }

    return students;
  }

  Future<StudentModel?> getStudentById(int studentId) async {
    StudentModel? student;
    var url = Config.url + "?student=id&id=" + studentId.toString();
    try {
      var response = await Dio().get(url);

      if (response.statusCode == 200) {
        // print(url);
        student = StudentModel.fromJson(response.data);
      }
    } on DioError catch (e) {
      // ignore: avoid_print
      print(e.message);
    }

    return student;
  }

  Future<StudentModel?> getStudentByMatric(String studentMatNum) async {
    StudentModel? student;
    var url = Config.url +
        "?student=matric_number&matric_number=" +
        studentMatNum.toString();
    try {
      var response = await Dio().get(url);

      if (response.statusCode == 200) {
        // print(url);
        student = StudentModel.fromJson(response.data);
      }
    } on DioError catch (e) {
      // ignore: avoid_print
      print(e.message);
    }

    return student;
  }

  Future<StudentModel?> getStudentByMatricForAttendance(
      String studentMatNum, int attendanceId) async {
    StudentModel? student;
    var url = Config.url +
        "?student=matric_number_and_attendance&matric_number=$studentMatNum&attendance_id=$attendanceId";
    try {
      var response = await Dio().get(url);

      if (response.statusCode == 200) {
        // print(url);
        student = StudentModel.fromJson(response.data);
      }
    } on DioError catch (e) {
      // ignore: avoid_print
      print(e.message);
    }

    return student;
  }

  Future<bool> getStudentByMatricForAttendanceConfirm(
      String studentMatNum, int attendanceId) async {
    bool student = false;
    var url = Config.url +
        "?student=matric_number_and_attendance_match&matric_number=$studentMatNum&attendance_id=$attendanceId";
    try {
      var response = await Dio().get(url);

      if (response.statusCode == 200) {
        // print(url);
        // student = StudentModel.fromJson(response.data);
        student = response.data;
      }
    } on DioError catch (e) {
      // ignore: avoid_print
      print(e.message);
    }

    return student;
  }

  Future<List<ClassModel>> getAllClasses() async {
    List<ClassModel> classes = [];
    int lecturerId = 1;
    var url = Config.url + "?class_list=all&lecturer_id=$lecturerId";
    try {
      var response = await Dio().get(url);

      if (response.statusCode == 200) {
        // print(url);
        classes =
            (response.data as List).map((i) => ClassModel.fromJson(i)).toList();
      }
    } on DioError catch (e) {
      // ignore: avoid_print
      print(e.message);
    }

    return classes;
  }

  Future<ClassModel?> getClassById(int classId) async {
    ClassModel? student;
    int lecturerId = 1;
    var url = Config.url + "?class_list=id&id=$classId&lecturer_id=$lecturerId";
    try {
      var response = await Dio().get(url);

      if (response.statusCode == 200) {
        // print(url);
        student = ClassModel.fromJson(response.data);
      }
    } on DioError catch (e) {
      // ignore: avoid_print
      print(e.message);
    }

    return student;
  }

  Future<List<AttendanceModel>> getAllAttendanceByClass(int id) async {
    List<AttendanceModel> classes = [];
    var url = Config.url + "?attendance=all_class_id&id=$id";
    try {
      var response = await Dio().get(url);

      if (response.statusCode == 200) {
        if (response.data == false) {
          classes = [AttendanceModel.fromDummy()];
        } else {
          classes = (response.data as List)
              .map((i) => AttendanceModel.fromJson(i))
              .toList();
        }
      }
    } on DioError catch (e) {
      // ignore: avoid_print
      print(e.message);
    }

    return classes;
  }

  Future<AttendanceModel> getAttendanceByID(int id) async {
    late AttendanceModel classes;
    var url = Config.url + "?attendance=id&id=$id";
    try {
      var response = await Dio().get(url);

      if (response.statusCode == 200) {
        // print(url);
        classes = AttendanceModel.fromJson(response.data);
      }
    } on DioError catch (e) {
      // ignore: avoid_print
      print(e.message);
    }

    return classes;
  }

  Future<bool> createStudent(StudentModel student, File image) async {
    bool success = false;
    var url = Config.url;
    try {
      String fileName = image.path.split('/').last;
      FormData formData = FormData.fromMap({
        "student_img":
            await MultipartFile.fromFile(image.path, filename: fileName),
        "request": Config.createStudent,
        "student_data": student.toJson()
      });

      var response = await Dio().post(url, data: formData);

      if (response.statusCode == 200) {
        // print(response.data);
        success = true;
      }
    } on DioError catch (e) {
      // ignore: avoid_print
      print(e.message);
    }

    return success;
  }

  Future<bool> createClass(ClassModel class_) async {
    bool success = false;
    var url = Config.url;
    try {
      FormData formData = FormData.fromMap(
          {"request": Config.createClass, "class_data": class_.toJson()});

      var response = await Dio().post(url, data: formData);

      if (response.statusCode == 200) {
        // print(response.data);
        success = true;
      }
    } on DioError catch (e) {
      // ignore: avoid_print
      print(e.message);
    }

    return success;
  }

  Future<bool> createAttendance(AttendanceModel attendanceModel) async {
    bool success = false;
    var url = Config.url;
    try {
      FormData formData = FormData.fromMap({
        "request": Config.createAttendance,
        "attendance_data": attendanceModel.toJson()
      });

      var response = await Dio().post(url, data: formData);

      if (response.statusCode == 200) {
        if (response.data['response'] == "ATTENDANCE ADDED TO DATABASE") {
          success = true;
        }
      }
    } on DioError catch (e) {
      // ignore: avoid_print
      print(e.message);
    }

    return success;
  }

  Future<bool> createAttendanceItem(
      AttendanceItemModel attendanceItemModel) async {
    bool success = false;
    var url = Config.url;
    try {
      FormData formData = FormData.fromMap({
        "request": Config.createAttendances,
        "attendances_data": [attendanceItemModel.toJson()]
      });

      var response = await Dio().post(url, data: formData);
      // print(response.data);
      if (response.statusCode == 200) {
        if (response.data['response'] == "ATTENDANCES ADDED TO DATABASE") {
          success = true;
        }
      }
    } on DioError catch (e) {
      // ignore: avoid_print
      print(e.message);
    }

    return success;
  }
}
