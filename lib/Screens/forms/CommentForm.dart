import 'package:flutter/material.dart';

class CommentForm extends StatefulWidget {
  static const id = "CommentForm";

  const CommentForm({super.key});

  @override
  State<CommentForm> createState() => _CommentFormState();
}

class _CommentFormState extends State<CommentForm> {
  bool? checked = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff6f6f6),
      appBar: AppBar(
        elevation: 0,
        shadowColor: Colors.transparent,
        backgroundColor: const Color(0xfff6f6f6),
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
                padding: const EdgeInsets.only(left: 25, right: 25),
                child: Column(
                  children: [
                    const Text(
                      "Comments",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff282828)),
                    ),
                    Image.asset("assets/awe_logo.png", width: 100)
                  ],
                ),
              ),
            ),
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
                          const Text(
                            "The comment you're posting is related to the image below.",
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
                            cursorColor: const Color(0xfff55d00),
                            style: const TextStyle(fontSize: 14),
                            decoration: InputDecoration(
                              hintText: "Your Name",
                              hintStyle: TextStyle(
                                  color:
                                      const Color(0xff282828).withOpacity(0.4),
                                  fontSize: 12),
                              labelText: "Name *",
                              labelStyle: const TextStyle(
                                  color: Color(0xff282828), fontSize: 14),
                              enabledBorder: const UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xfff55d00))),
                              focusedBorder: const UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xfff55d00))),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            cursorColor: const Color(0xfff55d00),
                            style: const TextStyle(fontSize: 14),
                            decoration: InputDecoration(
                              hintText: "Your Comment",
                              hintStyle: TextStyle(
                                  color:
                                      const Color(0xff282828).withOpacity(0.4),
                                  fontSize: 12),
                              labelText: "Comment *",
                              labelStyle: const TextStyle(
                                  color: Color(0xff282828), fontSize: 14),
                              enabledBorder: const UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xfff55d00))),
                              focusedBorder: const UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xfff55d00))),
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
                                activeColor: const Color(0xfff55d00),
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
                                      "By posting this comment, you agree that your comment will be appropriate and follow Art Windsor-Essex and St. Clair College guidelines."),
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
                                  ? () {
                                      // onPressed callback
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
                                    return const Color(
                                        0xfff55d00); // Default color
                                  },
                                ),
                              ),
                              child: const Text("Submit"),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
