import 'package:chronicles/utilities/components/calender/streak_calender.dart';
import 'package:chronicles/utilities/image_import/logo_import.dart';
import 'package:flutter/material.dart';

final String username = "trOlsz";

final bool task1 = true;
final bool task2 = false;

final helloMsgStyle = TextStyle(
  height: 1.8,
  fontSize: 30.0,
  fontFamily: 'Abyssinica_SIL',
  fontWeight: FontWeight.w400,
  color: Color(0xFF1F1F1F),
);

final usernameStyle = TextStyle(
  height: 1.8,
  fontSize: 30.0,
  fontFamily: 'Abyssinica_SIL',
  fontWeight: FontWeight.w400,
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

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          backgroundColor: Color(0xFF4EABCC),
          child: Icon(
            Icons.add,
            color: Color(0xFFFFFFFF),
          ),
          onPressed: () {}),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      bottomNavigationBar: BottomAppBar(
        color: Color(0xFFD7EFF6),
        height: 62.0,
      ),
      appBar: AppBar(
        backgroundColor: Color(0xFFFFFFFF),
        scrolledUnderElevation: 0.5,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Hello,",
                  style: helloMsgStyle,
                ),
                Text(username, style: usernameStyle),
              ],
            ),
            ImageImport(width: 54, height: 54).importProfileIcon(),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 5, left: 15, right: 15, bottom: 20),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 20.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(2),
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.2),
                        blurRadius: 5,
                        spreadRadius: 2,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Search",
                      hintStyle: hintTextStyle,
                      icon: Padding(
                        padding: EdgeInsets.only(left: 11.0),
                        child: Icon(Icons.search),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 2),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10.0),
                padding: EdgeInsets.only(top: 30.0, bottom: 20.0),
                child: Container(
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                  child: StreakCalender(),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Task",
                      style: headingTextStyle,
                    ),
                    ImageImport(width: 22, height: 22).importAddIcon(),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 12.0),
                child: Container(
                  height: 120,
                  width: 360,
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Checkbox(
                              value: task1,
                              onChanged: (value) {},
                            ),
                            Text(
                              "Complete Presentation",
                              style: taskListTextStyle,
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Checkbox(
                              value: task2,
                              onChanged: (value) {},
                            ),
                            Text(
                              "Book Tickets",
                              style: taskListTextStyle,
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Recent",
                  style: headingTextStyle,
                ),
              ),
              Container(
                height: 180,
                width: 360,
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            height: 160,
                            width: 150,
                            decoration: BoxDecoration(
                              color: Color(0x304EABCC),
                              border: Border.all(
                                color: Colors.transparent,
                              ),
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                          Container(
                            height: 160,
                            width: 150,
                            decoration: BoxDecoration(
                              color: Color(0x304EABCC),
                              border: Border.all(
                                color: Colors.transparent,
                              ),
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
