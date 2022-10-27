import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PinterestButton {
  final VoidCallback onPressed;
  final IconData icon;

  const PinterestButton(
    this.onPressed,
    this.icon,
  );
}

class PinterestMenu extends StatelessWidget {
  final bool mostrar;

  final Color backgroundColor;
  final Color activeColor;
  final Color inactiveColor;

  final List<PinterestButton> items;

  // final List<PinterestButton> items = [
  //   PinterestButton(() {}, Icons.pie_chart),
  //   PinterestButton(() {}, Icons.search),
  //   PinterestButton(() {}, Icons.notifications),
  //   PinterestButton(() {}, Icons.supervised_user_circle)
  // ];

  const PinterestMenu({
    Key? key,
    this.mostrar = true,
    this.backgroundColor = Colors.white,
    this.activeColor = Colors.black,
    this.inactiveColor = Colors.blueGrey,
    required this.items,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => _MenuModel(),
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 250),
        opacity: (mostrar) ? 1 : 0,
        child: Builder(builder: (context) {
          Provider.of<_MenuModel>(context).backgroundColor = backgroundColor;
          Provider.of<_MenuModel>(context).activeColor = activeColor;
          Provider.of<_MenuModel>(context).inactiveColor = inactiveColor;

          return _PinterestMenuBackground(
            child: _MenuItems(menuItems: items),
          );
        }),
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
    Color backgroundColor = Provider.of<_MenuModel>(context).backgroundColor;

    return Container(
      width: 250,
      height: 60,
      decoration: BoxDecoration(
        color: backgroundColor,
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
    final itemSeleccionado = Provider.of<_MenuModel>(context).itemSeleccionado;
    Color activeColor = Provider.of<_MenuModel>(context).activeColor;
    Color inactiveColor = Provider.of<_MenuModel>(context).inactiveColor;

    return GestureDetector(
      onTap: () {
        Provider.of<_MenuModel>(context, listen: false).itemSeleccionado =
            index;
        item.onPressed;
      },
      behavior: HitTestBehavior.translucent,
      child: Container(
        child: Icon(
          item.icon,
          size: (itemSeleccionado == index) ? 35 : 25,
          color: (itemSeleccionado == index) ? activeColor : inactiveColor,
        ),
      ),
    );
  }
}

class _MenuModel with ChangeNotifier {
  int _itemSeleccionado = 0;

  Color backgroundColor = Colors.white;
  Color activeColor = Colors.black;
  Color inactiveColor = Colors.blueGrey;

  int get itemSeleccionado => _itemSeleccionado;

  set itemSeleccionado(int index) {
    _itemSeleccionado = index;
    notifyListeners();
  }
}
