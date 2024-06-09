
import 'package:ecommerce_app/pages/cart_page.dart';
import 'package:ecommerce_app/widgets/product_list.dart';
import 'package:flutter/material.dart';
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentPage = 0;

  @override
  void initState(){
    super.initState();
  }

  List<Widget> pages = const [ProductList(), CartPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:IndexedStack(index: currentPage,children: pages,),
      bottomNavigationBar: BottomNavigationBar(
        selectedFontSize: 0,
        unselectedFontSize: 0,
        iconSize: 30,
        onTap: (value) {
          setState(() {
            currentPage = value;
          });
        },
        items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: ''),
        BottomNavigationBarItem(icon: Icon(Icons.shopping_cart_checkout), label: '', ),
      ],
      currentIndex: currentPage,),
    );
  }
}