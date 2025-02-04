import 'package:flutter/material.dart';
import 'package:artswindsoressex/constants.dart';
import 'package:permission_handler/permission_handler.dart';
import '../AboutApp.dart';
import 'package:image_picker/image_picker.dart';
import 'package:artswindsoressex/Screens/Models/UserUpload.dart';
import 'package:artswindsoressex/Screens/Models/ArtworkModel.dart';
import 'package:artswindsoressex/API/ApiManager.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:artswindsoressex/Utils/PickImageDialog.dart';
import 'package:provider/provider.dart';
import 'package:artswindsoressex/ChangeNotifiers/UploadImageProvider.dart';
import 'package:artswindsoressex/ChangeNotifiers/TagProvider.dart';
import 'package:artswindsoressex/Utils/ListViewShimmerHZ.dart';
import 'package:artswindsoressex/Screens/UploadSubmitted.dart';

class UserUploadForm extends StatefulWidget {
  static const id = "UserUploadForm";

  const UserUploadForm({super.key});

  @override
  State<UserUploadForm> createState() => _UserUploadFormState();
}

class _UserUploadFormState extends State<UserUploadForm> {
  bool? checked = false;
  ImagePicker imagePicker = ImagePicker();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController artwork_name = TextEditingController();
  TextEditingController artwork_desc = TextEditingController();

