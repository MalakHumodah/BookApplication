
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../../FireBase/firebase_cloud/cloud_posts_model.dart';
import '../../state_management/Provider/Models/cloud_post_provider.dart';
class AddingCloudPostPage extends StatefulWidget {
  const AddingCloudPostPage({Key? key}) : super(key: key);

  @override
  State<AddingCloudPostPage> createState() => _AddingCloudPostPageState();
}

class _AddingCloudPostPageState extends State<AddingCloudPostPage> {
  final formKey = GlobalKey<FormState>();
  final title = TextEditingController();
  final summary = TextEditingController();
  final author = TextEditingController();
  final type = TextEditingController();

  InputDecoration decoration(String label, String hint) {
    return InputDecoration(
        labelText: label,
        hintText: hint,
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue, width: 2),
        ));
  }
  @override
  Widget build(BuildContext context) {
    //var PostProvider =Provider.of<PostProvider>(context);
    var postProvider = Provider.of<CloudPostProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Data'),
      ),
      body: Center(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              TextFieldItem(
                controller: title,
                decoration: decoration('Title', 'Enter Title'),
              ),
              TextFieldItem(
                controller: author,
                decoration: decoration('author', 'Enter author'),
              ),
              TextFieldItem(
                controller: summary,
                decoration: decoration('summary', 'Enter summary'),
              ),
              TextFieldItem(
                controller: type,
                decoration: decoration('type', 'Enter type'),
              ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    child: Text('Add'),
                    onPressed: () async {
                      // data from cont --> fill model --> send model using prov
                      var id = Uuid().v4();
                      var model = CloudPostsModel(
                          author: author.text,
                          summary: summary.text,
                          title: title.text,
                          type: type.text,
                          id: id);
                      await postProvider.addPost(model).whenComplete(() {
                        Navigator.of(context).pop();
                      });
                    },
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class TextFieldItem extends StatelessWidget {
  const TextFieldItem(
      {Key? key, required this.controller, required this.decoration})
      : super(key: key);
  final TextEditingController controller;
  final InputDecoration decoration;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      child: TextFormField(
        controller: controller,
        decoration: decoration,
      ),
    );
  }
}

InputDecoration inputDecoration(String label, String hint) {
  return InputDecoration(
    hintText: hint,
    hintStyle: TextStyle(color: Colors.black38),
    labelText: label,
    labelStyle: TextStyle(color: Colors.black),
    enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.deepPurpleAccent, width: 2.5)),
    focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.purple, width: 2.5)),
  );
}

class TextFieldBook extends StatelessWidget {
  const TextFieldBook(
      {Key? key,
        required this.textEditingController,
        required this.inputDecoration})
      : super(key: key);
  final TextEditingController textEditingController;
  final InputDecoration inputDecoration;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8),
      child: TextFormField(
        controller: textEditingController,
        validator: (input) {
          if (input!.isEmpty) {
            return 'this field is required';
          }
          return null;
        },
        decoration: inputDecoration,
      ),
    );
  }
}

Widget myText({required String key, required String txt}) {
  return Padding(
    padding: const EdgeInsets.all(3.0),
    child: Text(
      '$key : $txt',
      style: TextStyle(
        fontSize: 15,
      ),
    ),
  );
}