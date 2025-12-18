import 'package:flutter/material.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget sidebar;
  final Widget content;
  final Widget? drawer; // Optional drawer for mobile

  const ResponsiveLayout({
    Key? key,
    required this.sidebar,
    required this.content,
    this.drawer,
  }) : super(key: key);

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 800;

  @override
  Widget build(BuildContext context) {
    if (isDesktop(context)) {
      return Scaffold(
        body: Row(
          children: [
            SizedBox(
              width: 280, // Fixed sidebar width
              child: sidebar,
            ),
            Expanded(child: content),
          ],
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: Builder(
            builder: (context) => IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () => Scaffold.of(context).openDrawer(),
            ),
          ),
        ),
        drawer: drawer ?? Drawer(child: sidebar),
        body: content,
      );
    }
  }
}
