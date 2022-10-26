import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:pinterest_grid_clone/src/widgets/pinterest_menu.dart';

class PinterestPage extends StatelessWidget {
  const PinterestPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PinterestMenu(),
      // body: PinterestGrid(),
    );
  }
}

class PinterestGrid extends StatelessWidget {
  // final List<int> items = List.generate(20, (i) => i);

  const PinterestGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.only(top: 25, left: 4, right: 4),
      child: StaggeredGrid.count(
        crossAxisCount: 4,
        crossAxisSpacing: 4.0,
        children: List.generate(
          20,
          (index) => _PinterestItem(i: index, index),
        ),
        mainAxisSpacing: 4.0,
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
