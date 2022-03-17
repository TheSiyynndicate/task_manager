import 'package:flutter/material.dart';
import 'package:task_manager/constants/app_colors.dart';
import 'package:task_manager/screens/home_screen.dart';
import 'package:task_manager/screens/profile_screen.dart';


class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  //
  int? _selectedIndex = 0;

  //
 List<Widget>? _screenOptions = const [HomeScreen(),ProfileScreen()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.oldLace,
      bottomNavigationBar:bottomNavBar(),
      body: _screenOptions!.elementAt(_selectedIndex!),
    );
  }


  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }





  Widget bottomNavBar(){
    ///will contain all of the screens
    List<BottomNavigationBarItem>? items = [];
    //Default screen
    BottomNavigationBarItem? home =    const BottomNavigationBarItem(
      icon:  Icon(Icons.home),
      label: 'Home',
      backgroundColor: AppColors.greenPantone,
    );
    //Profile screen
    BottomNavigationBarItem? profile =  const BottomNavigationBarItem(
      icon:  Icon(Icons.account_box_sharp),
      label: 'Profile',
      backgroundColor: AppColors.greenPantone,
    );;



    ///Adding them to the list
    items.add(home);
    items.add(profile);


    return BottomNavigationBar(items: items,
      backgroundColor: AppColors.smokyBlack,

      currentIndex: _selectedIndex!,
      selectedItemColor: AppColors.greenPantone,
      onTap: _onItemTapped,
    );
  }
}
