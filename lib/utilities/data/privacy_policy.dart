import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Privacy Policy")),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Privacy Policy:\n",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Color(0xFF6BC9E2),
                fontFamily: 'Hind',
              ),
            ),
            Text(
              """This privacy policy applies to the Chronicles app (hereby referred to as 'Application') for mobile devices that was created by trOlsz (hereby referred to as 'Service Provider') as an Open Source service. This service is intended for use 'AS IS'.\n\n""",
              style: TextStyle(fontSize: 14),
            ),
            _buildSectionTitle("Information Collection and Use"),
            _buildSectionContent(
              """The Application collects information when you download and use it. This information may include:\n
- Your device's Internet Protocol address (IP address)
- The pages of the Application that you visit
- The time and date of your visit, the time spent on those pages
- The time spent on the Application
- The operating system of your mobile device

The Application does not gather precise information about the location of your mobile device.

The Service Provider may use the information you provided to contact you from time to time to provide you with important information, required notices, and marketing promotions.""",
            ),
            _buildSectionTitle("Third-Party Access"),
            _buildSectionContent(
              """Only aggregated, anonymized data is periodically transmitted to external services to aid in improving the Application and its services. The Service Provider may share your information with third parties as described in this privacy statement.

The Application utilizes third-party services with their own Privacy Policies regarding data handling. Below are links to the Privacy Policies of these third-party service providers:\n
- Google Play Services
- Google Analytics for Firebase
- Firebase Crashlytics

The Service Provider may disclose User Provided and Automatically Collected Information:
- As required by law (e.g., to comply with subpoenas or legal processes)
- When necessary to protect rights, investigate fraud, or respond to government requests
- To trusted service providers who adhere to the rules in this privacy policy""",
            ),
            _buildSectionTitle("Opt-Out Rights"),
            _buildSectionContent(
              """You can stop all collection of information by uninstalling the Application. You may use the standard uninstall processes available on your mobile device or via the app marketplace.""",
            ),
            _buildSectionTitle("Data Retention Policy"),
            _buildSectionContent(
              """The Service Provider will retain user-provided data as long as you use the Application and for a reasonable time thereafter. If you would like your data deleted, please contact chroniclesbytrolsz@gmail.com.""",
            ),
            _buildSectionTitle("Children's Privacy"),
            _buildSectionContent(
              """The Application does not knowingly collect data from children under the age of 13. If it is discovered that a child under 13 has provided personal information, it will be deleted immediately. If you are a parent or guardian and are aware that your child has provided personal information, please contact us at chroniclesbytrolsz@gmail.com.""",
            ),
            _buildSectionTitle("Security"),
            _buildSectionContent(
              """The Service Provider safeguards the confidentiality of your information through physical, electronic, and procedural measures.""",
            ),
            _buildSectionTitle("Changes to This Privacy Policy"),
            _buildSectionContent(
              """This Privacy Policy may be updated periodically. You are advised to review this page for any changes. Continued use of the Application implies acceptance of any updates.""",
            ),
            _buildSectionTitle("Your Consent"),
            _buildSectionContent(
              """By using the Application, you consent to the processing of your information as outlined in this Privacy Policy.""",
            ),
            _buildSectionTitle("Contact Us"),
            _buildSectionContent(
              """If you have any questions about this Privacy Policy, contact us at chroniclesbytrolsz@gmail.com.""",
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0, bottom: 4.0),
      child: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
          color: Colors.black87,
        ),
      ),
    );
  }

  Widget _buildSectionContent(String content) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Text(
        content,
        style: TextStyle(fontSize: 14),
      ),
    );
  }
}
