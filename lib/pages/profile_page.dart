import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myapp/FireBase/authentication/auth_services/authen_service.dart';
import 'package:myapp/state_management/SharedPref/user_model.dart';

import '../FireBase/authentication/auth_services/files_upload_service.dart';
import '../router/constant_router.dart';
import '../widgets/const.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key, required this.id}) : super(key: key);
  final String id;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  final _name = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final AuthService authService = AuthService();
  final FilesUploadService filesUploadService = FilesUploadService();
  UserModel? _userModel;
  File? file;
  ImagePicker imagePicker = ImagePicker();
  String imageURL = '';

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: authService.getUser(widget.id),
      builder: (ctx, snapshot) {
        var data = snapshot.data;

        if (data == null) {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        _userModel = data as UserModel;
        _name.text = _userModel!.name!;
        _email.text = _userModel!.email!;
        //showPass? _userModel!.password! : '*****'
        _password.text = _userModel!.password!;

        //fill null --> model : url
        //fill not null
        ImageProvider? image = (file == null
            ? NetworkImage(_userModel!.imageURL!.isNotEmpty
            ? _userModel!.imageURL!
            : staticImage)
            : FileImage(file!)) as ImageProvider<Object>;

        return Scaffold(
          appBar: AppBar(
            title: Text('welcome ${_userModel!.name}'),
          ),
          body: Column(
            children: [
              Expanded(
                  flex: 3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () async {
                          var result = await showDialog(
                              context: context,
                              builder: (context) {
                                return SimpleDialog(
                                  title: Text('Chose your image option.'),
                                  children: [
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.start,
                                        children: [
                                          SimpleDialogOption(
                                            child: Text(
                                              'Change your image',
                                            ),
                                            onPressed: () {
                                              Navigator.pop(context, true);
                                            },
                                          ),
                                          SimpleDialogOption(
                                            child: Divider(),
                                            onPressed: () {},
                                          ),
                                          SimpleDialogOption(
                                            child: Text(
                                              'View your image',
                                            ),
                                            onPressed: () {
                                              Navigator.pop(context, false);
                                            },
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                );
                              });
                          //actions
                          if (result != null) {
                            if (result) {
                              //change image
                              await chooseImage();
                              if (file != null) {
                                imageURL = await filesUploadService
                                    .fileUpload(file!, 'UserProfileImage')
                                    .whenComplete(() {
                                  log("User Image Changed");
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(
                                              "Your Profile Image is changed")));
                                });
                              }
                            } else {
                              //view image

                              Navigator.of(context).pushNamed(imageViewer,
                                  arguments: _userModel!.imageURL!.isNotEmpty
                                      ? _userModel!.imageURL!
                                      : staticImage);
                            }
                          }
                        },
                        child: CircleAvatar(
                          //image
                          backgroundImage: image,
                          maxRadius: 50,
                          minRadius: 25,
                        ),
                      ),
                      TextButton(
                        child: Text('Update'),
                        onPressed: () async {
                          if (imageURL!.isNotEmpty) {
                            _userModel!.imageURL = imageURL;
                            await authService
                                .updateUser(widget.id, _userModel!);
                          }
                        },
                      )
                    ],
                  )),
              Expanded(
                flex: 1,
                child: Padding(
                  padding:
                  const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  child: TextFormField(
                    controller: _name,
                    maxLines: 1,
                    autofocus: false,
                    decoration: InputDecoration(
                        hintText: 'Name',
                        icon: Icon(
                          Icons.person,
                          color: Colors.grey,
                        )),
                    validator: (value) =>
                    value!.isEmpty ? 'Name can\'t be empty' : null,
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding:
                  const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  child: TextFormField(
                    enabled: false,
                    controller: _email,
                    maxLines: 1,
                    autofocus: false,
                    decoration: InputDecoration(
                        hintText: 'Email',
                        icon: Icon(
                          Icons.email,
                          color: Colors.grey,
                        )),
                    validator: (value) =>
                    value!.isEmpty ? 'Email can\'t be empty' : null,
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding:
                  const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  child: TextFormField(
                    controller: _password,
                    maxLines: 1,
                    obscureText: true,
                    autofocus: false,
                    decoration: InputDecoration(
                        hintText: 'Email',
                        icon: Icon(
                          Icons.email,
                          color: Colors.grey,
                        )),
                    validator: (value) =>
                    value!.isEmpty ? 'Email can\'t be empty' : null,
                  ),
                ),
              ),
              ElevatedButton(
                child: Text('Update'),
                onPressed: () async {
                  var model = UserModel(
                      id: widget.id,
                      password: _password.text,
                      email: _email.text,
                      name: _name.text);
                  await authService
                      .updateUser(widget.id, model);
                },
              )
            ],
          ),
        );
      },
    );
  }
  chooseImage() async {
    final pickedImage = await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedImage!.path.isEmpty) {
      //lost data : old data
      retrieveLostData();
    } else {
      setState(() {
        file = File(pickedImage.path);
      });
    }
  }

  Future<void> retrieveLostData() async {
    final LostDataResponse result = await imagePicker.retrieveLostData();
    if (result.file == null) {
      log("Null LOST DATA");
    } else {
      setState(() {
        file = File(result.file!.path);
      });
    }
  }
}


/* */
