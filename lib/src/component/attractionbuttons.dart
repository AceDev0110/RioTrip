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
        children: [
          Expanded(
            child: SizedBox(
              height: 50, // Ensure height consistency
              child: ElevatedButton.icon(
                label: Text('Map'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: currentRoute == '/attractions/map'
                      ? Colors.orange
                      : Color.fromARGB(255, 197, 197, 197),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(2), // Set border radius to 2
                  ),
                ),
                onPressed: () {
                  GoRouter.of(context).go('/attractions/map');
                },
              ),
            ),
          ),
          SizedBox(width: 10), // Reduce the gap between buttons
          Expanded(
            child: SizedBox(
              height: 50, // Ensure height consistency
              child: ElevatedButton.icon(
                label: Text('List'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: currentRoute == '/attractions/list'
                      ? Colors.orange
                      : Color.fromARGB(255, 197, 197, 197),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(2), // Set border radius to 2
                  ),
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
