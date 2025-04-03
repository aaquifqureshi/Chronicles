/*
* File Name        : privacy_policy.dart
* Group            : trOlsz Group
* Description      : This file contains code for Privacy Policy.
*/

import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

String privacyPolicy = """
**Chronicles - Diary Writing App**


**Effective Date:** [28 August 1938]

Hey there, diary enthusiast! 📖✨ We know privacy policies can be dull, but don’t worry—we’re keeping this one light, clear, and just the right amount of fun. At **Chronicles**, your privacy is sacred (like that embarrassing crush entry from high school). This Privacy Policy breaks down what we collect, why we collect it, and how we protect your data.

---

### 1. What We Collect (No, Not Your Secrets, don't worry!)

We collect some info to make your **Chronicles** experience smooth. But don’t worry—we won’t peek at your diary!(At all!)

#### a. Personal Information

- Your name, email, and profile details (if you create an account, ofc!)
- Contact info (only if you add friends or share entries—because diaries are more fun with buddies!)
- Authentication data (if you log in with Google, Apple, or some other magic portal)

#### b. Your Diary Entries & Content

- Your thoughts, dreams, and random rants are stored **locally** on your device.(don't worry, we won't read them!)
- Photos, voice notes, and other media you attach stay with you—unless you **choose** to back them up.
- Metadata like timestamps and tags help keep things organized.

#### c. App Usage Data

- How often you write, which features you love, and general app interactions (purely for making **Chronicles** better, not to judge your late-night overthinking sessions).
- Device info (like OS version) to keep things running smoothly.
- Error logs (so we can fix bugs and make sure your diary doesn’t vanish into the void).

---

### 2. Why We Need Your Data (Hint: To Make Chronicles Awesome!)

We use your info to:

- Keep **Chronicles** up and running
- Help you switch between **private** and **public** entries seamlessly
- Let you share entries with friends (if you’re feeling bold)
- Fix bugs and make things work better
- Stop the bad guys (a.k.a. fraud and security threats)
- Send you reminders (because we know how easy it is to forget to journal!)

---

### 3. Your Diary’s Fort Knox: Data Security & Storage 🔒

- **Local Storage:** Your diary stays **on your device** unless you back it up.
- **Encryption:** Fancy tech magic keeps your data safe.
- **No Creepy Ads:** We don’t sell your info. Period.
- **Cloud Backup (Optional):** If you choose, you can sync your entries to a secure cloud service like Google Drive or iCloud.
- **Breach Protection:** If something shady happens, we’ll let you know ASAP.

---

### 4. Privacy Controls (You’re the Boss!)

- Keep your entries **private** or **public**—your call!
- Control who sees your shared entries.
- No one (not even us) can snoop on your private diary.
- We never, ever sell your data.

---

### 5. Your Rights (Because You’re in Charge!)

- **Read, Edit, Delete:** Your data, your rules.
- **Nuke Your Account:** Want to disappear? We’ll wipe everything upon request.
- **Change Permissions:** Adjust what we can access anytime.
- **No Tracking:** We don’t follow you around the internet.

---

### 6. Third-Party Stuff (No Shady Business)

If you back up to Google Drive, iCloud, Firebase, or another service, their privacy rules apply. Please review their policies before enabling backups, as we use Firebase for some of our services.

---

### 7. Kids & Chronicles 🚸

If you’re under 13, sorry—you’ll have to wait to spill your teenage angst here. We don’t collect info from kids, and if we find out we have, we’ll delete it immediately.

---

### 8. Cookies? No Thanks! 🍪

Unlike websites, we don’t use cookies to track you. But we may use analytics to see which features are most loved (or ignored 😢).

---

### 9. Your Responsibilities

- Keep your login info safe (we don’t want hackers reading your diary!)
- Set up backups properly if you want extra security(and while changing your device ofc)
- Be mindful of what you share publicly

---

### 10. Legal Mumbo Jumbo

We follow data laws to keep your info safe. If a government ever asks for your data, we’ll make sure to explain them why can't we do so.

---

### 11. Updates to This Policy 📢

We may tweak this policy from time to time. If we make major changes, we’ll notify you via the app (because no one likes surprise policy updates).

---

### 12. Questions? Hit Us Up! 💌

Got questions, concerns, or just want to chat about how cool **Chronicles** is? Reach out(we'll respond ASAP):

**Email:** [chroniclesbytroslz@gmail.com]
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
