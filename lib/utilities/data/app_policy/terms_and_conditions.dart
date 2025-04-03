/*
* File Name        : terms_and_conditions.dart
* Group            : trOlsz Group
* Description      : This file contains code for T&C.
*/

import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

String termsAndConditions = """
**Chronicles - Diary Writing App**


**Effective Date:** [28 August 1938]

Hey there, wordsmith! 📝✨ Welcome to **Chronicles**, the app where you can pour your heart out, make lists, and store all those deep (or super random) thoughts. But before you dive into your journaling adventure, let’s lay down some ground rules. Don’t worry—we’ll keep it fun and simple! 🎉

---

### 1. Accepting These Terms (Yup, You Gotta Read Them)

By using **Chronicles**, you agree to follow these terms. If you don’t agree, we totally understand—but you can’t use the app. Simple as that!

---

### 2. What You Can & Can’t Do (Play Nice!)

You **can**:
- Write freely (it’s your diary, after all!).
- Choose to keep entries private or share them with friends.
- Back up your data for safekeeping.
- Use the app as long as you follow these terms.

You **can’t**:
- Use the app for anything illegal, harmful, or just plain mean (cyberbullying isn’t cool).
- Try to hack, modify, or mess with the app in weird ways.
- Post stuff that breaks copyright laws (your original poetry = great, someone else’s novel = not so great).
- Spam other users (this isn’t an ad board, it’s a diary app!).

---

### 3. Your Data, Your Rules (But Read This!)

- Your entries stay **yours**. We don’t own your content, and we don’t snoop.
- Private entries stay private unless you **choose** to share them.
- If you back up your diary, make sure your cloud service is secure.
- We may collect some **anonymous** data to improve the app (see our Privacy Policy for the full scoop).

---

### 4. Account & Security (Keep It Safe!)

- You’re responsible for keeping your login details safe (because nobody wants a hacked diary).
- If you suspect someone else is accessing your account, **change your password ASAP**.
- We can’t recover your private entries if they’re lost and not backed up, so be careful!

---

### 5. Age Restrictions (Sorry, Kids!)

If you’re under **13**, you’ll need to wait to start your **Chronicles** journey. If we find out someone under 13 is using the app, we’ll have to remove their account (nothing personal!).

---

### 6. Paid Features (Because We Gotta Keep the Lights On)

- Chronicles may introduce premium features in the futures (no plans to do so right now!)
- If you subscribe to premium, payments are handled by the app store (Google Play or Apple).
- No refunds for partially used subscriptions, so choose wisely!

---

### 7. Bugs & Glitches (Hey, It Happens!)

We work hard to keep **Chronicles** running smoothly, but sometimes bugs sneak in. 🐞 If you find one, let us know! We’ll do our best to fix it.

---

### 8. Termination (No Hard Feelings, We Hope!)

- You can delete your account whenever you want (though we’ll miss you!).
- If you break these rules, we **may** suspend or delete your account.
- We won’t delete accounts without a good reason (so don’t worry, we’re not trigger-happy!).

---

### 9. Third-Party Services (Read Their Rules Too!)

If you back up your diary to Google Drive, iCloud, or another service, their privacy policies apply. We’re not responsible if their systems have a bad day.

---

### 10. Updates to These Terms (We’ll Keep You Posted!)

- We may update these Terms & Conditions occasionally.
- If we make major changes, we’ll let you know through the app.
- Keep checking back so you’re always in the loop!

---

### 11. Legal Stuff (The Boring but Important Part)

- We’re not responsible if you lose your data due to device failure, accidental deletion, or some other unfortunate event.
- We’re also not responsible for what you post (your thoughts, your responsibility!).
- If there’s ever a legal dispute, we’ll try to resolve it in a friendly way first.

---

### 12. Need Help? Reach Out! 💌

Got questions? Technical issues? Just want to say hi? Contact us!

**Email:** : chroniclesbytroslz@gmail.com




---

That’s it! Now go forth and write your heart out. 📖✨


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
