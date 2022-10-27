import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:pinterest_grid_clone/src/widgets/pinterest_menu.dart';

class PinterestPage extends StatelessWidget {
  const PinterestPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => _MenuModel(),
      child: Scaffold(
        // body: PinterestMenu(),
        // body: PinterestGrid(),
        body: Stack(
          children: const [
            PinterestGrid(),
            _PinterestMenuLocation(),
          ],
        ),
      ),
    );
  }
}

class _PinterestMenuLocation extends StatelessWidget {
  const _PinterestMenuLocation({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final widthPantalla = MediaQuery.of(context).size.width;
    final mostrar = Provider.of<_MenuModel>(context).mostrar;

    return Positioned(
      bottom: 30,
      child: SizedBox(
        width: widthPantalla,
        child: Align(
          alignment: Alignment.center,
          child: PinterestMenu(
            mostrar: mostrar,
            backgroundColor: Colors.white70,
            activeColor: Colors.black,
            inactiveColor: Colors.blueGrey,
            items: [
              PinterestButton(() {}, Icons.pie_chart),
              PinterestButton(() {}, Icons.search),
              PinterestButton(() {}, Icons.notifications),
              PinterestButton(() {}, Icons.supervised_user_circle),
            ],
          ),
        ),
      ),
    );
  }
}

class PinterestGrid extends StatefulWidget {
  // final List<int> items = List.generate(20, (i) => i);

  const PinterestGrid({Key? key}) : super(key: key);

  @override
  State<PinterestGrid> createState() => _PinterestGridState();
}

class _PinterestGridState extends State<PinterestGrid> {
  ScrollController controller = ScrollController();
  double scrollAnterior = 0;

  @override
  void initState() {
    controller.addListener(() {
      // print('scroll_listener: ${controller.offset}');
      if (controller.offset > scrollAnterior && controller.offset > 150) {
        Provider.of<_MenuModel>(context, listen: false).mostrar = false;
      } else {
        Provider.of<_MenuModel>(context, listen: false).mostrar = true;
      }

      scrollAnterior = controller.offset;
    });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: controller,
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.only(top: 25, left: 6, right: 6),
      child: StaggeredGrid.count(
        crossAxisCount: 4,
        crossAxisSpacing: 6.0,
        mainAxisSpacing: 6.0,
        children: List.generate(
          30,
          (index) => _PinterestItem(i: index, index),
        ),
      ),
    );
  }
}

class _PinterestItem extends StatelessWidget {
  final int i;

  const _PinterestItem(
    int index, {
    Key? key,
    required this.i,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StaggeredGridTile.count(
      crossAxisCellCount: 2,
      mainAxisCellCount: i.isEven ? 2 : 3,
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: Colors.blue,
        ),
        child: Center(
          child: CircleAvatar(
            backgroundColor: Colors.white,
            child: Text('$i'),
          ),
        ),
      ),
    );
  }
}

class _MenuModel with ChangeNotifier {
  bool _mostrar = true;

  bool get mostrar => _mostrar;

  set mostrar(bool valor) {
    _mostrar = valor;
    notifyListeners();
  }
}
