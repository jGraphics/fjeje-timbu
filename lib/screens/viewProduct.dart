import 'dart:developer';
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
  final id;
  final itemPrice;

  @override
  State<ViewProductPage> createState() => _ViewProductPageState();
}

class _ViewProductPageState extends State<ViewProductPage> {
  @override
  void initState() {
    super.initState();
    if (kDebugMode) {
      print("${widget.id}");
    }
    getAproduct();
  }

  var name = '';
  Item2? item2;

  void getAproduct() {
    var get = Provider.of<TimbuApiProvider>(context, listen: false);
    get.getAProduct(widget.id!).then((onValue) => {
          log(onValue.name),
          setState(() {
            name = onValue.name;
            item2 = onValue;
          })
        });
  }

  void addTocart(Item2 productModel) async {
    cart2.add(productModel);
    if (kDebugMode) {
      print('${productModel.name} added to cart');
    }
    success(context: context, message: "${productModel.name} is now in cart");
  }

  String text = lorem(paragraphs: 1, words: 20);
  String text2 = lorem(paragraphs: 1, words: 19);

  @override
  Widget build(BuildContext context) {
    var get = context.watch<TimbuApiProvider>();
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
      body: get.loading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
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
                          child: Image.network(
                            photoUrl,
                            height: 250,
                            width: 250,
                            fit: BoxFit.contain,
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
                                '₦${widget.itemPrice}',
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
                  )
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
