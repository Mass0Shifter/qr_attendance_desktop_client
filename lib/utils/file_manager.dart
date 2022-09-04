// import 'dart:io';

// import 'package:intl/intl.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';
// import 'package:plugin_platform_interface/plugin_platform_interface.dart';

// const String kTemporaryPath = 'temporaryPath';
// const String kApplicationSupportPath = 'applicationSupportPath';
// const String kDownloadsPath = 'downloadsPath';
// const String kLibraryPath = 'libraryPath';
// const String kApplicationDocumentsPath = 'applicationDocumentsPath';
// const String kExternalCachePath = 'externalCachePath';
// const String kExternalStoragePath = 'externalStoragePath';

// class FileManager {
//   static FileManager? _instance;

//   FileManager.instance() {
//     _instance = this;
//   }

//   factory FileManager() => _instance ?? FileManager.instance();

//   Future<String> get _directoryPath async {
//     Directory? directory = await getExternalStorageDirectory();
//     return directory!.path;
//   }

//   Future<File> get _file async {
//     final path = await _directoryPath;
//     final fileName = "vg3ds.text";
//     return File('$path/$fileName');
//   }

//   Future<String> readTextFile() async {
//     String fileContent = 'VG3DS Coding';

//     File file = await _file;
//     if (await file.exists()) {
//       try {
//         fileContent = await file.readAsString();
//       } catch (e) {
//         print(e);
//       }
//     }
//     return fileContent;
//   }

//   Future<String> writeTextFile(List<String> linesToWrite) async {
//     String text = DateFormat('h:mm:ss').format(DateTime.now());

//     File file = await _file;

//     try {
//       linesToWrite.forEach((element) async {
//         await file.writeAsString(element);
//       });
//       await file.writeAsString(text);
//     } catch (e) {
//       print(e);
//     }

//     return text;
//   }
// }
