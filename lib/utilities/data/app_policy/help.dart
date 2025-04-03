/*
* File Name        : help.dart
* Group            : trOlsz Group
* Description      : This file contains code for HELP FAQ.
*/

import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

String frequentlyAskedQuestions = """
 
Hey there, wordsmith! 📝✨ Welcome to **Chronicles**, the app where you can pour your heart out, make lists, and store all those deep (or super random) thoughts. But before you dive into your journaling adventure, let’s lay down some ground rules, and let us help you in whatever way we can! Don’t worry—we’ll keep it fun and simple!

---

### 1. How Do I Get Started? 🚀
- First things first—create an account.
- Set up your **name, username, password, and profile picture** (make it a good one!).
- Start writing! Your thoughts are waiting.

---

### 2. How to Reset Password? 🔑
- Head over to **Settings**.
- Select **Reset Password**.
- We’ll send a confirmation (because we need to make sure it’s really you and not your nosy sibling).

---

### 3. Contact Support 📧 (But, Like, Don’t Spam Us!)
- **Email:** chroniclesbytrolsz@gmail.com
- We love helping, but if you send 50 emails asking how to spell "diary" and not "dairy", we might ignore you. 🙃

---

### 4. Troubleshooting: The “Did You Try Turning It Off & On?” Guide 🛠️
- **Check your internet connection** (Duh!).
- **Clear app cache** (because sometimes, your phone just needs a fresh start).
- **If it’s our fault, we’ll let you know!** (We’re honest like that.)

---

### 5. How Do I Add Friends? 👥
- Look for your friend’s **username** (hopefully, they actually use Chronicles).
- Click **‘Add Friend’**.
- **Make sure it’s actually your friend** and not some random person named Bob from the internet.

---

### 6. How Do I Change Diary State? 🔓
- Select your diary.
- Change diary **state (private or public).**
- **Double-check before making your deep thoughts public**—we’re not responsible for any unexpected oversharing!

---

### 7. How Do I Backup? ☁️
- Go to **Settings**.
- Choose **Local or Cloud Backup**.
- **Don't back up without reason!** Server costs are through the roof these days. 🙄

---

### 8. Can I Delete My Account? ❌
- Yes, but we’ll be sad. 😢
- Go to **Settings > Delete Account**.
- Warning: This is permanent! No “Oops, I changed my mind” button here.

---

### 9. About Us: Meet the Geniuses Behind Chronicles 🏆
**trOlsz Group:**

1. **Malav Shah** – Utility Engineer (a.k.a. the one who makes sure things actually work)
2. **Asgar Datari** – UI/UX Designer (if the app looks pretty, thank him)
3. **Aaquif Qureshi** – Full Stack Developer, Firebase Engineer (he codes, he Firebase-s, he does it all)
4. **Mrunal Shah** – Backend Developer, Database Engineer (makes sure your diary doesn’t vanish into the void, the man behind it all, he's omnipresent!)

---

### 10. Can I Suggest Features? 💡
- YES! We love ideas (as long as they don’t involve turning this into a dating app).
- Send us your suggestions at **chroniclesbytrolsz@gmail.com**.

---

### 11. Any Hidden Fees? 💰
- Nope, no sneaky stuff here.
- If we ever add premium features, we’ll tell you upfront (no “surprise” charges, promise!).

---

### 12. Anything Else I Should Know? 🤔
- Write freely, but **don’t break the law** (diary confessions ≠ legal immunity).
- If you post something public, don’t be surprised if people actually read it!
- Most importantly—HAVE FUN journaling! 📖✨

### 13. Contact us:
- Lastly but not least(we hate to say goodbye here 😢), if your questions aren't answered here, feel free to contact us at: chroniclesbytrolsz@gmail.com, we'll do everything in our power to help you!

 """;

class HelpDialog extends StatelessWidget {
  const HelpDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Color(0xFFFFFFFF),
      title: Text(
        "Frequently Asked Questions:\n",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
          color: Color(0xFF4EABCC),
          fontFamily: 'Hind',
        ),
      ),
      content: SizedBox(
        height: 300,
        child: Scrollbar(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MarkdownBody(
                  data: frequentlyAskedQuestions,
                  styleSheet: MarkdownStyleSheet(
                    codeblockDecoration: BoxDecoration(
                      color: Color(0xFFFFFFFF),
                    ),
                    p: TextStyle(
                      backgroundColor: Color(0xFFFFFFFF),
                    ),
                  ),
                )
              ],
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
