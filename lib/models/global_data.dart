import 'package:flutter/material.dart';
import 'package:qr_attendance_desktop_client/models/attendance_model.dart';
import 'package:qr_attendance_desktop_client/models/class_model.dart';
import 'package:qr_attendance_desktop_client/models/student_model.dart';
import 'package:qr_attendance_desktop_client/utils/api_services.dart';

class GlobalDataBase extends ChangeNotifier {
  List<StudentModel> _students = [];
  List<ClassModel> _classes = [];
  List<AttendanceModel> _attendance = [];
  List<AttendanceItemModel> _attendanceRecords = [];
  bool isNotActuallyEmpty = false;
  bool needToReload = false;
  String message = "";
  bool _isApiCallProcess = false;
  bool get isApiCallProcess => _isApiCallProcess;

  setLoadingStatus(bool status) {
    _isApiCallProcess = status;
    notifyListeners();
  }

  List<StudentModel> get students => _students;

  List<ClassModel> get classes => _classes.map((e) {
        e.studentObjects = (e.studentIds.replaceAll(" ", "").split(","))
            .map((e) =>
                _students.firstWhere((element) => element.matricNumber == e))
            .toList();
        return e;
      }).toList();

  List<AttendanceModel> get attendance => _attendance.map((e) {
        e.theClassList =
            _classes.firstWhere((element) => element.id == e.classId);

        e.theAttendance = _attendanceRecords
            .where((element) => element.attendanceListId == e.id)
            .toList();

        e.theAttendance.map((s) {
          s.student = _students
              .firstWhere((element) => element.matricNumber == s.studentMatric);
          return s;
        }).toList();
        return e;
      }).toList();

  List<AttendanceItemModel> get attendanceRecords =>
      _attendanceRecords.map((e) {
        e.student = _students
            .firstWhere((element) => element.matricNumber == e.studentMatric);
        return e;
      }).toList();

  addUpAll(List<dynamic> all) {
    // add back to the list
    _students.addAll(all[0]);
    _classes.addAll(all[1]);
    _attendance.addAll(all[2]);
    _attendanceRecords.addAll(all[3]);
    isNotActuallyEmpty = true;
    notifyListeners();
  }

  Future refreshData(bool go) async {
    if (needToReload) {
      APIService apiService = APIService();
      List<dynamic> all = await apiService.getAllData();
      // Clear the list first
      _students = [];
      _classes = [];
      _attendance = [];
      _attendanceRecords = [];

      // add back to the list
      _students = all[0];
      _classes = all[1];
      _attendance = all[2];
      _attendanceRecords = all[3];
      isNotActuallyEmpty = true;
      needToReload = false;
    }
    notifyListeners();
    // if (go) {
    //   notifyListeners();
    // }
  }
}
