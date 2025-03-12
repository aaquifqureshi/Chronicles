import 'package:chronicles/utilities/data/user_auth_data.dart';
import 'package:chronicles/utilities/image_import/logo_import.dart';
import 'package:flutter/material.dart';

class ProfileAvatar extends StatefulWidget {
  const ProfileAvatar({super.key});

  @override
  State<ProfileAvatar> createState() => _ProfileAvatarState();
}

class _ProfileAvatarState extends State<ProfileAvatar> {
  int streak = 0;

  Future<void> fetchStreak() async {
    int streakValue = await UserDataFetcher().fetchStreak();
    setState(() {
      streak = streakValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    fetchStreak();
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Center(
          child: SizedBox(
            height: 130,
            width: 100,
            child: ImageImport(width: 100, height: 130).importProfileIcon(),
          ),
        ),
        Positioned(
          top: 5,
          left: 185,
          child: Icon(
            Icons.circle,
            color: Color(0x804EABCC),
            size: 50.0,
          ),
        ),
        Positioned(
          top: 10,
          left: 200,
          child: Text(
            streak.toString(),
            style: TextStyle(
              fontSize: 30.0,
              color: Colors.red,
            ),
          ),
        ),
      ],
    );
  }
}
