import 'package:chronicles/utilities/components/buttons/infinite_width_button.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../services/secure_storage.dart';
import '../../utilities/components/buttons/custom_textbutton.dart';
import '../../utilities/components/profile/fetch_username.dart';
import '../../utilities/image_import/logo_import.dart';

// Define your button heights, colors, etc.
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

  @override
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
      // Wrap the entire content in a SingleChildScrollView.
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              Center(
                child: ImageImport(width: 150, height: 150)
                    .importProfileIcon(),
              ),
              SizedBox(height: 20),
              Text(
                "FirstName LastName",
                style: firstNameLastNameStyle,
              ),
              Text(
                username,
                style: usernameStyle,
              ),
              SizedBox(height: 60),
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
              SizedBox(height: 13),
              // Remove the fixed height to ensure all buttons are visible and clickable.
              Padding(
                padding: EdgeInsets.only(bottom: 40),
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xFFF4F4F4),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding:
                        EdgeInsets.only(top: 15.0, left: 15, right: 15),
                        child: CustomTextButton(
                          text: "Settings",
                          icon: Icons.settings,
                          onPressed: () {},
                        ),
                      ),
                      Padding(
                        padding:
                        EdgeInsets.only(top: 10.0, left: 15, right: 15),
                        child: CustomTextButton(
                          text: "Badges",
                          icon: Icons.badge_outlined,
                          onPressed: () {},
                        ),
                      ),
                      Padding(
                        padding:
                        EdgeInsets.only(top: 10.0, left: 15, right: 15),
                        child: CustomTextButton(
                          text: "Templates",
                          icon: Icons.design_services,
                          onPressed: () {},
                        ),
                      ),
                      Padding(
                        padding:
                        EdgeInsets.only(top: 10.0, left: 15, right: 15),
                        child: CustomTextButton(
                          text: "Help",
                          icon: Icons.help_outline,
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text("Help Information"),
                                content: Container(
                                  height: 300,
                                  child: Scrollbar(
                                    child: SingleChildScrollView(
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Frequently Asked Questions:\n",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                                color: Color(0xFF6BC9E2),
                                                fontFamily: 'Hind'),
                                          ),
                                          Text(
                                            "1. How do I get started?\n"
                                                "   - Begin by creating an account...\n\n"
                                                "2. How to reset password?\n"
                                                "   - Go to settings ...\n\n"
                                                "3. Contact support:\n"
                                                "   - Email: chroniclesai@gmail.com\n\n"
                                                "4. Troubleshooting:\n"
                                                "   - Check internet connection\n"
                                                "   - Clear app cache...\n\n"
                                                "5. How do I add friends?:\n"
                                                "   - Look for your friend(s)' username\n"
                                                "   - Click 'Add friend'\n\n"
                                                "6. How do I change diary state?:\n"
                                                "   - Select your diary\n"
                                                "   - Change diary state\n\n"
                                                "7. How do I backup?:\n"
                                                "   - Go to settings\n"
                                                "   - Select local/cloud backup\n\n"
                                                "8. Privacy policy:\n"
                                                "   - Data collection details...\n\n"
                                                "9. About us:\n"
                                                "   - Chronicles AI, India",
                                            style: TextStyle(fontSize: 14),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: Text("Close"),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: 10.0, left: 15, right: 15, bottom: 15),
                        child: CustomTextButton(
                          text: "Privacy policy",
                          icon: Icons.privacy_tip,
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text("Privacy Policy"),
                                content: Container(
                                  height: 300,
                                  child: Scrollbar(
                                    child: SingleChildScrollView(
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Privacy Policy:\n",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                                color: Color(0xFF6BC9E2),
                                                fontFamily: 'Hind'),
                                          ),
                                          Text(
                                            "This privacy policy applies to the Chronicles app (hereby referred to as"
                                                " 'Application') for mobile devices that was created by trOlsz (hereby referred to as 'Service Provider'"
                                                ") as an Open Source service. This service is intended for use 'AS IS'.\n\n"
                                                "Information Collection and Use\n"
                                                "The Application collects information when you download and use it. This information may include information such as Your device's Internet Protocol address (e.g. IP address)"
                                                "The pages of the Application that you visit, the time and date of your visit, the time spent on those pages"
                                                "The time spent on the Application\n"
                                                "The operating system you use on your mobile device\n\n"
                                                " -The Application does not gather precise information about the location of your mobile device.\n "

                                                " The Service Provider may use the information you provided to contact you from time to time to provide you with important information, required notices and marketing promotions.\n"
                                                "For a better experience, while using the Application, the Service Provider may require you to provide us with certain personally identifiable information. The information that the Service Provider request will be retained by them and used as described in this privacy policy.\n\n"

                                                "Third Party Access\n"
                                                "Only aggregated, anonymized data is periodically transmitted to external services to aid the Service Provider in improving the Application and their service. The Service Provider may share your information with third parties in the ways that are described in this privacy statement.\n"
                                                "Please note that the Application utilizes third-party services that have their own Privacy Policy about handling data. Below are the links to the Privacy Policy of the third-party service providers used by the Application:\n"
                                                "Google Play Services\n"
                                                "Google Analytics for Firebase\n"
                                                "Firebase Crashlytics\n"
                                                "The Service Provider may disclose User Provided and Automatically Collected Information:\n"
                                                "as required by law, such as to comply with a subpoena, or similar legal process;\n"
                                                "when they believe in good faith that disclosure is necessary to protect their rights, protect your safety or the safety of others, investigate fraud, or respond to a government request;\n"
                                                "with their trusted services providers who work on their behalf, do not have an independent use of the information we disclose to them, and have agreed to adhere to the rules set forth in this privacy statement.\n\n"
                                                "Opt-Out Rights\n"
                                                "You can stop all collection of information by the Application easily by uninstalling it. You may use the standard uninstall processes as may be available as part of your mobile device or via the mobile application marketplace or network.\n\n"
                                                "Data Retention Policy\n"
                                                "The Service Provider will retain User Provided data for as long as you use the Application and for a reasonable time thereafter. If you'd like them to delete User Provided Data that you have provided via the Application, please contact them at chroniclesbytrolsz@gmail.com and they will respond in a reasonable time.\n\n"
                                                "Children:\n"
                                                "The Service Provider does not use the Application to knowingly solicit data from or market to children under the age of 13.\n"
                                                "The Application does not address anyone under the age of 13. The Service Provider does not knowingly collect personally identifiable information from children under 13 years of age. In the case the Service Provider discover that a child under 13 has provided personal information, the Service Provider will immediately delete this from their servers. If you are a parent or guardian and you are aware that your child has provided us with personal information, please contact the Service Provider (chroniclesbytrolsz@gmail.com) so that they will be able to take the necessary actions.\n\n"
                                                "Security\n"
                                                "The Service Provider is concerned about safeguarding the confidentiality of your information. The Service Provider provides physical, electronic, and procedural safeguards to protect information the Service Provider processes and maintains.\n\n"
                                                "Changes\n"
                                                "This Privacy Policy may be updated from time to time for any reason. The Service Provider will notify you of any changes to the Privacy Policy by updating this page with the new Privacy Policy. You are advised to consult this Privacy Policy regularly for any changes, as continued use is deemed approval of all changes.\n"
                                                "This privacy policy is effective as of 2025-03-10\n\n"
                                                "Your Consent\n"
                                                "By using the Application, you are consenting to the processing of your information as set forth in this Privacy Policy now and as amended by us.\n\n"
                                                "Contact Us\n"
                                                "If you have any questions regarding privacy while using the Application, or have questions about the practices, please contact the Service Provider via email at chroniclesbytrolsz@gmail.com."
                                            ,
                                            style: TextStyle(fontSize: 14),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: Text("Close"),
                                  ),
                                ],
                              ),
                            );
                          },
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
                  padding: EdgeInsets.symmetric(horizontal: 15),
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
                    },
                  ),
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}