import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../../constants/constants.dart';

Widget bottomNavWidget(Function changePageIndex) {
  return Container(
    margin: EdgeInsets.all(15),
    decoration: BoxDecoration(
      color: buttonColor2,
      borderRadius: BorderRadius.circular(15),
    ),
    child: Padding(
      padding: const EdgeInsets.all(15.0),
      child: GNav(
          onTabChange: (value) {
            changePageIndex(value);
          },
          rippleColor:
              Colors.grey.shade800, // tab button ripple color when pressed
          hoverColor: Colors.grey.shade700, // tab button hover color
          // haptic: true, // haptic feedback
          // tabBorderRadius: 15,
          // tabActiveBorder: Border.all(
          //     color: Colors.black, width: 1), // tab button border
          // tabBorder:
          //     Border.all(color: Colors.grey, width: 1), // tab button border
          // tabShadow: [
          //   BoxShadow(color: Colors.grey.withOpacity(0.5), blurRadius: 8)
          // ], // tab button shadow
          // curve: Curves.easeOutExpo, // tab animation curves
          duration: const Duration(milliseconds: 900), // tab animation duration
          gap: 8, // the tab button gap between icon and text
          color: Colors.grey[800], // unselected icon color
          activeColor: Colors.black, // selected icon and text color
          iconSize: 24, // tab button icon size
          tabBackgroundColor: buttonColor3, // selected tab background color
          padding: const EdgeInsets.symmetric(
              horizontal: 18, vertical: 5), // navigation bar padding
          tabs: const [
            GButton(
              icon: Icons.home,
              text: 'Home',
            ),
            GButton(
              icon: Icons.edit_document,
              text: 'Sign',
            ),
            GButton(
              icon: Icons.picture_as_pdf,
              text: 'Convert',
            ),
            GButton(
              icon: Icons.settings,
              text: 'Settings',
            )
          ]),
    ),
  );
}
