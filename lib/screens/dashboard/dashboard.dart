import 'package:chronicles/utilities/components/calender/streak_calender.dart';
import 'package:chronicles/screens/todo/todo_top_three.dart';
import 'package:chronicles/utilities/image_import/logo_import.dart';
import 'package:flutter/material.dart';
import 'package:chronicles/screens/todo/todo_screen.dart';
import 'package:chronicles/utilities/components/searchbar/boxSearchBar.dart';
import 'package:chronicles/utilities/components/text_editor/chronicles_text_editor.dart';
import 'package:chronicles/utilities/components/profile/fetch_username.dart';
import 'package:chronicles/utilities/components/text_editor/top_2_recent_diaries.dart';
import 'package:chronicles/screens/profile/profile_screen.dart';
import 'package:chronicles/screens/shared_diaries/view_shared_diaries.dart';
import 'package:chronicles/utilities/components/buttons/custom_floatingbutton.dart';

final helloMsgStyle = TextStyle(
  height: 1.8,
  fontSize: 32.0,
  fontFamily: 'Abyssinica_SIL',
  fontWeight: FontWeight.w500,
  color: Color(0xFF1F1F1F),
);

final usernameStyle = TextStyle(
  height: 1.8,
  fontSize: 32.0,
  fontFamily: 'Abyssinica_SIL',
  fontWeight: FontWeight.w500,
  color: Color(0xFF4EABCC),
);

final hintTextStyle = TextStyle(
  fontSize: 16.0,
  fontFamily: 'Hind',
  fontWeight: FontWeight.w400,
  color: Color(0xFF1F1F1F),
);

final headingTextStyle = TextStyle(
  fontSize: 24.0,
  fontFamily: 'Hind',
  fontWeight: FontWeight.w500,
  color: Color(0xFF1F1F1F),
);

final taskListTextStyle = TextStyle(
  fontSize: 16.0,
  fontFamily: 'Hind',
  fontWeight: FontWeight.w500,
  color: Color(0xFF1F1F1F),
);

final taskTitleTextField = TextStyle(
  fontSize: 24.0,
  fontWeight: FontWeight.w500,
  fontFamily: 'Hind',
  color: Color(0xFF1F1F1F),
);

class Dashboard extends StatefulWidget {
  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  String username = "Loading...";
  void initState() {
    super.initState();

    UserService.getUsername().then((fetchedUsername) {
      setState(() {
        username = fetchedUsername;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Container(
        height: 55,
        width: 220,
        margin: EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
            color: Color(0xFFFFFFFF),
            borderRadius: BorderRadius.circular(50),
            boxShadow: [
              BoxShadow(
                color: Color.fromARGB(76, 0, 0, 0),
                offset: const Offset(0, 5),
                blurRadius: 15,
                spreadRadius: 0,
              ),
            ]),
        child: Row(
          children: [
            NavigateFloatingButton(
              buttonPadding: EdgeInsets.fromLTRB(9.5, 6, 5, 6),
              buttonIcon: Icons.home,
              buttonIconColor: Color(0xFF4EABCC),
              buttonBackgroundColor: Color(0xFFE0F2FC),
              buttonHeroTag: 'home_button',
              isDisabled: true,
            ),
            NavigateFloatingButton(
              buttonPadding: EdgeInsets.fromLTRB(0, 6, 5, 6),
              buttonIcon: Icons.create_outlined,
              buttonIconColor: Color(0xFF797C7D),
              buttonBackgroundColor: Color(0xFFFFFFFF),
              buttonHeroTag: 'create_button',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TextEditor(
                      isModify: false,
                    ),
                  ),
                );
              },
            ),
            NavigateFloatingButton(
              buttonPadding: EdgeInsets.fromLTRB(0, 6, 9.5, 6),
              buttonIcon: Icons.person,
              buttonIconColor: Color(0xFF797C7D),
              buttonBackgroundColor: Color(0xFFFFFFFF),
              buttonHeroTag: 'user_button',
              onPressed: () {
                Navigator.of(context).push(
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        ViewSharedDiaries(),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      return child;
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterFloat,
      appBar: AppBar(
        backgroundColor: Color(0xFFFFFFFF),
        scrolledUnderElevation: 0.5,
        title: Padding(
          padding: EdgeInsets.only(top: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Hello,",
                    style: helloMsgStyle,
                  ),
                  Text(
                    username,
                    style: usernameStyle,
                  ),
                ],
              ),
              GestureDetector(
                onTap: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProfileScreen(),
                    ),
                  );
                },
                child: ImageImport(width: 56, height: 56).importProfileIcon(),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 5, bottom: 20, left: 15, right: 15),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 20.0, left: 5, right: 5),
                child: BoxSearchBar(),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 6.0),
                padding: EdgeInsets.only(top: 30.0, bottom: 20.0),
                child: Container(
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: Color(0xFFFFFFFF),
                    border: Border.all(
                      color: Color(0x40000000),
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                  child: StreakCalender(),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Task',
                    style: taskTitleTextField,
                  ),
                  IconButton(
                    constraints: BoxConstraints(maxHeight: 36),
                    color: Color(0xFFFFFFFF),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ToDoScreen(),
                        ),
                      );
                      setState(() {});
                    },
                    icon: Icon(Icons.add_rounded, size: 24.0),
                    style: IconButton.styleFrom(
                      backgroundColor: Color(0xFF4EABCC),
                      padding: EdgeInsets.all(0.0),
                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 6.0),
                padding: EdgeInsets.fromLTRB(10.0, 10.0, 20.0, 10.0),
                decoration: BoxDecoration(
                  color: Color(0xFFFFFFFF),
                  border: Border.all(
                    color: Color(0x40000000),
                    width: 2.0,
                  ),
                  borderRadius: BorderRadius.circular(6.0),
                ),
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxHeight: 200.0),
                  child: Top3ToDoList(),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Recent',
                      style: taskTitleTextField,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/AllDiary');
                    },
                    icon: Icon(
                      Icons.more_horiz_sharp,
                      color: Color(0xFF4EABCC),
                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 6.0),
                padding: EdgeInsets.fromLTRB(10.0, 20.0, 20.0, 10.0),
                decoration: BoxDecoration(
                  color: Color(0xFFFFFFFF),
                  border: Border.all(
                    color: Color(0x40000000),
                    width: 2.0,
                  ),
                  borderRadius: BorderRadius.circular(6.0),
                ),
                child: SizedBox(
                  height: 190.0,
                  width: double.infinity,
                  child: Top2RecentDiaries(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
