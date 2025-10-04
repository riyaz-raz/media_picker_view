import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:media_picker_view/media_picker_view.dart';
import 'package:media_picker_view/util/media_type_checker.dart';

void main() {
  runApp(ExampleApp());
}

class ExampleApp extends StatefulWidget {
  const ExampleApp({super.key});

  @override
  State<ExampleApp> createState() => _ExampleAppState();
}

class _ExampleAppState extends State<ExampleApp> {
  final picker = ImagePicker();
  final List<XFile> _selectedFiles = [];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text("Media Picker Example")),
        body: MediaPreviewList(
          files: _selectedFiles,

          onRemove: (index) => setState(() {
            _selectedFiles.removeAt(index);
          }),
          onSelect: (file) {
            if (file != null) {
              _selectedFiles.add(file);
            }
          },
        ),
      ),
    );
  }
}
