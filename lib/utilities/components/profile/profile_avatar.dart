import 'dart:io';
import 'package:chronicles/services/pfp_services.dart';
import 'package:chronicles/utilities/data/user_auth_data.dart';
import 'package:flutter/material.dart';
import 'package:chronicles/services/streak_services.dart';

final double circleAvatarRadius = 25.0;
final double circlePositionTop = 0.0;
final double circlePositionRight = 0.0;
final double circleIconSize = 20.0;
final double streakPositionTop = 3.0;
final double streakPositionRight = 7.0;
final double streakNumberSize = 10.0;

class ProfileAvatar extends StatefulWidget {
  const ProfileAvatar({super.key});

  @override
  State<ProfileAvatar> createState() => _ProfileAvatarState();
}

class _ProfileAvatarState extends State<ProfileAvatar> {
  int currentStreak = 0;
  int maxStreak = 0;
  File? profileImage;

  @override
  void initState() {
    fetchStreak();
    pfpDisplay();
    super.initState();
  }

  Future<void> pfpDisplay() async {
    String? imagePath = await getSavedImagePath();
    setState(() {
      if (imagePath != null) {
        profileImage = File(imagePath);
      }
    });
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
          child: CircleAvatar(
            radius: circleAvatarRadius,
            backgroundColor: Colors.transparent,
            backgroundImage: profileImage != null
                ? FileImage(profileImage!)
                : AssetImage('assets/images/icons/new_profile_icon.png')
                    as ImageProvider,
          ),
        ),
        Positioned(
          top: circlePositionTop,
          right: circlePositionRight,
          child: Icon(
            Icons.circle,
            color: Color(0xFF4EABCC),
            size: circleIconSize,
          ),
        ),
        Positioned(
          top: streakPositionTop,
          right: streakPositionRight,
          child: Text(
            currentStreak.toString(),
            style: TextStyle(
              fontSize: streakNumberSize,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
