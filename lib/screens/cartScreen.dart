import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:fjeje_timbu/constants/colors.dart';
import 'package:fjeje_timbu/model/messageRes.dart';
import 'package:fjeje_timbu/screens/checkoutScreen.dart';
import 'package:fjeje_timbu/apis/models/listOfProductItem.dart';

class CartPage extends StatefulWidget {
  final List<Item> cart;
  final void Function(Item product) removeFromCart;
  final void Function() updateCart;

  const CartPage({
    super.key,
    required this.cart,
    required this.removeFromCart,
    required this.updateCart,
  });

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final NumberFormat currencyFormat = NumberFormat.currency(symbol: '₦', decimalDigits: 2);

  void checkout() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CheckoutSuccessPage()),
    );
    setState(() {
      widget.cart.clear();
    });

    widget.updateCart(); // Update cart state
    success(context: context, message: 'Cart cleared.');
  }

  void incrementQuantity(Item product) {
    setState(() {
      product.quantity++;
    });
    widget.updateCart(); // Update cart state
  }

  void decrementQuantity(Item product) {
    setState(() {
      if (product.quantity > 1) {
        product.quantity--;
      } else {
        success(context: context, message: '${product.name} removed from cart');
        widget.removeFromCart(product);
      }
    });
    widget.updateCart();
  }

  @override
  Widget build(BuildContext context) {
    double totalPrice = widget.cart.fold(0.00, (previousValue, product) {
      return previousValue +
          (product.currentPrice?[0].ngn[0] * product.quantity);
    });
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your cart'),
        centerTitle: true,
        backgroundColor: colorPrimary,
      ),
      backgroundColor: const Color.fromARGB(255, 243, 235, 235),
      body: SingleChildScrollView(
        child: widget.cart.isNotEmpty
            ? Column(
                children: [
                  const Text(
                    "The Items",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: widget.cart.length,
                    physics: const NeverScrollableScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics()),
                    itemBuilder: (context, index) {
                      Item product = widget.cart[index];
                      return ListTile(
                        leading: Image.network(
                            'https://api.timbu.cloud/images/${product.photos[0].url}'),
                        title: Text('${product.name}'),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                '₦${product.currentPrice?[0].ngn[0].toString()}'),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Quantity: ${product.quantity}'),
                                Row(
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.remove),
                                      onPressed: () {
                                        decrementQuantity(product);
                                      },
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.add),
                                      onPressed: () {
                                        incrementQuantity(product);
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            success(
                                context: context,
                                message: '${product.name} removed from cart');
                            setState(() {
                              widget.removeFromCart(product);
                            });
                            widget.updateCart(); // Update cart state
                          },
                        ),
                      );
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'Total Price: ${currencyFormat.format(totalPrice)}',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 40,
                    height: 40,
                  ),
                  Center(
                    child: InkWell(
                      onTap: () {
                        checkout();
                      },
                      child: Container(
                        width: 220,
                        height: 45,
                        decoration: const BoxDecoration(
                            color: Colors.black,
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.all(Radius.circular(7))),
                        child: Center(
                          child: Text("checkout".toUpperCase(),
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ),
                  )
                ],
              )
            : const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 200,
                  ),
                  Center(
                    child: Text('No Items in Your Cart'),
                  ),
                ],
              ),
      ),
    );
  }
}
