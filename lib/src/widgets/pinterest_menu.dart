import 'package:flutter/material.dart';

class PinterestButton {
  final VoidCallback onPressed;
  final IconData icon;

  const PinterestButton(
    this.onPressed,
    this.icon,
  );
}

class PinterestMenu extends StatelessWidget {
  final List<PinterestButton> items = [
    PinterestButton(() {
      print('Icon pie_chart');
    }, Icons.pie_chart),
    PinterestButton(() {
      print('Icon search');
    }, Icons.search),
    PinterestButton(() {
      print('Icon notifications');
    }, Icons.notifications),
    PinterestButton(() {
      print('Icon supervised');
    }, Icons.supervised_user_circle)
  ];

  PinterestMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: _PinterestMenuBackground(
        child: _MenuItems(menuItems: items),
      ),
    );
  }
}

class _PinterestMenuBackground extends StatelessWidget {
  final Widget child;

  const _PinterestMenuBackground({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      height: 60,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(100),
        boxShadow: const [
          BoxShadow(
            color: Colors.black38,
            // offset: Offset(10, 10),
            blurRadius: 10,
            spreadRadius: -5,
          )
        ],
      ),
      child: child,
    );
  }
}

class _MenuItems extends StatelessWidget {
  final List<PinterestButton> menuItems;

  const _MenuItems({
    Key? key,
    required this.menuItems,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(
        menuItems.length,
        (index) => _PinterestMenuButton(
          index: index,
          item: menuItems[index],
        ),
      ),
    );
  }
}

class _PinterestMenuButton extends StatelessWidget {
  final int index;
  final PinterestButton item;

  const _PinterestMenuButton({
    Key? key,
    required this.index,
    required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: item.onPressed,
      behavior: HitTestBehavior.translucent,
      child: Container(
        child: Icon(
          item.icon,
          size: 25,
          color: Colors.blueGrey,
        ),
      ),
    );
  }
}
