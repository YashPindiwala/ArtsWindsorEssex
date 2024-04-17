import 'package:flutter/material.dart';
import 'package:artswindsoressex/Screens/Models/CommentModel.dart';
import 'package:artswindsoressex/API/CommentRequest.dart';
import '../../constants.dart';
import '../AboutApp.dart';

class CommentForm extends StatefulWidget {
  static const id = "CommentForm";

  const CommentForm({Key? key})
      : super(key: key); // Constructor for CommentForm widget

  @override
  State<CommentForm> createState() =>
      _CommentFormState(); // Create state for CommentForm widget
}

class _CommentFormState extends State<CommentForm> {
  bool? checked = false; // State variable to track checkbox state
  TextEditingController commentController =
      TextEditingController(); // Controller for comment text field

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? args = ModalRoute.of(context)
            ?.settings
            .arguments
        as Map<String, dynamic>?; // Retrieve arguments passed to this widget
    final int? artwork_id =
        args?['artwork_id']; // Extract artwork ID from arguments

    return Scaffold(
      backgroundColor: backgroundColor, // Background color
      appBar: AppBar(
        elevation: 0,
        shadowColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        backgroundColor: backgroundColor,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        const AboutApp()), // Navigate to AboutApp screen
              );
            },
            icon: const Icon(Icons.info_outline_rounded), // Info icon
          )
        ],
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Comments",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: size24,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
          Image.asset("assets/awe_logo.png", width: 60), // AWE logo image
          Expanded(
            child: Container(
              padding: EdgeInsets.only(top: 25, left: 25, right: 25),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
                color: Colors.white,
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Center(
                      child: Column(
                        children: [
                          const SizedBox(height: 20),
                          const Text(
                            "The comment you're posting is related to the image below.",
                            textAlign: TextAlign.center,
                            style:
                                TextStyle(fontSize: size14, color: textColor),
                          ),
                          Image.asset("assets/awe_logo.png",
                              width: 100), // AWE logo image
                        ],
                      ),
                    ),
                    Form(
                      child: Column(
                        children: [
                          const SizedBox(height: 20),
                          TextFormField(
                            controller: commentController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your Comment'; // Validate comment field
                              }
                              return null;
                            },
                            onChanged: (value) {
                              setState(() {}); // Update UI on text field change
                            },
                            cursorColor: orangeColor,
                            style: const TextStyle(fontSize: size14),
                            decoration: InputDecoration(
                              hintText: "Your Comment",
                              hintStyle: TextStyle(
                                color: const Color(0xff282828).withOpacity(0.4),
                                fontSize: size12,
                              ),
                              labelText: "Comment *",
                              labelStyle: const TextStyle(
                                  color: textColor, fontSize: size14),
                              enabledBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: orangeColor),
                              ),
                              focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: orangeColor),
                              ),
                            ),
                          ),
                          const SizedBox(height: 40),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Checkbox(
                                tristate: false,
                                activeColor: orangeColor,
                                value: checked,
                                onChanged: (value) {
                                  setState(() {
                                    checked = value; // Update checked state
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
                                    "By posting this comment, you agree that your comment will be appropriate and follow Art Windsor-Essex guidelines.",
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 30),
                          Align(
                            alignment: Alignment.centerRight,
                            child: FilledButton(
                              onPressed: checked == true &&
                                      commentController.text.length > 0
                                  ? () async {
                                      CommentModel newComment = CommentModel(
                                        comment: commentController.text.trim(),
                                        artwork_id:
                                            artwork_id!, // Assign artwork ID
                                        visible: true,
                                      );
                                      bool result =
                                          await CommentRequest.postComment(
                                              newComment); // Send comment to API
                                      if (result) {
                                        showDialog(
                                          context: context,
                                          builder: (context) =>
                                              confirmDialog(), // Show confirmation dialog
                                        );
                                      }
                                    }
                                  : null,
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.resolveWith<Color>(
                                  (Set<MaterialState> states) {
                                    if (states
                                        .contains(MaterialState.disabled)) {
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
            ),
          )
        ],
      ),
    );
  }

  // Confirmation dialog for successful comment submission
  Widget confirmDialog() {
    return AlertDialog(
      content: Text(
        "Your comment has been posted!",
      ),
      contentTextStyle:
          Theme.of(context).textTheme.headlineMedium?.copyWith(fontSize: 20.0),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            Navigator.pop(context); // Close dialog and CommentForm screen
          },
          child: const Text("Ok"),
        )
      ],
    );
  }
}
