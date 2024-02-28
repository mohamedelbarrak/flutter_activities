import 'package:animated_segmented_tab_control/animated_segmented_tab_control.dart';
import 'package:flutter/material.dart';

import '../../../utils/constant.dart';
import 'activities_screen.dart';

class ActivitiesMainScreen extends StatelessWidget {
  const ActivitiesMainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.bodyLarge;
    final selectedTextStyle = textStyle?.copyWith(
        fontWeight: FontWeight.bold,
        color: Colors.black,
        fontSize: 18,
        fontFamily: popinsFont);
    return SafeArea(
        child: Scaffold(
            // appBar: AppBar(
            //   automaticallyImplyLeading: false,
            //   centerTitle: true,
            //   title: const Text("MIAGED",
            //     textAlign: TextAlign.center,
            //     style: TextStyle(fontFamily: popinsFont,fontWeight: FontWeight.w700,fontSize: 18),),
            //   backgroundColor: mainPrimaryColor,
            //
            // ),
            body: DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: false,
          backgroundColor: mainPrimaryColor,
          bottom: const TabBar(
            labelStyle: TextStyle(fontSize: 17, fontWeight: FontWeight.bold), // Styling the tab bar titles
            unselectedLabelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: Colors.grey), // Styling for unselected tabs
            isScrollable: true, // Set isScrollable to true

            tabs: [
              Tab(text: "All",),

              Tab(text: "Sport",),
              Tab(text: "Shopping",),
              Tab(text: "Recreational",),
            ],
          ),
          title: const Text('MIAGED'),
        ),
        body: TabBarView(
          children: [
            ActivitiesScreen(
              category: "All",
            ),
            ActivitiesScreen(
              category: "Sport",
            ),
            ActivitiesScreen(
              category: "Shopping",
            ),
            ActivitiesScreen(
              category: "Recreational",
            ),
          ],
        ),
      ),

      // DefaultTabController(
      //   length: 3,
      //   child: Scaffold(
      //     body: SafeArea(
      //       child: Stack(
      //         children: [
      //           Padding(
      //             padding: const EdgeInsets.all(16.0),
      //             child: SegmentedTabControl(
      //               // Customization of widget
      //               radius: const Radius.circular(10),
      //               backgroundColor: Colors.grey.shade300,
      //               indicatorColor: mainPrimaryColor,
      //               tabTextColor: Colors.white,
      //               selectedTabTextColor: Colors.black,
      //               squeezeIntensity: 2,
      //               height: 45,
      //               tabPadding: const EdgeInsets.symmetric(horizontal: 8),
      //               textStyle: textStyle,
      //               selectedTextStyle: selectedTextStyle,
      //               // Options for selection
      //               // All specified values will override the [SegmentedTabControl] setting
      //               tabs: const [
      //                 SegmentTab(
      //                   label: 'Sport',
      //                   // For example, this overrides [indicatorColor] from [SegmentedTabControl]
      //                   selectedTextColor: Colors.white,
      //                   textColor: Colors.black26,
      //                 ),
      //                 SegmentTab(
      //                   label: 'Shopping',
      //                   selectedTextColor: Colors.white,
      //                   textColor: Colors.black26,
      //                 ),
      //                 SegmentTab(
      //                   label: 'Recreational',
      //                   selectedTextColor: Colors.white,
      //                   textColor: Colors.black26,
      //                 ),
      //               ],
      //             ),
      //           ),
      //           // Sample pages
      //           Padding(
      //             padding: const EdgeInsets.only(top: 70),
      //             child: TabBarView(
      //               physics: const BouncingScrollPhysics(),
      //               children: [
      //                 ActivitiesScreen(
      //                   category: "Sport",
      //                 ),
      //                 ActivitiesScreen(
      //                   category: "Shopping",
      //                 ),
      //                 ActivitiesScreen(
      //                   category: "Recreational",
      //                 ),
      //               ],
      //             ),
      //           ),
      //         ],
      //       ),
      //     ),
      //   ),
    )));
  }
}
