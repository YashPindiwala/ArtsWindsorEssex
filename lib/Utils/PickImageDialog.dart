import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:artswindsoressex/constants.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:provider/provider.dart';
import 'package:artswindsoressex/ChangeNotifiers/UploadImageProvider.dart';

class PickImageDialog extends StatefulWidget {
  const PickImageDialog({Key? key, required this.imagePicker})
      : super(key: key);

  final ImagePicker imagePicker;

  @override
  State<PickImageDialog> createState() => _PickImageDialogState();
}

class _PickImageDialogState extends State<PickImageDialog> {
  XFile? image;

  @override
  Widget build(BuildContext context) {
    return Consumer<UploadImageProvider>(
      builder: (context, uploadImageProvider, child) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 25),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Upload your art here!",
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium!
                        .copyWith(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 20),
                  InkWell(
                    onTap: _pickImageFromGallery,
                    child: DottedBorder(
                      dashPattern: [3, 3],
                      color: orangeColor,
                      radius: const Radius.circular(20),
                      borderType: BorderType.RRect,
                      strokeCap: StrokeCap.round,
                      strokeWidth: 1.0,
                      child: Container(
                        height: 150,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: uploadImageProvider.image != null &&
                                uploadImageProvider.image!.path.isNotEmpty
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.file(
                                  File(uploadImageProvider.image!.path),
                                  fit: BoxFit.fill,
                                ),
                              )
                            : Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Upload Image",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineMedium!
                                          .copyWith(fontSize: 16.0),
                                    ),
                                    const SizedBox(height: 10),
                                    Icon(
                                      Icons.image_outlined,
                                      color: orangeColor,
                                      size: 34,
                                    ),
                                  ],
                                ),
                              ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  uploadImageProvider.image != null &&
                          uploadImageProvider.image!.path.isNotEmpty
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                uploadImageProvider.image != null &&
                                    uploadImageProvider.image!.path.isNotEmpty
                                    ? path.basename(uploadImageProvider.image!.path)
                                    : "No image selected",
                                style: Theme.of(context).textTheme.headlineMedium,
                                softWrap: true,
                              ),
                            ),
                            IconButton(
                              padding: EdgeInsets.zero,
                              icon: Icon(
                                Icons.cancel,
                                color: orangeColor,
                              ),
                              onPressed: () {
                                uploadImageProvider.clearImage();
                              },
                            ),
                          ],
                        )
                      : Container(),
                  FilledButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("Upload"),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> _pickImageFromGallery() async {
    final XFile? pickedImage =
        await widget.imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      context.read<UploadImageProvider>().setImage(pickedImage);
    }
  }
}
