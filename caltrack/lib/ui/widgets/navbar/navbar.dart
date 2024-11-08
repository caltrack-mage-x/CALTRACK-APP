import 'package:flutter/material.dart';

class NavBar extends StatefulWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // Define colors for each tab
  final List<Color> _tabColors = [
    Color(0xFFFF6136), // Orange for Home
    Colors.grey,       // Grey for Exercise
    Colors.blueGrey,   // Blue-grey for Challenge
    Colors.blue,       // Blue for Leaderboard
    Colors.purple,     // Purple for Article
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Top line with dynamic color based on selected tab
        Container(
          width: double.infinity,
          height: 2, // Small height for a thin line
          color: _tabColors[_selectedIndex], // Color changes based on selected index
        ),
        BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          selectedItemColor: Color(0xFFFF6136), // Active color (orange)
          unselectedItemColor: Colors.grey, // Inactive color
          showUnselectedLabels: true,
          iconSize: 28, // Adjust the icon size if necessary
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.fitness_center),
              label: 'Exercise',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.adjust), // Use adjust icon for Challenge
              label: 'Challenge',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.leaderboard),
              label: 'Leaderboard',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.article),
              label: 'Article',
            ),
          ],
        ),
      ],
    );
  }
}
