import 'dart:core';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:myapp/FireBase/real_time_dataBase/post_model.dart';
import 'package:myapp/state_management/Provider/Models/real_time_post_provider.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../../router/constant_router.dart';

class AddingPostPage extends StatefulWidget {
  const AddingPostPage({Key? key}) : super(key: key);

  @override
  State<AddingPostPage> createState() => _AddingPostPageState();
}

class _AddingPostPageState extends State<AddingPostPage> {
  final formKey = GlobalKey<FormState>();
  final title = TextEditingController();
  final condition = TextEditingController();
  final price = TextEditingController();
  final author = TextEditingController();
  final address = TextEditingController();

  @override
  Widget build(BuildContext context) {
    //var PostProvider =Provider.of<PostProvider>(context);
    var postProvider = Provider.of<PostProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('sell your book'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              TextFieldBook(
                textEditingController: title,
                inputDecoration:
                    inputDecoration('Title', 'The title of your book'),
              ),
              TextFieldBook(
                textEditingController: author,
                inputDecoration:
                    inputDecoration('Author', 'The author of your book'),
              ),
              TextFieldBook(
                textEditingController: price,
                inputDecoration: inputDecoration(
                    'Selling Price', 'selling price of your book'),
              ),
              TextFieldBook(
                textEditingController: address,
                inputDecoration: inputDecoration('Address', 'Your Address'),
              ),
              TextFieldBook(
                textEditingController: condition,
                inputDecoration:
                    inputDecoration('Condition', 'The condition of the book'),
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      var id = Uuid().v4();
                      DateTime now = DateTime.now();
                      DateTime date = DateTime(now.year, now.month, now.day);
                      //we want to get the data from the controllers then fill the model then send it using Provider
                      // ignore: use_build_context_synchronously
                      showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return Container(
                            height: 200,
                            color: Colors.deepPurpleAccent.shade100,
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  myText(key: 'Title', txt: title.text),
                                  myText(key: 'Author', txt: author.text),
                                  myText(key: 'Price', txt: price.text),
                                  myText(key: 'Address', txt: address.text),
                                  myText(key: 'Condition', txt: condition.text),
                                  ElevatedButton(
                                      child: const Text('Post'),
                                      onPressed: () async {
                                        //we want to get the data from the controllers then fill the model then send it using Provider
                                        PostModel model = PostModel(
                                            title: title.text,
                                            author: author.text,
                                            condition: condition.text,
                                            address: address.text,
                                            price: int.parse(price.text),
                                            id: id,
                                            date: date.toString());
                                        await postProvider.addPost(model);
                                        log('dose not post anything');
                                        Navigator.of(context)
                                            .popAndPushNamed(buyBooksPage);
                                      }),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    }
                  },
                  child: Text('Add Post')),
            ],
          ),
        ),
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
