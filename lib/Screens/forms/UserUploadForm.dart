import 'package:flutter/material.dart';

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
        backgroundColor: Color(0xffF6F6F6),
        appBar: AppBar(
          elevation: 0,
          shadowColor: Colors.transparent,
          backgroundColor: Color(0xffF6F6F6),
          actions: [
            IconButton(onPressed: () {}, icon: Icon(Icons.info_outline_rounded))
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                  child: Padding(
                padding: EdgeInsets.only(left: 50, right: 50),
                child: Column(
                  children: [
                    Text(
                      "Don't be shy, supply!",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff282828)),
                    ),
                    Image.asset("assets/awe_logo.png", width: 100)
                  ],
                ),
              )),
              Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25),
                          topRight: Radius.circular(25)),
                      color: Colors.white),
                  child: Padding(
                    padding: EdgeInsets.only(left: 25, right: 25),
                    child: Column(
                      children: [
                        Center(
                          child: Column(
                            children: [
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                "We would love to see some of your art! If you think it’s related to the selected artwork, then upload it!",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 12, color: Color(0xff282828)),
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
                              cursorColor: Color(0xfff55d00),
                              style: TextStyle(fontSize: 14),
                              decoration: InputDecoration(
                                hintText: "Maker Name",
                                hintStyle: TextStyle(
                                    color: Color(0xff282828).withOpacity(0.4),
                                    fontSize: 12),
                                labelText: "Name *",
                                labelStyle: TextStyle(
                                    color: Color(0xff282828), fontSize: 14),
                                enabledBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Color(0xfff55d00))),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Color(0xfff55d00))),
                              ),
                            ),
                            TextFormField(
                              cursorColor: Color(0xfff55d00),
                              style: TextStyle(fontSize: 14),
                              decoration: InputDecoration(
                                hintText: "Artwork Name",
                                hintStyle: TextStyle(
                                    color: Color(0xff282828).withOpacity(0.4),
                                    fontSize: 12),
                                labelText: "Artwork Name",
                                labelStyle: TextStyle(
                                    color: Color(0xff282828), fontSize: 14),
                                enabledBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Color(0xfff55d00))),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Color(0xfff55d00))),
                              ),
                            ),
                            TextFormField(
                              cursorColor: Color(0xfff55d00),
                              style: TextStyle(fontSize: 14),
                              decoration: InputDecoration(
                                hintText: "Description",
                                hintStyle: TextStyle(
                                    color: Color(0xff282828).withOpacity(0.4),
                                    fontSize: 12),
                                labelText: "Artwork Description",
                                labelStyle: TextStyle(
                                    color: Color(0xff282828), fontSize: 14),
                                enabledBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Color(0xfff55d00))),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Color(0xfff55d00))),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text("Artwork Tags *"),
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
                                              : Color(0xff282828)),
                                      selectedColor: Color(0xfff55d00),
                                      backgroundColor: Colors.white,
                                      side:
                                          BorderSide(color: Color(0xfff55d00)),
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
                                    return SizedBox(
                                      width: 10,
                                    );
                                  }),
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Checkbox(
                                    tristate: false,
                                    activeColor: Color(0xfff55d00),
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
                                  child: Text(
                                      "I certify that the image I am uploading is an original work created by me. By uploading this image I am granting AWE unlimited permission to use my image both in-app and for promotional and educational purposes as they see fit. I understand that adding my work to this app does not constitute  an exhibition, display, acquisition, contract or obligation by Art Windsor-Essex."),
                                ))
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                OutlinedButton(
                                    onPressed: () {},
                                    child: Text("Upload Image")),
                                FilledButton(
                                    onPressed: () {}, child: Text("Submit")),
                              ],
                            )
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
