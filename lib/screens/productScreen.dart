import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fjeje_timbu/apis/timbu_api.dart';
import 'package:fjeje_timbu/model/messageRes.dart';
import 'package:fjeje_timbu/constants/colors.dart';
import 'package:fjeje_timbu/screens/viewProduct.dart';
import 'package:fjeje_timbu/apis/models/listOfProductItem.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen(
      {super.key,
      required List<Item> cart,
      required void Function(Item product) addToCart});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  void initState() {
    super.initState();
    getAllProduct();
  }

  void addTocart(Item productModel) async {
    cart.add(productModel);
    print('${productModel.name} added to cart');
  }

  List<Item> _list = [];

void getAllProduct() {
    final get = Provider.of<TimbuApiProvider>(context, listen: false);
    get.getProduct().then((value) {
      setState(() {
        _list = value.items;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final get = context.watch<TimbuApiProvider>();

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 243, 235, 235),
      appBar: AppBar(
        title: const Text('Jejelove Products - Timbu', 
        style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: colorPrimary,
        elevation: 4.0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
          child: get.loading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Column(
                  children: [
                    GridView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 8,
                        crossAxisSpacing: 8,
                        mainAxisExtent: 350,
                      ),
                      itemCount: _list.length,
                      itemBuilder: (BuildContext context, int index) {
                        var product = _list[index];
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ViewProductPage(
                                  id: product.id,
                                  itemPrice: product
                                      .currentPrice![index = 0]
                                      .ngn[index = 0]
                                      .toString(),
                                ),
                              ),
                            );
                          },
                          onHover: (value) {},
                          child: Card(
                            color: Colors.white.withOpacity(1),
                            child: SizedBox(
                              width: 400,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  top: 5.0,
                                  bottom: 5,
                                  left: 10,
                                  right: 10,
                                ),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      width: 350,
                                      height: 250,
                                      child: Column(
                                        children: [
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          Center(
                                            child: Image.network(
                                              "https://api.timbu.cloud/images/${product.photos[index = 0].url}",
                                              height: 230,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          '₦${product.currentPrice![index = 0].ngn[index = 0].toString()}',
                                          style: const TextStyle(
                                            fontSize: 15,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 3,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Flexible(
                                          child: Text(
                                            "${product.name}",
                                            softWrap: true,
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.black.withOpacity(.5),
                                            ),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            addTocart(product);
                                            success(
                                              context: context,
                                              message: '${product.name} added to cart',
                                            );
                                          },
                                          child: const Center(
                                            child: Icon(
                                              Icons.shopping_bag_outlined,
                                              color: colorPrimary,
                                              size: 24,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
