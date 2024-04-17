import 'package:flutter/material.dart';
import 'dart:ui'; // Importing dart:ui for ImageFilter
import 'package:artswindsoressex/constants.dart'; // Importing custom constants
import 'package:dotted_border/dotted_border.dart'; // Importing dotted_border package
import 'package:image_picker/image_picker.dart'; // Importing image_picker package
import 'dart:io'; // Importing dart:io for File
import 'package:path/path.dart' as path; // Importing path as path for basename
import 'package:provider/provider.dart'; // Importing provider package
import 'package:artswindsoressex/ChangeNotifiers/UploadImageProvider.dart'; // Importing UploadImageProvider

class PickImageDialog extends StatefulWidget {
  const PickImageDialog({Key? key, required this.imagePicker})
      : super(key: key);

  final ImagePicker imagePicker;

  @override
  State<PickImageDialog> createState() => _PickImageDialogState();
}

class _PickImageDialogState extends State<PickImageDialog> {
  XFile? image; // Variable to hold the picked image file

  @override
  Widget build(BuildContext context) {
    return Consumer<UploadImageProvider>(
      // Consumer widget to listen for changes in UploadImageProvider
      builder: (context, uploadImageProvider, child) {
        return Dialog(
          backgroundColor:
              Colors.transparent, // Setting background color of the dialog
          child: BackdropFilter(
            filter: ImageFilter.blur(
                sigmaX: 5.0,
                sigmaY: 5.0), // Applying blur effect to the backdrop
            child: Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 50, vertical: 25), // Setting padding
              decoration: BoxDecoration(
                color:
                    Colors.white, // Setting background color of the container
                borderRadius: BorderRadius.circular(
                    20), // Applying border radius to the container
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min, // Setting main axis size
                children: [
                  Text(
                    "Upload your art here!", // Displaying upload text
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                        fontSize: 20,
                        fontWeight: FontWeight.w500), // Applying text style
                  ),
                  const SizedBox(height: 20), // Adding SizedBox for spacing
                  InkWell(
                    onTap:
                        _pickImageFromGallery, // Handling tap on InkWell to pick image from gallery
                    child: DottedBorder(
                      dashPattern: [
                        3,
                        3
                      ], // Setting dash pattern for the border
                      color: orangeColor, // Setting border color
                      radius:
                          const Radius.circular(20), // Setting border radius
                      borderType: BorderType
                          .RRect, // Setting border type to rounded rectangle
                      strokeCap: StrokeCap.round, // Setting stroke cap
                      strokeWidth: 1.0, // Setting stroke width
                      child: Container(
                        height: 150, // Setting container height
                        width: double
                            .infinity, // Setting container width to occupy full width
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                              20), // Applying border radius
                        ),
                        child: uploadImageProvider.image != null &&
                                uploadImageProvider.image!.path
                                    .isNotEmpty // Checking if an image is already selected
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(
                                    20), // Applying border radius to the clipped image
                                child: Image.file(
                                  File(uploadImageProvider.image!
                                      .path), // Displaying the selected image
                                  fit: BoxFit.fill, // Setting BoxFit to fill
                                ),
                              )
                            : Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Upload Image", // Displaying upload image text
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineMedium!
                                          .copyWith(
                                              fontSize:
                                                  16.0), // Applying text style
                                    ),
                                    const SizedBox(
                                        height:
                                            10), // Adding SizedBox for spacing
                                    Icon(
                                      Icons
                                          .image_outlined, // Displaying image icon
                                      color: orangeColor, // Setting icon color
                                      size: 34, // Setting icon size
                                    ),
                                  ],
                                ),
                              ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20), // Adding SizedBox for spacing
                  uploadImageProvider.image != null &&
                          uploadImageProvider.image!.path
                              .isNotEmpty // Checking if an image is already selected
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment
                              .spaceBetween, // Setting mainAxisAlignment
                          children: [
                            Expanded(
                              child: Text(
                                uploadImageProvider.image != null &&
                                        uploadImageProvider.image!.path
                                            .isNotEmpty // Checking if an image is already selected
                                    ? path.basename(uploadImageProvider.image!
                                        .path) // Displaying the image name
                                    : "No image selected", // Displaying message if no image is selected
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineMedium, // Applying text style
                                softWrap: true, // Allowing text to wrap
                              ),
                            ),
                            IconButton(
                              padding:
                                  EdgeInsets.zero, // Setting padding to zero
                              icon: Icon(
                                Icons.cancel, // Displaying cancel icon
                                color: orangeColor, // Setting icon color
                              ),
                              onPressed: () {
                                uploadImageProvider
                                    .clearImage(); // Clearing the selected image
                              },
                            ),
                          ],
                        )
                      : Container(), // Displaying empty container if no image is selected
                  FilledButton(
                    onPressed: () {
                      Navigator.pop(
                          context); // Closing the dialog on button press
                    },
                    child:
                        Text("Upload"), // Displaying Upload text on the button
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
    final XFile? pickedImage = await widget.imagePicker
        .pickImage(source: ImageSource.gallery); // Picking image from gallery
    if (pickedImage != null) {
      context
          .read<UploadImageProvider>()
          .setImage(pickedImage); // Setting the picked image
    }
  }
}
