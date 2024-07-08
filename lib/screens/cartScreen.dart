import 'package:flutter/material.dart';
import 'package:fjeje_timbu/model/messageRes.dart';
import 'package:fjeje_timbu/screens/checkoutScreen.dart';
import 'package:fjeje_timbu/apis/models/listOfProductItem.dart';

class CartPage extends StatefulWidget {
  const CartPage(
      {super.key,
      required List<Item> cart,
      required void Function(Item product) removeFromCart});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      cart.runtimeType;
    });
    print('object');
  }

  void removeFromCart(Item product) {
    cart.remove(product);
    print('${product.name} removed from cart');
  }

  void checkout() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CheckoutSuccessPage()),
    );
    setState(() {
      cart.clear();
    });

    success(context: context, message: 'Cart cleared.');
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    String totalPrice = cart.fold('0', (previousValue, product) {
      return (double.parse(previousValue) + product.currentPrice![0].ngn[0])
          .toString();
    });
    return Scaffold(
        appBar: AppBar(
          title: const Text('Cart'),
          backgroundColor: const Color.fromARGB(255, 243, 235, 235),
        ),
        backgroundColor: const Color.fromARGB(255, 243, 235, 235),
        body: SingleChildScrollView(
          child: cart.isNotEmpty
              ? Column(
                  children: [
                    const Text(
                      "Products in Your cart",
                      style: TextStyle(fontSize: 20),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: cart.length,
                      physics: const NeverScrollableScrollPhysics(
                          parent: AlwaysScrollableScrollPhysics()),
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: Image.network(
                              'https://api.timbu.cloud/images/${cart[index].photos[index = 0].url}'),
                          title: Text('${cart[index].name}'),
                          subtitle: Text(
                              '\N${cart[index].currentPrice![index = 0].ngn[index = 0].toString()}'),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              success(
                                  context: context,
                                  message:
                                      '${cart[index].name} removed from cart');
                              setState(() {
                                removeFromCart(cart[index]);
                              });
                            },
                          ),
                        );
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        'Total Price: \₦$totalPrice',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 50,
                      height: 50,
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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(7))),
                          child: Center(
                            child: Text("checkout".toUpperCase(),
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w800)),
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
                      child: Text('0 Items in Your Cart'),
                    ),
                  ],
                ),
        ));
  }
}
