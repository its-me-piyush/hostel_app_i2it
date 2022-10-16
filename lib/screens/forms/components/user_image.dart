import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class UserImage extends StatefulWidget {
  const UserImage({
    Key? key,
  }) : super(key: key);

  @override
  State<UserImage> createState() => _UserImageState();
}

class _UserImageState extends State<UserImage> {
  File _userImageFile = File('');
  String url = '';
  _takeImageFromGallery() async {
    try {
      var img =
          await ImagePicker.platform.pickImage(source: ImageSource.gallery);
      File _imageFieldFromLibrary = File(img!.path);

      //Create a reference to the location you want to upload to in firebase
      TaskSnapshot reference = await FirebaseStorage.instance
          .ref()
          .child("${cUser().uid}/profileImage.jpg")
          .putFile(_imageFieldFromLibrary);
      if (reference.state == TaskState.success) {
        url = await reference.ref.getDownloadURL();
        await cUser().updatePhotoURL(url);
      }
      setState(() {
        _userImageFile = File(_imageFieldFromLibrary.path);
      });
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Photo added successfully!')));
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  _takeImageFromCamera() async {
    try {
      var img =
          await ImagePicker.platform.pickImage(source: ImageSource.camera);
      File _imageFieldFromLibrary = File(img!.path);

      //Create a reference to the location you want to upload to in firebase
      TaskSnapshot reference = await FirebaseStorage.instance
          .ref()
          .child("${cUser().uid}/profileImage")
          .putFile(_imageFieldFromLibrary);
      if (reference.state == TaskState.success) {
        url = await reference.ref.getDownloadURL();
        await cUser().updatePhotoURL(url);
      }
      setState(() {
        _userImageFile = File(_imageFieldFromLibrary.path);
      });
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Photo added successfully!')));
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.only(
          bottom: getProportionateScreenHeight(15),
        ),
        child: Stack(
          children: [
            Container(
              // padding: EdgeInsets.all(getProportionateScreenWidth(15)),
              height: getProportionateScreenHeight(250),
              width: getProportionateScreenWidth(200),
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                  width: 2,
                ),
                // borderRadius: BorderRadius.circular(
                //   getProportionateScreenWidth(10),
                // ),
                shape: BoxShape.circle,
                // color
              ),
              child: cUser().photoURL == null
                  ? SvgPicture.asset(
                      'assets/images/user.svg',
                      fit: BoxFit.fill,
                    )
                  : Image(
                      image: NetworkImage(cUser().photoURL!),
                      fit: BoxFit.cover,
                    ),
            ),
            Positioned(
              bottom: getProportionateScreenWidth(25),
              right: getProportionateScreenWidth(25),
              child: InkWell(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    enableDrag: true,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(
                          getProportionateScreenWidth(20),
                        ),
                        topRight: Radius.circular(
                          getProportionateScreenWidth(20),
                        ),
                      ),
                    ),
                    builder: (context) => SizedBox(
                      height: getProportionateScreenHeight(100),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: _takeImageFromCamera,
                            child: Container(
                              margin: EdgeInsets.all(
                                  getProportionateScreenWidth(5)),
                              child: const Text(
                                'Camera',
                                style: TextStyle(fontSize: 24),
                              ),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: _takeImageFromGallery,
                            child: Container(
                              margin: EdgeInsets.all(
                                  getProportionateScreenWidth(5)),
                              child: const Text(
                                'Gallery',
                                style: TextStyle(fontSize: 24),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                child: SizedBox(
                    height: getProportionateScreenHeight(30),
                    width: getProportionateScreenWidth(30),
                    child: SvgPicture.asset('assets/images/edit_image.svg')),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
