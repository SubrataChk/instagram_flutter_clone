import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_flutter_clone/src/model/user.dart';
import 'package:instagram_flutter_clone/src/provider/user_provider.dart';
import 'package:instagram_flutter_clone/src/service/firestore_method.dart';
import 'package:instagram_flutter_clone/src/utils/color.dart';
import 'package:instagram_flutter_clone/src/utils/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class AddPostPage extends StatefulWidget {
  const AddPostPage({Key? key}) : super(key: key);

  @override
  State<AddPostPage> createState() => _AddPostPageState();
}

class _AddPostPageState extends State<AddPostPage> {
  TextEditingController _descriptionController = TextEditingController();
  Uint8List? _file;
  bool _isLoading = false;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _descriptionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final users = Provider.of<UserProvider>(context).getUser;

    return _file == null
        ? Container(
            child: IconButton(
              onPressed: () {
                _selectImage(context);
              },
              icon: Icon(
                Icons.upload,
                size: 8.w,
              ),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              backgroundColor: mobileBackgroundColor,
              leading: IconButton(
                  onPressed: clearImage,
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                    size: 7.w,
                  )),
              title: Text(
                "Post to",
                style: TextStyle(color: Colors.white, fontSize: 16.sp),
              ),
              centerTitle: false,
              actions: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2.w),
                  child: TextButton(
                      onPressed: () =>
                          postImage(users!.uid, users.username, users.photoUrl),
                      child: Text(
                        "Post",
                        style: TextStyle(
                            fontSize: 12.sp,
                            color: Colors.blueAccent,
                            fontWeight: FontWeight.bold),
                      )),
                ),
              ],
            ),
            body: SafeArea(
                child: Column(
              children: [
                _isLoading
                    ? const LinearProgressIndicator()
                    : const Padding(
                        padding: EdgeInsets.only(top: 0),
                      ),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                        radius: 7.w,
                        backgroundImage: NetworkImage(users!.photoUrl)),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: TextField(
                        controller: _descriptionController,
                        maxLines: 8,
                        decoration: const InputDecoration(
                          hintText: "Write a caption....",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 8.h,
                      width: 16.w,
                      child: AspectRatio(
                        aspectRatio: 487 / 451,
                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: MemoryImage(_file!),
                                fit: BoxFit.fill,
                                alignment: FractionalOffset.topCenter),
                          ),
                        ),
                      ),
                    ),
                    const Divider()
                  ],
                )
              ],
            )),
          );
  }

  _selectImage(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: Text("Create Post"),
            children: [
              SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text("Take a photo"),
                onPressed: () async {
                  Navigator.of(context).pop();
                  Uint8List file = await pickImage(ImageSource.camera, context);
                  setState(() {
                    _file = file;
                  });
                },
              ),
              SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text("Choose from gallery"),
                onPressed: () async {
                  Navigator.of(context).pop();
                  Uint8List file =
                      await pickImage(ImageSource.gallery, context);
                  setState(() {
                    _file = file;
                  });
                },
              ),
              SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text("Cancel"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  ///
  void postImage(String uid, String userName, String profImage) async {
    setState(() {
      _isLoading = true;
    });

    try {
      String res = await FirestoreMethod().uploadPost(context,
          _descriptionController.text, _file!, uid, userName, profImage);

      if (res == "success") {
        setState(() {
          _isLoading = false;
        });
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("posted")));
        clearImage();
      } else {
        setState(() {
          _isLoading = false;
        });
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(res)));
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  void clearImage() {
    setState(() {
      _file = null;
    });
  }
}
