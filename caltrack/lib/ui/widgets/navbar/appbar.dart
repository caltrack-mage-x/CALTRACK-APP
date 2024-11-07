import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onBack;

  const CustomAppBar({Key? key, required this.onBack}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: Row(
          children: const [
            Icon(Icons.arrow_back, color: Colors.grey),
            SizedBox(width: 4),
            Text('Back', style: TextStyle(color: Colors.grey, fontSize: 16)),
          ],
        ),
        onPressed: onBack,
      ),
      leadingWidth: 80, // Adjust width to fit icon and text properly
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56.0);
}
