import 'package:flutter/material.dart';

final double overAllPadding = 10.0;

final double borderTopRadius = 16.0;

final Color keyBoardColor = Color(0x804EABCC);

final keyBoardNumberTextStyle = TextStyle(
  fontSize: 28.0,
  fontFamily: "Hind",
  fontWeight: FontWeight.w700,
  color: Color(0xFF2C3339),
);

class CustomNumericKeyboard extends StatelessWidget {
  final Function(String) onKeyTap;

  CustomNumericKeyboard({required this.onKeyTap});

  final List<String> keys = [
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
    "7",
    "8",
    "9",
    "C",
    "0",
    "✔"
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(overAllPadding),
      decoration: BoxDecoration(
        color: keyBoardColor,
        borderRadius:
            BorderRadius.vertical(top: Radius.circular(borderTopRadius)),
      ),
      child: GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 1.4,
        ),
        itemCount: keys.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => onKeyTap(keys[index]),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.transparent,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(keys[index], style: keyBoardNumberTextStyle),
              ),
            ),
          );
        },
      ),
    );
  }
}
