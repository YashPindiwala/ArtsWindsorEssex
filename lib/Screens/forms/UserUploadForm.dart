import 'package:flutter/material.dart';
import 'package:artswindsoressex/constants.dart';
import 'package:permission_handler/permission_handler.dart';
import '../AboutApp.dart';
import 'package:image_picker/image_picker.dart';
import 'package:artswindsoressex/Screens/Models/UserUpload.dart';
import 'package:artswindsoressex/Screens/Models/ArtworkModel.dart';
import 'package:artswindsoressex/API/ApiManager.dart';
import 'package:cached_network_image/cached_network_image.dart';

class UserUploadForm extends StatefulWidget {
  static const id = "UserUploadForm";

  const UserUploadForm({super.key});

  @override
  State<UserUploadForm> createState() => _UserUploadFormState();
}

class _UserUploadFormState extends State<UserUploadForm> {
  List<bool> randomList = List.generate(6, (index) => false);
  List<String> list = [
    "Cubism",
    "Surrealism",
    "Pop Art",
    "Romanticism",
    "Impressionism",
    "Art Deco"
  ];
  bool? checked = false;
  ImagePicker imagePicker = ImagePicker();
  XFile? image;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController artwork_name = TextEditingController();
  TextEditingController artwork_desc = TextEditingController();

  @override
  void initState() {
    super.initState();
    _askForPermission();
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? args =
    ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final ArtworkModel artwork = args?['artwork'];
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
                  child:Column(
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
                                style:
                                    Theme.of(context).textTheme.headlineMedium,
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
                                          errorWidget: (context, url, error) => Image.asset("assets/awe_logo.png",)
                                      )
                                  ),
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
                              style: Theme.of(context).textTheme.headlineMedium,
                              decoration: InputDecoration(
                                hintText: "Artwork Name",
                                hintStyle: TextStyle(
                                    color: textColor.withOpacity(0.4),
                                    fontSize: size12),
                                labelText: "Artwork Name",
                                labelStyle:
                                    Theme.of(context).textTheme.headlineMedium,
                                enabledBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(color: orangeColor)),
                                focusedBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(color: orangeColor)),
                              ),
                              validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter the artwork name";
                                }
                                return null;
                              }
                            ),
                            const SizedBox(height: 20),
                            TextFormField(
                              controller: artwork_desc,
                              textInputAction: TextInputAction.done,
                              cursorColor: orangeColor,
                              style: Theme.of(context).textTheme.headlineMedium,
                              decoration: InputDecoration(
                                hintText: "Description",
                                hintStyle: TextStyle(
                                    color: textColor.withOpacity(0.4),
                                    fontSize: size12),
                                labelText: "Artwork Description",
                                labelStyle:
                                    Theme.of(context).textTheme.headlineMedium,
                                enabledBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(color: orangeColor)),
                                focusedBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(color: orangeColor)),
                              ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Please enter the description name";
                                  }
                                  return null;
                                }
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            const Text("Artwork Tags *"),
                            Container(
                              height: 70,
                              child: ListView.separated(
                                  itemCount: list.length,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    return FilterChip(
                                      label: Text(
                                        list[index],
                                      ),
                                      labelStyle: TextStyle(
                                          color: randomList[index]
                                              ? Colors.white
                                              : textColor),
                                      selectedColor: orangeColor,
                                      backgroundColor: Colors.white,
                                      side:
                                          const BorderSide(color: orangeColor),
                                      onSelected: (value) {
                                        setState(() {
                                          randomList[index] =
                                              !randomList[index];
                                        });
                                      },
                                      selected: randomList[index],
                                    );
                                  },
                                  separatorBuilder: (context, index) {
                                    return const SizedBox(
                                      width: 10,
                                    );
                                  }),
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
                                        if (_formKey.currentState!.validate()) {
                                          checked = value;
                                        }
                                      });
                                    }),
                                Flexible(
                                    child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      if (_formKey.currentState!.validate()){
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
                                OutlinedButton(
                                    onPressed: image == null ? () {
                                      _pickImageFromGallery();
                                    }: null,
                                    style: OutlinedButton.styleFrom(
                                        side: const BorderSide(
                                            color: orangeColor)),
                                    child: const Text("Upload Image")),
                                const Spacer(),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: FilledButton(
                                    onPressed: checked == true
                                        ? () async {
                                            // onPressed callback
                                            if(image == null){
                                              showDialog(
                                                  context: context,
                                                  builder: (context) => _noImageDialog(),
                                              );
                                            }
                                            if(image!=null){
                                                UserUpload userUpload = UserUpload(
                                                  artworkId: artwork.artwork_id!, // Replace with your artworkId
                                                  title: artwork_name.text, // Replace with your title
                                                  description: artwork_desc.text, // Replace with your description
                                                  filePath: image!.path,
                                                );
                                                bool res = await ApiManager.uploadImage(userUpload);
                                                if(res){
                                                  ScaffoldMessenger.of(context).showSnackBar(
                                                    SnackBar(content: Text("${userUpload.title} uploaded"))
                                                  );
                                                  Navigator.pop(context);
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

  _pickImageFromGallery() async {
    image = await imagePicker.pickImage(source: ImageSource.gallery);
    setState(() {});
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
