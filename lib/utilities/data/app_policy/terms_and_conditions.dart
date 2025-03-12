/*
* File Name        : terms_and_conditions.dart
* Group            : trOlsz Group
* Description      : This file contains code for T&C.
*/

import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

String termsAndConditions = """
## Terms & Conditions

These terms and conditions apply to the **Chronicles** app (hereby referred to as "Application") for mobile devices that was created by **trOlsz** (hereby referred to as "Service Provider") as an Open Source service.

---

## Agreement

Upon downloading or utilizing the Application, you are automatically agreeing to the following terms. Unauthorized copying, modification, or extraction of source code is strictly prohibited. All intellectual property rights remain with the Service Provider.

---

## Modification of Services

The Service Provider reserves the right to modify the Application or charge for its services at any time. Any charges will be clearly communicated.

---

## Security and Device Integrity

The Application processes personal data provided by you. The Service Provider strongly advises against jailbreaking or rooting your device, as it may compromise security and app functionality.

---

## Third-Party Services

The Application uses third-party services that have their own Terms and Conditions:

- Google Play Services
- Google Analytics for Firebase
- Firebase Crashlytics

---

## Network and Data Charges

Some functions require an active internet connection. The Service Provider is not responsible for connectivity issues or data charges from your provider.

---

## User Responsibility

It is your responsibility to ensure your device remains charged and operational while using the Application.

---

## Liability Limitations

The Service Provider relies on third parties for information and does not accept liability for losses due to reliance on the Application's functionality.

---

## Updates and Termination

The Service Provider may update or discontinue the Application without prior notice. You must accept updates to continue usage.

---

## Changes to These Terms and Conditions

These terms may be updated periodically. It is your responsibility to review them regularly.

**Effective Date:** March 11, 2025

---

## Contact Us

For any questions, contact us at **chroniclesbytrolsz@gmail.com**.
""";

class TermsConditionsDialog extends StatelessWidget {
  const TermsConditionsDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      title: Text(
        "Terms & Conditions",
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
              data: termsAndConditions,
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

class TermsAndConditionsScreen extends StatelessWidget {
  const TermsAndConditionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: MarkdownBody(
          data: termsAndConditions,
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
