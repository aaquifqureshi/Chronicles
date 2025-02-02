/*
* File Name     : chronicles.dart
* Date Created  : 1st February 2025
* last Modified : 1st February 2025
* Author        : Aaquif Qureshi
* Group         : trOlsz Group
* Description   : This file is the start point in this app.
*                It runs the app and send it to the next Screen
*                based on the authentication requirements set by
*                the group.
*
*/

import 'package:chronicles/screens/auth/login_screen.dart';
import 'package:chronicles/screens/auth/welcome_screen.dart';
import 'package:chronicles/screens/dashboard/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:chronicles/utilities/image_import/logo_import.dart';
import 'package:chronicles/utilities/components/textfields/gray_textfield.dart';
import 'package:chronicles/utilities/components/buttons/infinite_width_button.dart';

class RegisterScreen extends StatelessWidget {

  final double rightPadding = 25.0;
  final double leftPadding = 25.0;
  final double logoWidth = 130.0;
  final double logoHeight = 130.0;
  final double logoTop = 15.0;
  final double between_textfields = 12.0;
  final double topPadding = 0;
  final double bottomPadding = 12.0;

  final String createAccountText = 'Create Account';
  final String firstNameHint = 'First Name';
  final String lastNameHint = 'Last Name';
  final String emailHint = 'Email';
  final String passwordHint = 'Password';
  final String normalMeassageText = 'By Signing up you agree to our ';
  final String termsConditionText = 'Terms Conditions';
  final String privacyPolicyText = 'Privacy Policy';

  final String signUpText = 'Sign Up';
  final double verticalButtonMargin = 20.0;
  final double buttonHeight = 50.0;
  final double horizontalMargin = 0.0;
  final Color signUpTextColor = Color(0xFFFFFFFF);
  final Color loginRegisterHighlightColor = Color(0xFF35879F);
  final Color loginRegisterSplashColor = Color(0xFF6BC9E2);
  final String accountExistText = "Already have a account? ";
  final String loginButttonText = "Login";

  final createAccountStyle = TextStyle(
    height: 1.2,
    fontSize: 26.0,
    fontFamily: "Hind",
    fontWeight: FontWeight.bold,
    color: Color(0xFF1F1F1F),
  );

  final normalMeassageTextStyle = TextStyle(
    fontSize: 14.0,
    fontFamily: "Hind",
    fontWeight: FontWeight.w400,
    color: Color(0xFF1F1F1F),
  );


  final gestureButtonStyle = TextStyle(
    fontSize: 14.0,
    fontFamily: "Hind",
    fontWeight: FontWeight.bold,
    color: Color(0xFF4EABCC),
  );

  final accountExistStyle = TextStyle(
    fontSize: 16.0,
    fontFamily: "Hind",
    fontWeight: FontWeight.w600,
    color: Color(0xFF1F1F1F),
  );

  final loginButtonStyle = TextStyle(
    fontSize: 16.0,
    fontFamily: "Hind",
    fontWeight: FontWeight.w600,
    color: Color(0xFF4EABCC),
  );

  TextStyle buttonLabelTextStyle({required Color textColor}) {
    return TextStyle(
      color: textColor,
      fontSize: 17,
      fontWeight: FontWeight.w400,
      height: 0.5,
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => WelcomeScreen(),
          ),
        );
        return false;
      },

      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(top: 25),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => WelcomeScreen(),
                        ),
                      );
                    },
                  ),
                ),

                Padding(
                  padding: EdgeInsets.only(left: leftPadding,right: rightPadding,top: logoTop),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ImportLogo(width: logoWidth, height: logoHeight)
                          .importLogowo(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Center(
                            child: Text(
                              createAccountText,
                              style: createAccountStyle,
                            ),
                          ),
                          GrayTextfield(
                            hintText: firstNameHint,
                            topPadding: 41,
                            bottomPadding: bottomPadding,
                          ),
                          GrayTextfield(
                            hintText: lastNameHint,
                            topPadding: topPadding,
                            bottomPadding: bottomPadding,
                          ),
                          GrayTextfield(
                            hintText: emailHint,
                            topPadding: topPadding,
                            bottomPadding: bottomPadding,
                          ),
                          GrayTextfield(
                            hintText: passwordHint,
                            topPadding: topPadding,
                            bottomPadding: 13,
                          ),
                        ],
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(normalMeassageText,
                            style: normalMeassageTextStyle,),
                          GestureDetector(
                            onTap: () {},
                            child: Text(
                              termsConditionText,
                              style: gestureButtonStyle,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("& ",style: normalMeassageTextStyle,),
                          GestureDetector(
                            onTap: () {},
                            child: Text(
                              privacyPolicyText,
                              style: gestureButtonStyle,
                            ),
                          ),
                        ],
                      ),

                      InfiniteRoundWidthButton(
                        onPress: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => Dashboard(),
                            ),
                          );
                        },
                        buttonLabel: Text(
                          signUpText,
                          style: buttonLabelTextStyle(textColor: signUpTextColor),
                        ),
                        verticalMargin: verticalButtonMargin,
                        height: buttonHeight,
                        highlightColor: loginRegisterHighlightColor,
                        splashColor: loginRegisterSplashColor,
                        horizontalMargin: horizontalMargin,
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(accountExistText,style: accountExistStyle,),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => LoginScreen(),
                                ),
                              );
                            },
                            child: Text(
                              loginButttonText,
                              style: loginButtonStyle,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}