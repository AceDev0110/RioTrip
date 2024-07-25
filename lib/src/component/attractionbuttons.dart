import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AttractionButtons extends StatelessWidget {
  const AttractionButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String currentRoute = GoRouter.of(context).routerDelegate.currentConfiguration.fullPath; 

    return Positioned(
      bottom: 20,
      left: 20,
      right: 20,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            flex: 1,
            child: SizedBox(
              height: 50, // Ensure height consistency
              child: ElevatedButton.icon(
                icon: Icon(Icons.map),
                label: Text('Map'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: currentRoute == '/attractions/map'
                      ? Colors.orange
                      : Color.fromARGB(255, 126, 126, 126),
                ),
                onPressed: () {
                  GoRouter.of(context).go('/attractions/map');
                },
              ),
            ),
          ),
          SizedBox(width: 20), // Add gap between buttons
          Flexible(
            flex: 1,
            child: SizedBox(
              height: 50, // Ensure height consistency
              child: ElevatedButton.icon(
                icon: Icon(Icons.list),
                label: Text('List'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: currentRoute == '/attractions/list'
                      ? Colors.yellow
                      : Colors.white,
                ),
                onPressed: () {
                  GoRouter.of(context).go('/attractions/list');
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
