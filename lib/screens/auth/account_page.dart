import 'dart:io';

import 'package:flutter/material.dart';
import 'package:food/screens/auth/sign_in_page.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import '../../widget/account_widget.dart';
import '../../widget/app_icon.dart';
import '../../widget/big_text.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  String? name;
  String? email;
  Future<void> clearSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  void getData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      name = prefs.getString('name');
      email = prefs.getString('email');
    });
  }

  final ImagePicker _picker = ImagePicker();
  @override
  void initState() {
    super.initState();
    _loadSelectedImagePath();
    getData();
  }

  String? _selectedImagePath;
  Future<void> _pickImageFromGallery() async {
    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        final prefs = await SharedPreferences.getInstance();

        setState(() {
          _selectedImagePath = pickedFile.path; // Set the selected image path.
        });
        await prefs.setString('selectedImagePath', _selectedImagePath!);
      } else {
        // User canceled the image selection
      }
    } catch (e) {
      // Handle any exceptions that might occur during image picking.
      print('Error picking image: $e');
    }
  }

  Future<void> _loadSelectedImagePath() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _selectedImagePath = prefs.getString('selectedImagePath');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        title: BigText(
          text: "Profile",
          size: 24,
          color: Colors.white,
        ),
      ),
      body: _buildUserLoggedInContent(),
    );
  }

  Widget _buildUserLoggedInContent() {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.only(top: Dimensions.height20),
      child: Column(
        children: [
          //profile
          // GestureDetector(
          //   onTap: () {
          //     _pickImageFromGallery();
          //   },
          //   child: AppIcon(
          //     icon: Icons.person,
          //     backgroundColor: AppColors.mainColor,
          //     iconColor: Colors.white,
          //     iconSize: Dimensions.height45 + Dimensions.height30,
          //     size: Dimensions.height15 * 10,
          //   ),
          // ),
          SizedBox(
            height: Dimensions.height30,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  //name
                  GestureDetector(
                    onTap: () {
                      _pickImageFromGallery();
                    },
                    child: CircleAvatar(
                      radius: 90,
                      backgroundImage: _selectedImagePath != null
                          ? FileImage(File(_selectedImagePath!))
                          : null,
                      child: _selectedImagePath == null
                          ? Icon(
                              Icons.person,
                              size: 180,
                              color: Colors.white,
                            )
                          : null,
                    ),
                  ),
                  AccountWidget(
                    appIcon: AppIcon(
                      icon: Icons.person,
                      backgroundColor: AppColors.mainColor,
                      iconColor: Colors.white,
                      iconSize: Dimensions.height10 * 5 / 2,
                      size: Dimensions.height10 * 5,
                    ),
                    bigText:
                        BigText(text: name!), // Replace with the user's name
                  ),
                  SizedBox(
                    height: Dimensions.height30,
                  ),
                  //phone
                  // AccountWidget(
                  //   appIcon: AppIcon(
                  //     icon: Icons.phone,
                  //     backgroundColor: Colors.green,
                  //     iconColor: Colors.white,
                  //     iconSize: Dimensions.height10 * 5 / 2,
                  //     size: Dimensions.height10 * 5,
                  //   ),
                  //   bigText: BigText(
                  //       text:
                  //           "123-456-7890"), // Replace with the user's phone number
                  // ),
                  // SizedBox(
                  //   height: Dimensions.height30,
                  // ),
                  // email
                  AccountWidget(
                    appIcon: AppIcon(
                      icon: Icons.email,
                      backgroundColor: Colors.yellow,
                      iconColor: Colors.white,
                      iconSize: Dimensions.height10 * 5 / 2,
                      size: Dimensions.height10 * 5,
                    ),
                    bigText:
                        BigText(text: email!), // Replace with the user's email
                  ),
                  SizedBox(
                    height: Dimensions.height30,
                  ),
                  // address
                  // AccountWidget(
                  //   appIcon: AppIcon(
                  //     icon: Icons.location_on,
                  //     backgroundColor: Colors.lightBlue,
                  //     iconColor: Colors.white,
                  //     iconSize: Dimensions.height10 * 5 / 2,
                  //     size: Dimensions.height10 * 5,
                  //   ),
                  //   bigText: BigText(
                  //     text: "Fill your Address",
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: Dimensions.height30,
                  // ),
                  // message
                  // AccountWidget(
                  //   appIcon: AppIcon(
                  //     icon: Icons.message,
                  //     backgroundColor: Colors.blueGrey,
                  //     iconColor: Colors.white,
                  //     iconSize: Dimensions.height10 * 5 / 2,
                  //     size: Dimensions.height10 * 5,
                  //   ),
                  //   bigText: BigText(
                  //     text: "Message",
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: Dimensions.height30,
                  // ),
                  // logout
                  GestureDetector(
                    onTap: () async {
                      await clearSharedPreferences();
                      Get.off(SignInPage());
                    },
                    child: AccountWidget(
                      appIcon: AppIcon(
                        icon: Icons.logout,
                        backgroundColor: Colors.red,
                        iconColor: Colors.white,
                        iconSize: Dimensions.height10 * 5 / 2,
                        size: Dimensions.height10 * 5,
                      ),
                      bigText: BigText(
                        text: "Logout",
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Dimensions.height30,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