  @override
  void initState() {
    super.initState();
    _askForPermission();
    Provider.of<UploadImageProvider>(context, listen: false).clearImage();
    Provider.of<TagProvider>(context, listen: false).clearSelectedTags();
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final ArtworkModel artwork = args?['artwork'];
    Provider.of<TagProvider>(context, listen: false).selectMultipleTag(artwork.tags);
    print("tags selected -________----- " + Provider.of<TagProvider>(context, listen: false).selectedTags.toString());
    return Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          elevation: 0,
          shadowColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          backgroundColor: backgroundColor,
          actions: [
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, AboutApp.id);
              },
              icon: const Icon(Icons.info_outline_rounded),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                  child: Padding(
                padding: const EdgeInsets.only(left: 50, right: 50),
                child: Column(
                  children: [
                    const Text(
                      "Don't be shy, supply!",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: size24,
                          fontWeight: FontWeight.bold,
                          color: textColor),
                    ),
                    Image.asset("assets/awe_logo.png", width: 60)
                  ],
                ),
              )),
              Container(
                  padding: const EdgeInsets.only(left: 25, right: 25),
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25),
                          topRight: Radius.circular(25)),
                      color: Colors.white),
                  child: Column(
                    children: [
                      Center(
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              "We would love to see some of your art! If you think it’s related to the selected artwork, then upload it!",
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.headlineMedium,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: CachedNetworkImage(
                                    width: 75,
                                    height: 75,
                                    imageUrl: artwork.image,
                                    fit: BoxFit.fill,
                                    errorWidget: (context, url, error) =>
                                        Image.asset(
                                          "assets/awe_logo.png",
                                        ))),
                          ],
                        ),
                      ),
                      Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 20),
                              TextFormField(
                                  controller: artwork_name,
                                  textInputAction: TextInputAction.next,
                                  cursorColor: orangeColor,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium,
                                  decoration: InputDecoration(
                                    hintText: "Artwork Name",
                                    hintStyle: TextStyle(
                                        color: textColor.withOpacity(0.4),
                                        fontSize: size12),
                                    labelText: "Artwork Name",
                                    labelStyle: Theme.of(context)
                                        .textTheme
                                        .headlineMedium,
                                    enabledBorder: const UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: orangeColor)),
                                    focusedBorder: const UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: orangeColor)),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Please enter the artwork name";
                                    }
                                    return null;
                                  }),
                              const SizedBox(height: 20),
                              TextFormField(
                                  controller: artwork_desc,
                                  textInputAction: TextInputAction.done,
                                  cursorColor: orangeColor,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium,
                                  decoration: InputDecoration(
                                    hintText: "Description",
                                    hintStyle: TextStyle(
                                        color: textColor.withOpacity(0.4),
                                        fontSize: size12),
                                    labelText: "Artwork Description",
                                    labelStyle: Theme.of(context)
                                        .textTheme
                                        .headlineMedium,
                                    enabledBorder: const UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: orangeColor)),
                                    focusedBorder: const UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: orangeColor)),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Please enter the description name";
                                    }
                                    return null;
                                  }),
                              const SizedBox(
                                height: 40,
                              ),
                              const Text("Artwork Tags *"),
                              Container(
                                height: 70,
                                child: Consumer<TagProvider>(
                                  builder: (context, tags, child) {
                                    if (!tags.loaded) {
                                      return ListViewShimmerHZ();
                                    } else {
                                      return ListView.separated(
                                        itemCount: tags.tags.length,
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, index) {
                                          return FilterChip(
                                            label: Text(
                                              tags.tags[index].tag,
                                            ),
                                            labelStyle: TextStyle(
                                              color: tags.selectedTagsBool[index] ? Colors.white : textColor,
                                            ),
                                            selectedColor: orangeColor,
                                            backgroundColor: Colors.white,
                                            side: const BorderSide(color: orangeColor),
                                            selected: tags.selectedTagsBool[index],
                                            onSelected: (value) {
                                              tags.updateTagsList(index, value);
                                            },
                                          );
                                        },
                                        separatorBuilder: (context, index) {
                                          return const SizedBox(width: 10);
                                        },
                                      );
                                    }
                                  },
                                ),
                              ),
                              const SizedBox(
                                height: 40,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Checkbox(
                                      tristate: false,
                                      value: checked,
                                      onChanged: (value) {
                                        setState(() {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            checked = value;
                                          }
                                        });
                                      }),
                                  Flexible(
                                      child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        if (_formKey.currentState!.validate()) {
                                          if (checked!) {
                                            checked = false;
                                          } else {
                                            checked = true;
                                          }
                                        }
                                      });
                                    },
                                    child: const Text(
                                        "I certify that the image I am uploading is an original work created by me. By uploading this image I am granting AWE unlimited permission to use my image both in-app and for promotional and educational purposes as they see fit. I understand that adding my work to this app does not constitute  an exhibition, display, acquisition, contract or obligation by Art Windsor-Essex."),
                                  ))
                                ],
                              ),
                              const SizedBox(
                                height: 25,
                              ),
                              Row(
                                children: [
                                  const Spacer(),
                                  const Spacer(),
                                  Consumer<UploadImageProvider>(
                                    builder: (context, value, child) {
                                      return OutlinedButton(
                                        onPressed: () {
                                          // _pickImageFromGallery();
                                          showDialog(
                                            context: context,
                                            builder: (context) =>
                                                PickImageDialog(
                                              imagePicker: imagePicker,
                                            ),
                                          );
                                        },
                                        style: OutlinedButton.styleFrom(
                                            side: const BorderSide(
                                                color: orangeColor)),
                                        child: value.image == null
                                            ? Text("Upload Image")
                                            : Text("Change Image"),
                                      );
                                    },
                                  ),
                                  const Spacer(),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: FilledButton(
                                      onPressed: checked == true
                                          ? () async {
                                              // onPressed callback
                                              if (Provider.of<UploadImageProvider>(
                                                          context,
                                                          listen: false)
                                                      .image ==
                                                  null) {
                                                showDialog(
                                                  context: context,
                                                  builder: (context) =>
                                                      _noImageDialog(),
                                                );
                                              }
                                              if (Provider.of<UploadImageProvider>(
                                                          context,
                                                          listen: false)
                                                      .image !=
                                                  null) {
                                                UserUpload userUpload =
                                                    UserUpload(
                                                      artworkId: artwork.artwork_id!,
                                                      title: artwork_name.text,
                                                      description: artwork_desc.text,
                                                      filePath: Provider.of<UploadImageProvider>(context, listen: false).image!.path,
                                                      tags: Provider.of<TagProvider>(context, listen: false).selectedTags,
                                                    );
                                                bool res = await ApiManager
                                                    .uploadImage(context,userUpload);
                                                if (res) {
                                                  Navigator.popAndPushNamed(context, UploadSubmitted.id);
                                                }
                                              }
                                            }
                                          : null,
                                      style: ButtonStyle(
                                        backgroundColor: MaterialStateProperty
                                            .resolveWith<Color>(
                                          (Set<MaterialState> states) {
                                            if (states.contains(
                                                MaterialState.disabled)) {
                                              return Colors
                                                  .grey; // Color when disabled
                                            }
                                            return orangeColor; // Default color
                                          },
                                        ),
                                      ),
                                      child: const Text("Submit"),
                                    ),
                                  ),
                                  const Spacer(),
                                  const Spacer(),
                                ],
                              ),
                              const SizedBox(
                                height: 25,
                              ),
                            ],
                          )),
                    ],
                  )),
            ],
          ),
        ));
  }

  Future<void> _pickImageFromGallery() async {
    final XFile? pickedImage =
        await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      Provider.of<UploadImageProvider>(context, listen: false)
          .setImage(pickedImage);
    }
  }

  _askForPermission() async {
    PermissionStatus status = await Permission.photos.request();
    switch (status) {
      case PermissionStatus.denied:
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Permission Denied'),
              content: Text('Please enable photos permission in app settings.'),
              actions: <Widget>[
                TextButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
        break;
      case PermissionStatus.permanentlyDenied:
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Permission Denied'),
              content: Text('Please enable photos permission in app settings.'),
              actions: <Widget>[
                TextButton(
                  child: Text('Open Settings'),
                  onPressed: () {
                    openAppSettings();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
        break;
      case PermissionStatus.restricted:
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Permission Restricted'),
              content: Text('Photos permission is restricted.'),
              actions: <Widget>[
                TextButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
        break;
      default:
        break;
    }
  }

  Widget _noImageDialog() {
    return AlertDialog(
      title: Text('No Image Selected'),
      content: Text('Please select an image to upload.'),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            _pickImageFromGallery();
            Navigator.of(context).pop(); // Close the dialog
          },
          child: Text('Pick Image'),
        ),
      ],
    );
  }
}
