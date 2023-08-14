import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:food/screens/auth/sign_in_page.dart';
import '../../repository/api_service/api_service.dart';
import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import '../../widget/app_text_feild.dart';
import '../../widget/big_text.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final List<String> signUpImages = ["t.png", "f.png", "g.png"];
  bool isLoading = false; // Add a state to track loading status
  handleSignUp(
      String fName, String email, String password, String phone) async {
    setState(() {
      isLoading = true;
    });
    final apiServices = ApiServices();
    bool isSignedUp = await apiServices.signUp(fName, email, password, phone);
    setState(() {
      isLoading = false;
    });
    if (isSignedUp) {
      // Handle successful sign-up, e.g., navigate to the main page

      // Show success message
      final snackBar = SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Text('Sign-up successful!'),
        duration: Duration(seconds: 3),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const SignInPage(),
        ),
      );
    } else {
      // Handle sign-up failure, e.g., display an error message

      // Show failure message
      const snackBar = SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: AppColors.mainColor,
        content: Text('Sign-up failed. Please try again.'),
        duration: Duration(seconds: 3),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            SizedBox(
              height: Dimensions.screenHeight * 0.05,
            ),
            //app logo
            Container(
              height: Dimensions.screenHeight * 0.25,
              child: Center(
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 80,
                  backgroundImage: AssetImage("assets/image/part1.png"),
                ),
              ),
            ),
            //your email
            AppTextField(
              textController: emailController,
              hintText: "Email",
              icon: Icons.email,
            ),
            SizedBox(height: Dimensions.height20),
            //your password
            AppTextField(
              textController: passwordController,
              hintText: "Password",
              icon: Icons.password_sharp,
              isObscure: true,
            ),
            SizedBox(height: Dimensions.height20),
            //your Name
            AppTextField(
              textController: nameController,
              hintText: "Name",
              icon: Icons.person,
            ),
            SizedBox(height: Dimensions.height20),
            //your phone
            AppTextField(
              textController: phoneController,
              hintText: "Phone",
              icon: Icons.phone,
            ),
            SizedBox(height: Dimensions.height20),
            // sign up
            GestureDetector(
              onTap: () {
                handleSignUp(nameController.text, emailController.text,
                    passwordController.text, phoneController.text);
              },
              child: Container(
                width: Dimensions.screenWidth / 2,
                height: Dimensions.screenHeight / 13,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius30),
                  color: AppColors.mainColor,
                ),
                child: isLoading == true
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      )
                    : Center(
                        child: BigText(
                          text: "Sign Up",
                          size: Dimensions.font20 + Dimensions.font20 + 2,
                          color: Colors.white,
                        ),
                      ),
              ),
            ),
            SizedBox(
              height: Dimensions.height10,
            ),
            // tag line
            RichText(
              text: TextSpan(
                recognizer: TapGestureRecognizer()
                  ..onTap = () => Navigator.of(context).pop(),
                text: "Have an account already?",
                style: TextStyle(
                  color: Colors.grey[500],
                  fontSize: Dimensions.font20,
                ),
              ),
            ),
            SizedBox(
              height: Dimensions.screenHeight * 0.05,
            ),
            //sign up options
            RichText(
              text: TextSpan(
                text: "Sign up using one of the following methods",
                style: TextStyle(
                  color: Colors.grey[500],
                  fontSize: Dimensions.font16,
                ),
              ),
            ),
            Wrap(
              children: List.generate(
                3,
                (index) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    radius: Dimensions.radius30,
                    backgroundImage: AssetImage(
                      "assets/image/" + signUpImages[index],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
