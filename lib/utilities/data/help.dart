import 'package:flutter/material.dart';

class HelpDialog extends StatelessWidget {
  const HelpDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Help Information"),
      content: SizedBox(
        height: 300,
        child: Scrollbar(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "Frequently Asked Questions:\n",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Color(0xFF6BC9E2),
                    fontFamily: 'Hind',
                  ),
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
          child: const Text("Close"),
        ),
      ],
    );
  }
}
