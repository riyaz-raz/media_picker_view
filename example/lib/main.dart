import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:media_picker_view/media_picker_view.dart';

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

  bool isVideoFile(String path) {
    return path.toLowerCase().endsWith(".mp4") ||
        path.toLowerCase().endsWith(".mov");
  }

  Future<void> _pickMedia(ImageSource source, {bool pickVideo = false}) async {
    final pickedFile = await (pickVideo
        ? picker.pickVideo(source: source)
        : picker.pickImage(source: source));

    if (pickedFile != null) {
      setState(() => _selectedFiles.add(pickedFile));
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text("Media Picker Example")),
        body: Column(
          children: [
            MediaPreviewList(
              files: _selectedFiles,
              isVideoFile: isVideoFile,
              onRemove: (index) => setState(() {
                _selectedFiles.removeAt(index);
              }),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () => _pickMedia(ImageSource.gallery),
                  child: const Text("Pick Image"),
                ),
                const SizedBox(width: 12),
                ElevatedButton(
                  onPressed: () =>
                      _pickMedia(ImageSource.gallery, pickVideo: true),
                  child: const Text("Pick Video"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
