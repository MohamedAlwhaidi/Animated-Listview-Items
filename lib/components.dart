import 'package:flutter/material.dart';

/// This holds the items
final List<String> _fetchedItems = ['A', 'B', 'C', 'D'];
final List<String> _items = [];

class Components extends StatefulWidget {
  const Components({Key? key}) : super(key: key);

  @override
  State<Components> createState() => _ComponentsState();
}

class _ComponentsState extends State<Components> {
  GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();

  Future<void> _loadItems() async {
    for (String item in _fetchedItems) {
      // 1) Wait for 0.1 second
      await Future.delayed(const Duration(milliseconds: 100));
      // 2) Adding data to actual variable that holds the item.
      _items.add(item);
      // 3) Telling animated list to start animation
      listKey.currentState?.insertItem(_items.length - 1,
          duration: const Duration(milliseconds: 1000));
    }
  }

  @override
  void initState() {
    super.initState();
    _loadItems();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedList(
      key: listKey,
      initialItemCount: _items.length,
      itemBuilder: (context, index, animation) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(-1, 0),
            end: const Offset(0, 0),
          ).animate(
            CurvedAnimation(
              parent: animation,
              curve: Curves.fastOutSlowIn,
              reverseCurve: Curves.fastOutSlowIn,
            ),
          ),
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            color: Colors.amber,
            height: 50,
            // width: double.infinity,
            child: Center(
              child: Text(
                _fetchedItems[index],
              ),
            ),
          ),
        );
      },
    );
  }
}
