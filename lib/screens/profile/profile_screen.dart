import 'package:chronicles/utilities/components/buttons/infinite_width_button.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../services/secure_storage.dart';
import '../../utilities/components/buttons/custom_textbutton.dart';
import '../../utilities/components/profile/fetch_username.dart';
import '../../utilities/image_import/logo_import.dart';

final buttonHeight = 50.0;
final buttonCircularBorderRadius = 30.0;
final buttonVerticalPadding = 50.0;
final buttonHorizontalMargin = 120.0;
final Color buttonTextColor = Color(0xFFFFFFFF);
final Color buttonHighlightColor = Color(0xFF35879F);
final Color buttonSplashColor = Color(0xFF6BC9E2);

TextStyle buttonLabelTextStyle({required Color textColor}) {
  return TextStyle(
    color: textColor,
    fontSize: 17,
    fontWeight: FontWeight.w400,
    height: 0.5,
  );
}

final firstNameLastNameStyle = TextStyle(
  fontSize: 20.0,
  fontFamily: 'Hind',
  fontWeight: FontWeight.w500,
  color: Color(0xFF1F1F1F),
);

final usernameStyle = TextStyle(
  fontSize: 18.0,
  fontFamily: 'Hind',
  fontWeight: FontWeight.w300,
  color: Color(0xFF1F1F1F),
);

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String username = "Loading...";

  void initState() {
    super.initState();

    UserService.getUsername().then((fetchedUsername) {
      setState(() {
        username = fetchedUsername;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFFFFFFF),
        scrolledUnderElevation: 0.5,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(
              context,
              '/Dashboard',
                  (Route<dynamic> route) => false,
            );
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 20.0, right: 20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Padding(
            padding: EdgeInsets.only(top: 20.0),
            child: Center(
                child:
                ImageImport(width: 150, height: 150).importProfileIcon()),
          ),
          Text(
            "FirstName LastName",
            style: firstNameLastNameStyle,
          ),
          Text(
            username,
            style: usernameStyle,
          ),
          Padding(
            padding: EdgeInsets.only(top: 60.0),
            child: Container(
              height: 60,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Color(0x4D4EABCC),
                border: Border.all(
                  color: Color(0xFF4EABCC),
                  width: 1,
                ),
              ),
              child: InfiniteRoundWidthButton(
                onPress: () {},
                buttonLabel: Text(
                  "+ Friends",
                  style: buttonLabelTextStyle(textColor: buttonTextColor),
                ),
                height: buttonHeight,
                highlightColor: buttonHighlightColor,
                splashColor: buttonSplashColor,
                horizontalMargin: buttonHorizontalMargin,
                verticalMargin: 5,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 13.0, bottom: 40),
            child: Container(
              height: 255,
              decoration: BoxDecoration(
                  color: Color(0xFFF4F4F4),
                  borderRadius: BorderRadius.circular(30)),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 15.0, left: 15, right: 15),
                    child: CustomTextButton(
                      text: "Settings",
                      icon: Icons.settings,
                      onPressed: () {},
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10.0, left: 15, right: 15),
                    child: CustomTextButton(
                      text: "Badges",
                      icon: Icons.badge_outlined,
                      onPressed: () {},
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10.0, left: 15, right: 15),
                    child: CustomTextButton(
                      text: "Templates",
                      icon: Icons.design_services,
                      onPressed: () {},
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10.0, left: 15, right: 15),
                    child: CustomTextButton(
                      text: "Help",
                      icon: Icons.help_outline,
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: 60,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Color(0x4D4EABCC),
              border: Border.all(
                color: Color(0xFF4EABCC),
                width: 1,
              ),
            ),
            child: Padding(
              padding: EdgeInsets.only(left: 15, right: 15),
              child: CustomTextButton(
                  text: "Logout",
                  icon: Icons.logout_outlined,
                  containerColor: Color(0x804EABCC),
                  onPressed: () async {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      '/WelcomeScreen',
                          (Route<dynamic> route) => false,
                    );
                    SecureStorage storage = SecureStorage();
                    GoogleSignIn googleSignIn = GoogleSignIn();

                    await googleSignIn.signOut();

                    storage.updateSecureData('isLoginDone', 'false');
                    storage.updateSecureData('isPinRequired', 'false');
                  }),
            ),
          )
        ]),
      ),
    );
  }
}