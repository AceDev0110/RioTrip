import 'package:RioTrip/src/component/customAppBar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RiostoreScaffold extends StatefulWidget {
  final Widget child;
  final int selectedIndex;

  const RiostoreScaffold({
    required this.child,
    required this.selectedIndex,
    super.key,
  });

  @override
  _RiostoreScaffoldState createState() => _RiostoreScaffoldState();
}

class _RiostoreScaffoldState extends State<RiostoreScaffold> {
  void _onItemTapped(int index) {
    final goRouter = GoRouter.of(context);
    switch (index) {
      case 0:
        goRouter.go('/attractions/map');
        break;
      case 1:
        goRouter.go('/alphabet');
        break;
      case 2:
        goRouter.go('/phrasebook');
        break;
      case 3:
        goRouter.go('/converter');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: widget.child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: widget.selectedIndex,
        backgroundColor: const Color(0xFF012147), // Set the background color
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.white, // Color for selected items
        unselectedItemColor: Colors.grey, // Color for unselected items
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage('assets/category/attractions.png')),
            label: 'Attractions',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage('assets/category/alphabet.png')),
            label: 'Alphabet',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage('assets/category/phrasebook.png')),
            label: 'Phrasebook',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage('assets/category/converter.png')),
            label: 'Converter',
          ),
        ],
      ),
    );
  }
}
