/*
* File Name        : privacy_policy.dart
* Group            : trOlsz Group
* Description      : This file contains code for Privacy Policy.
*/

import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

String privacyPolicy = """
## Privacy Policy

This privacy policy applies to the **Chronicles** app (hereby referred to as "Application") for mobile devices that was created by **trOlsz** (hereby referred to as "Service Provider") as an Open Source service. This service is intended for use **'AS IS'**.

---

## Information Collection and Use

The Application collects information when you download and use it. This information may include:

- Your device's Internet Protocol address (e.g. IP address)
- The pages of the Application that you visit, the time and date of your visit, and the time spent on those pages
- The operating system you use on your mobile device

The Application does **not** gather precise information about the location of your mobile device.

The Service Provider may use the information you provided to contact you from time to time to provide you with important information, required notices, and marketing promotions.

For a better experience, while using the Application, the Service Provider may require you to provide certain personally identifiable information. The information that the Service Provider requests will be retained and used as described in this privacy policy.

---

## Third-Party Access

Only aggregated, anonymized data is periodically transmitted to external services to aid the Service Provider in improving the Application and their service. The Service Provider may share your information with third parties in the ways described in this privacy statement.

### Third-Party Services Used:
- [Google Play Services](https://policies.google.com/privacy)
- [Google Analytics for Firebase](https://firebase.google.com/support/privacy/)
- [Firebase Crashlytics](https://firebase.google.com/support/privacy/)

The Service Provider may disclose User Provided and Automatically Collected Information:
- As required by law, such as to comply with a subpoena or similar legal process.
- When they believe in good faith that disclosure is necessary to protect their rights, protect your safety or the safety of others, investigate fraud, or respond to a government request.
- With their trusted service providers who work on their behalf, do not have an independent use of the information disclosed to them, and have agreed to adhere to this privacy policy.

---

## Opt-Out Rights

You can stop all collection of information by the Application easily by **uninstalling it**. You may use the standard uninstall processes available as part of your mobile device or via the mobile application marketplace.

---

## Data Retention Policy

The Service Provider will retain User Provided data for as long as you use the Application and for a reasonable time thereafter. If you'd like them to delete User Provided Data that you have provided via the Application, please contact them at **chroniclesbytrolsz@gmail.com**, and they will respond in a reasonable time.

---

## Children

The Application does **not** address anyone under the age of **13**. The Service Provider does **not** knowingly collect personally identifiable information from children under **13 years of age**. If they discover that a child under 13 has provided personal information, they will immediately delete it from their servers. If you are a parent or guardian and you are aware that your child has provided personal information, please contact the Service Provider at **chroniclesbytrolsz@gmail.com** so necessary actions can be taken.

---

## Security

The Service Provider is concerned about safeguarding the confidentiality of your information. They provide physical, electronic, and procedural safeguards to protect the information processed and maintained.

---

## Changes to This Policy

This Privacy Policy may be updated from time to time for any reason. The Service Provider will notify you of any changes by updating this page with the new Privacy Policy. You are advised to review this Privacy Policy **regularly** for any changes. Continued use of the Application is deemed as **approval** of all changes.

This privacy policy is effective as of **March 10, 2025**.

---

## Your Consent

By using the Application, you are **consenting** to the processing of your information as set forth in this Privacy Policy now and as amended in the future.

---

## Contact Us

If you have any questions regarding privacy while using the Application, or have questions about the practices, please contact the Service Provider via email at **chroniclesbytrolsz@gmail.com**.
""";

class PrivacyPolicyDialog extends StatelessWidget {
  const PrivacyPolicyDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      title: Text(
        "Privacy Policy",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
          color: Color(0xFF4EABCC),
          fontFamily: 'Hind',
        ),
      ),
      content: SizedBox(
        height: 400,
        child: Scrollbar(
          child: SingleChildScrollView(
            child: MarkdownBody(
              data: privacyPolicy,
              styleSheet: MarkdownStyleSheet(
                codeblockDecoration: BoxDecoration(
                  color: Colors.white,
                ),
                p: TextStyle(
                  backgroundColor: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text(
            "Close",
            style: TextStyle(
              color: Color(
                0xFF4EABCC,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: MarkdownBody(
          data: privacyPolicy,
          styleSheet: MarkdownStyleSheet(
            codeblockDecoration: BoxDecoration(
              color: Colors.white,
            ),
            p: TextStyle(
              backgroundColor: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
