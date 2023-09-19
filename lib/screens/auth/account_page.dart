import 'package:flutter/material.dart';
import 'package:food/screens/auth/sign_in_page.dart';
import 'package:get/get.dart';
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

  @override
  void initState() {
    super.initState();
    getData();
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
          AppIcon(
            icon: Icons.person,
            backgroundColor: AppColors.mainColor,
            iconColor: Colors.white,
            iconSize: Dimensions.height45 + Dimensions.height30,
            size: Dimensions.height15 * 10,
          ),
          SizedBox(
            height: Dimensions.height30,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  //name
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
