import 'package:flutter/material.dart';
import 'file_operations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await runFileOperationsTests();
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('File Operations Test'),
        ),
        body: const Center(
          child: Text('Check console output for test results.'),
        ),
      ),
    );
  }
}

Future<void> runFileOperationsTests() async {
  const  inputFilename = 'test_input.txt';
  const outputFilename = 'test_output.txt';
  List<String> data = ["Apple","Banana","Orange","Mango","Peach"];

  await writeDataToFile(inputFilename, data);

  List<String> readData = await readDataFromFile(inputFilename);
  assert(readData.length == data.length, "Failed in process of reading data");

  await processFileData(inputFilename, outputFilename);
  List<String> processedData = await readDataFromFile(outputFilename);
  List<String> expectedData = data.map((line) => line.split('').reversed.join('')).toList();
  assert(processedData.length == expectedData.length, "Failed in processing data from file");
  for (int i = 0; i < expectedData.length; i++) {
    assert(processedData[i] == expectedData[i], "Line ${i + 1} mismatch: expected ${expectedData[i]}, got ${processedData[i]}");
  }

  print(readData);
  print(processedData);
  print("All tests passed.");
}