import 'dart:developer';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart';
import 'package:fjeje_timbu/apis/timbu_api.dart';
import 'package:flutter_lorem/flutter_lorem.dart';
import 'package:fjeje_timbu/constants/colors.dart';
import 'package:fjeje_timbu/model/messageRes.dart';
import 'package:fjeje_timbu/widgets/reviewSlider.dart';
import 'package:fjeje_timbu/apis/models/listOfProductItem.dart';

class ViewProductPage extends StatefulWidget {
  const ViewProductPage({super.key, this.id, this.itemPrice});
  final String? id;
  final String? itemPrice;

  @override
  State<ViewProductPage> createState() => _ViewProductPageState();
}

class _ViewProductPageState extends State<ViewProductPage> {
  var name = '';
  Item2? item2;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    if (kDebugMode) {
      print("${widget.id}");
    }
    getAproduct();
  }

  void getAproduct() async {
    var get = Provider.of<TimbuApiProvider>(context, listen: false);
    try {
      var product = await get.getAProduct(widget.id!);
      setState(() {
        name = product.name;
        item2 = product;
        isLoading = false;
      });
      log(product.name);
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      log("Error fetching product: $e");
    }
  }

  void addTocart(Item2 productModel) {
    cart2.add(productModel);
    if (kDebugMode) {
      print('${productModel.name} added to cart');
    }
    success(context: context, message: "${productModel.name} is now in cart");
  }

  String text = lorem(paragraphs: 1, words: 20);
  String text2 = lorem(paragraphs: 1, words: 19);

  final NumberFormat currencyFormat = NumberFormat.currency(symbol: '₦', decimalDigits: 2);

  @override
  Widget build(BuildContext context) {
    double? itemPrice = double.tryParse(widget.itemPrice?.replaceAll('₦', '').replaceAll(',', '') ?? '0');
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 243, 235, 235),
      appBar: AppBar(
        backgroundColor: colorPrimary,
        toolbarHeight: 60,
        leading: IconButton(
          color: Colors.white,
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Product Details',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (item2 != null) ...[
                    SizedBox(
                      height: 350,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: item2!.photos.length,
                        itemBuilder: (context, index) {
                          var photoUrl =
                              "https://api.timbu.cloud/images/${item2!.photos[index].url}";
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: Image.network(
                                photoUrl,
                                height: 250,
                                width: 250,
                                fit: BoxFit.contain,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(40),
                              topRight: Radius.circular(40))),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10.0, right: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 30,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  item2!.name.toUpperCase(),
                                  softWrap: true,
                                  style: const TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                                const SizedBox(height: 10,),
                                Text(
                                  currencyFormat.format(itemPrice),
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Quantity = ${item2!.availableQuantity} pcs available now',
                                  style: const TextStyle(color: Colors.orange),
                                ),
                                InkWell(
                                  onTap: () {},
                                  child: const SizedBox(
                                    width: 50,
                                    height: 40,
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Flexible(
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          "Description",
                                          style: TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        item2!.description == null
                                            ? Text(
                                                text2,
                                                softWrap: true,
                                                style: const TextStyle(
                                                    fontSize: 17,
                                                    fontWeight: FontWeight.normal,
                                                    color: Colors.black),
                                              )
                                            : Text(
                                                item2!.description,
                                                style: const TextStyle(
                                                    fontSize: 17,
                                                    fontWeight: FontWeight.normal,
                                                    color: Colors.black),
                                              )
                                      ]),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            ReviewSlider(),
                          ],
                        ),
                      ),
                    ),
                  ] else
                    const Center(child: Text("Product not found")),
                ],
              ),
            ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(color: Colors.white),
        child: InkWell(
          onTap: () {
            if (item2 != null) {
              addTocart(item2!);
            }
          },
          child: Padding(
            padding:
                const EdgeInsets.only(left: 8.0, right: 8, bottom: 5, top: 5),
            child: Container(
              height: 60,
              decoration: const BoxDecoration(
                  color: colorPrimary,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(75),
                      bottomLeft: Radius.circular(75),
                      bottomRight: Radius.circular(25))),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Add To Cart  ',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.white),
                  ),
                  Icon(
                    Icons.shopping_cart_outlined,
                    color: Colors.white,
                    size: 24,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
