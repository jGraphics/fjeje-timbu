import 'package:flutter/material.dart';
import 'package:fjeje_timbu/constants/colors.dart';
import 'package:fjeje_timbu/screens/cartScreen.dart';
import 'package:fjeje_timbu/screens/profileScreen.dart';
import 'package:fjeje_timbu/screens/productScreen.dart';
import 'package:fjeje_timbu/apis/models/listOfProductItem.dart';

class BNavWidget extends StatefulWidget {
  const BNavWidget({super.key});

  @override
  State<BNavWidget> createState() => _BNavWidgetState();
}

class _BNavWidgetState extends State<BNavWidget> {
  int _selectedIndex = 0;
  List<Item> cart = []; // Assuming you have an Item class defined elsewhere

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void addToCart(Item product) {
    setState(() {
      cart.add(product);
    });
  }

  void removeFromCart(Item product) {
    setState(() {
      cart.remove(product);
    });
  }

  List<Widget> _widgetOptions() {
    return [
      ProductScreen(
        cart: cart,
        addToCart: addToCart,
      ),
      CartPage(
        cart: cart,
        removeFromCart: removeFromCart,
      ),
      const ProfileScreen(), 
    ];
  }

  @override
  Widget build(BuildContext context) {
    int cartItemCount = cart.length;
    return Scaffold(
      body: Center(
        child: _widgetOptions().elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          const BottomNavigationBarItem(
          icon: Icon(Icons.house_rounded),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Stack(
              children: <Widget>[
                const Icon(Icons.shopping_cart_outlined),
                if (cart.isNotEmpty)
                  Positioned(
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(1),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      constraints: const BoxConstraints(
                        minWidth: 18,
                        minHeight: 18,
                      ),
                      child: Text(
                        '$cartItemCount',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
              ],
            ),
            label: 'Cart',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.person_2_outlined),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: colorPrimary,
        unselectedItemColor: Colors.white,
        onTap: _onItemTapped,
        backgroundColor: Colors.black,
      ),
    );
  }
}
