import 'package:chronicles/utilities/data/user_auth_data.dart';
import 'package:chronicles/utilities/image_import/logo_import.dart';
import 'package:flutter/material.dart';
import 'package:chronicles/services/streak_services.dart';

class ProfileAvatar extends StatefulWidget {
  const ProfileAvatar({super.key});

  @override
  State<ProfileAvatar> createState() => _ProfileAvatarState();
}

class _ProfileAvatarState extends State<ProfileAvatar> {
  int currentStreak = 0;
  int maxStreak = 0;

  @override
  void initState() {
    fetchStreak();
    super.initState();
  }

  Future<void> fetchStreak() async {
    int streakValueFromUserData = await UserDataFetcher().fetchStreak();
    int maxStreakValueFromUserData = await UserDataFetcher().fetchMaxStreak();

    int calculatedMaxStreak =
        await StreakDatabaseService.instance.calculateMaxStreak();
    int calculatedCurrentStreak =
        await StreakDatabaseService.instance.calculateCurrentStreak();

    setState(() {
      currentStreak = calculatedCurrentStreak > streakValueFromUserData
          ? calculatedCurrentStreak
          : streakValueFromUserData;

      maxStreak = calculatedMaxStreak > maxStreakValueFromUserData
          ? calculatedMaxStreak
          : maxStreakValueFromUserData;
    });
  }

  @override
  Widget build(BuildContext context) {
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
            currentStreak.toString(),
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
