import 'dart:io';
import 'package:path_provider/path_provider.dart';

Future<String> getAppDirectory() async {
  final directory = await getApplicationDocumentsDirectory();
  return directory.path;
}

Future<void> writeDataToFile(String filename, List<String> data) async {
  final path = await getAppDirectory();
  final file = File('$path/$filename');
  try {
    await file.writeAsString(data.join('\n'));
  }
  catch (e) {
    print("Error in writing data to File $filename: $e");
  }
}

Future<List<String>> readDataFromFile(String filename) async {
  final path = await getAppDirectory();
  final file = File('$path/$filename');
  try {
    String contents = await file.readAsString();
    return contents.split('\n');
  }
  catch (e) {
    print("Error in reading data from file $filename: $e");
    return [];
  }
}

Future<void> processFileData(String inputFilename, String outputFilename) async {
  try {
    List<String> lines = await readDataFromFile(inputFilename);
    List<String> reversedLines = lines.map((line) => line.split('').reversed.join('')).toList();
    await writeDataToFile(outputFilename, reversedLines);
  }
  catch (e) {
    print("Error in processing file data: $e");
  }
}
