import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void mediaPickerDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: const Text(
          'Select media source',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),

        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.photo_library_rounded),
              title: const Text('Gallery'),
              onTap: () async {
                Navigator.pop(context);
                await openImages(ImageSource.gallery);
              },
            ),

            ListTile(
              leading: const Icon(Icons.camera_alt_rounded),
              title: const Text('Camera'),
              onTap: () async {
                Navigator.pop(context);
                await openImages(ImageSource.camera);
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Cancel',
              style: TextStyle(color: Colors.black54),
            ),
          ),
        ],
      );
    },
  );
}

Future<void> openImages(ImageSource source) async {
  final picker = ImagePicker();
  final XFile? image = await picker.pickImage(source: source);
  if (image != null) {
    // handle image here (save, upload, or pass to callback)
  }
}
