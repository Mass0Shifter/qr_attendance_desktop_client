import 'package:dio/dio.dart';
import 'package:qr_attendance_desktop_client/models/student_model.dart';
import 'package:qr_attendance_desktop_client/utils/config.dart';

class APIService {
  Future<List<StudentModel>> getAllStudents() async {
    List<StudentModel> students = [];
    var url = Config.url + "?student=all";
    try {
      // print(":::::::::::::::Launch Time::::::::::::::::::");
      // var response = await Dio().get(url,
      //     options: Options(
      //         headers: {HttpHeaders.contentTypeHeader: "application/json"}));
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
}
