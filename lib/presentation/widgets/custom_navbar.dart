import 'package:flutter/material.dart';

class CustomNavbar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const CustomNavbar({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      notchMargin: 8,
      color: Colors.white,
      child: SizedBox(
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(
                Icons.home_outlined,
                color: selectedIndex == 0 ? Colors.brown : Colors.brown[200],
              ),
              onPressed: () => onItemTapped(0),
            ),
            const SizedBox(width: 40), // ruang FAB
            IconButton(
              icon: Icon(
                Icons.person_outline,
                color: selectedIndex == 1 ? Colors.brown : Colors.brown[200],
              ),
              onPressed: () => onItemTapped(1),
            ),
          ],
        ),
      ),
    );
  }
}
