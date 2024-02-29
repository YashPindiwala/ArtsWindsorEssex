import 'package:flutter/material.dart';
import 'package:artswindsoressex/constants.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          elevation: 0,
          shadowColor: Colors.transparent,
          backgroundColor: backgroundColor,
          actions: [
            IconButton(
                onPressed: () {}, icon: const Icon(Icons.info_outline_rounded))
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
                    Image.asset("assets/awe_logo.png", width: 100)
                  ],
                ),
              )),
              Container(
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25),
                          topRight: Radius.circular(25)),
                      color: Colors.white),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 25, right: 25),
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
                                style:
                                    Theme.of(context).textTheme.headlineMedium,
                              ),
                              Image.asset("assets/awe_logo.png", width: 100)
                            ],
                          ),
                        ),
                        Form(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextFormField(
                              cursorColor: orangeColor,
                              style: Theme.of(context).textTheme.headlineMedium,
                              decoration: InputDecoration(
                                hintText: "Maker Name",
                                hintStyle: TextStyle(
                                    color: textColor.withOpacity(0.4),
                                    fontSize: size12),
                                labelText: "Name *",
                                labelStyle:
                                    Theme.of(context).textTheme.headlineMedium,
                                enabledBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(color: orangeColor)),
                                focusedBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(color: orangeColor)),
                              ),
                            ),
                            TextFormField(
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
                            ),
                            TextFormField(
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
                            ),
                            const SizedBox(
                              height: 20,
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
                                        checked = value;
                                      });
                                    }),
                                Flexible(
                                    child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      if (checked!) {
                                        checked = false;
                                      } else {
                                        checked = true;
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
                                    onPressed: () {},
                                    style: OutlinedButton.styleFrom(
                                        side: const BorderSide(
                                            color: orangeColor)),
                                    child: const Text("Upload Image")),
                                const Spacer(),
                                FilledButton(
                                    onPressed: () {},
                                    child: const Text("Submit")),
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
                    ),
                  )),
            ],
          ),
        ));
  }
}
