import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../utils/constant.dart';
import '../Activities/activities_main_screen.dart';
import '../Basket/basket_screen.dart';
import '../ProfileScreen/profile_screen.dart';


class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({Key? key}) : super(key: key);

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  DateTime? _currentBackPressTime;

  final _pageItem = [
    ActivitiesMainScreen(),
    BasketScreen(),
    ProfileScreen()
  ];
  int _selectedItem = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
          DateTime now = DateTime.now();

          if (_currentBackPressTime == null ||
              now.difference(_currentBackPressTime!) >
                  const Duration(seconds: 2)) {
            _currentBackPressTime = now;
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Press back again to exit'),
              ),
            );

            return Future.value(false);
          }
          return Future.value(true);
        },
        child: Scaffold(
          body: _pageItem[_selectedItem],
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            selectedIconTheme:
            IconThemeData(size: 30, opacity: 1, color: mainPrimaryColor),
            unselectedIconTheme: const IconThemeData(size: 28, opacity: 0.5),
            selectedLabelStyle:
            TextStyle(fontSize: 15, color: mainPrimaryColor),
            unselectedLabelStyle: const TextStyle(fontSize: 14),
            showUnselectedLabels: true,
            elevation: 40,
            selectedFontSize: 17,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(FontAwesomeIcons.dollarSign, size: 30),
                activeIcon: Icon(FontAwesomeIcons.dollarSign, size: 30),
                label: "Activities",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.shopping_basket_outlined, size: 30),
                activeIcon: Icon(Icons.shopping_basket, size: 30),
                label: "Cart",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_outline, size: 30),
                activeIcon: Icon(Icons.person, size: 30),
                label: "Profile",
              ),
            ],
            currentIndex: _selectedItem,
            onTap: (setValue) {
              _selectedItem = setValue;
              setState(() {});
            },
          ),
        ));
  }
}
