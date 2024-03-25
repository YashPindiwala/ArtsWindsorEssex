import 'package:artswindsoressex/Screens/forms/UserUploadForm.dart';
import 'package:artswindsoressex/constants.dart';
import 'package:flutter/material.dart';
import 'package:artswindsoressex/Screens/Models/CommentModel.dart';
import 'package:artswindsoressex/API/CommentRequest.dart';

import '../AboutApp.dart';

class CommentForm extends StatefulWidget {
  static const id = "CommentForm";

  const CommentForm({super.key});

  @override
  State<CommentForm> createState() => _CommentFormState();
}

class _CommentFormState extends State<CommentForm> {
  bool? checked = false;
  TextEditingController commentController = TextEditingController();

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
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const AboutApp()),
              );
            },
            icon: const Icon(Icons.info_outline_rounded),
          )
        ],
      ),
      body:Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Comments",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: size24,
                  fontWeight: FontWeight.bold,
                  color: textColor),
            ),
            Image.asset("assets/awe_logo.png", width: 60),
            Expanded(
                child: Container(
                  padding: EdgeInsets.all(25),
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25),
                          topRight: Radius.circular(25)),
                      color: Colors.white),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Center(
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 20,
                              ),
                              const Text(
                                "The comment you're posting is related to the image below.",
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: size14, color: textColor),
                              ),
                              Image.asset("assets/awe_logo.png", width: 100)
                            ],
                          ),
                        ),
                        Form(
                          child: Column(
                            children: [
                              // TextFormField(
                              //   validator: (value) {
                              //     if (value == null || value.isEmpty) {
                              //       return 'Please enter your Name';
                              //     }
                              //     return null;
                              //   },
                              //   cursorColor: orangeColor,
                              //   style: const TextStyle(fontSize: size14),
                              //   decoration: InputDecoration(
                              //     hintText: "Your Name",
                              //     hintStyle: TextStyle(
                              //         color: textColor.withOpacity(0.4),
                              //         fontSize: size12),
                              //     labelText: "Name *",
                              //     labelStyle: const TextStyle(
                              //         color: textColor, fontSize: size14),
                              //     enabledBorder: const UnderlineInputBorder(
                              //         borderSide: BorderSide(color: orangeColor)),
                              //     focusedBorder: const UnderlineInputBorder(
                              //         borderSide: BorderSide(color: orangeColor)),
                              //   ),
                              // ),
                              const SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                controller: commentController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your Comment';
                                  }
                                  return null;
                                },
                                cursorColor: orangeColor,
                                style: const TextStyle(fontSize: size14),
                                decoration: InputDecoration(
                                  hintText: "Your Comment",
                                  hintStyle: TextStyle(
                                      color: const Color(0xff282828).withOpacity(0.4),
                                      fontSize: size12),
                                  labelText: "Comment *",
                                  labelStyle: const TextStyle(
                                      color: textColor, fontSize: size14),
                                  enabledBorder: const UnderlineInputBorder(
                                      borderSide: BorderSide(color: orangeColor)),
                                  focusedBorder: const UnderlineInputBorder(
                                      borderSide: BorderSide(color: orangeColor)),
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
                                    activeColor: orangeColor,
                                    value: checked,
                                    onChanged: (value) {
                                      setState(() {
                                        checked = value;
                                      });
                                    },
                                  ),
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
                                          "By posting this comment, you agree that your comment will be appropriate and follow Art Windsor-Essex guidelines."),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: FilledButton(
                                  onPressed: checked == true
                                      ? () async {
                                        CommentModel newComment = CommentModel(comment: commentController.text.trim(), artwork_id: 12, visible: true);
                                        print(newComment);
                                        bool result = await CommentRequest.postComment(newComment);
                                        if(result){
                                          showDialog(
                                              context: context,
                                              builder: (context) => confirmDialog(),
                                          );
                                        }
                                    // onPressed callback
                                  } : null,
                                  style: ButtonStyle(
                                    backgroundColor:
                                    MaterialStateProperty.resolveWith<Color>(
                                          (Set<MaterialState> states) {
                                        if (states.contains(MaterialState.disabled)) {
                                          return Colors.grey; // Color when disabled
                                        }
                                        return orangeColor; // Default color
                                      },
                                    ),
                                  ),
                                  child: const Text("Submit"),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
            )
          ],
      ),
    );
  }
  Widget confirmDialog(){
    return AlertDialog(
      content: Text(
          "Your comment has been posted!",
      ),
      contentTextStyle: Theme.of(context).textTheme.headlineMedium?.copyWith(fontSize: 20.0),
      actions: [
        TextButton(
            onPressed: (){
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: Text("Ok")
        )
      ],
    );
  }
}
