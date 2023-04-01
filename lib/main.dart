import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'a.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final VmCart cartController = Get.put(VmCart());

  // List of items to display on home page

  List<ModTest> items =[
    ModTest(Item: 'DS07266CA', Desc: 'GRLLE SUPPORT', Brand: 'OTN', Model: 'DS', Make: 'Taiwan'),
    ModTest(Item: 'DS07266CA', Desc: 'GRLLE SUPPORT', Brand: 'BTN', Model: 'DS', Make: 'Taiwan'),
    ModTest(Item: 'DS07266CA', Desc: 'GRLLE SUPPORT', Brand: 'CTN', Model: 'DS', Make: 'Taiwan'),
    ModTest(Item: 'DS07266CA', Desc: 'GRLLE SUPPORT', Brand: 'GTN', Model: 'DS', Make: 'Taiwan'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My App'),
        actions: <Widget>[
          Stack(
            children: [
              IconButton(
                icon: Icon(Icons.shopping_cart),
                onPressed: () {
                  Get.to(VwCart());
                },
              ),
              Positioned(
                right: 0,
                top: 8,
                child: Obx(
                      () => cartController.itemCount.value > 0
                      ? Container(
                    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      '${cartController.itemCount.value}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                      : Container(),
                ),
              ),
            ],
          ),
        ],
      ),
      body: SafeArea(
        child: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            final bool isItemInCart = cartController.cartItems.contains(items[index]);

            return GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: Text('Add to cart?'),
                    content: Text('Do you want to add ${items[index].Brand} to your cart?'),
                    actions: <Widget>[
                      TextButton(
                        child: Text('Cancel'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      TextButton(
                        child: Text('Add'),
                        onPressed: () {
                          cartController.addItem(items[index].Brand);
                          Get.snackbar(
                              'Item added',
                              '${items[index]} has been added to your cart',
                              backgroundColor: Colors.green,
                              colorText: Colors.white,
                              snackPosition: SnackPosition.BOTTOM,
                              duration: Duration(seconds: 1));
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                );
              },
              child: Card(
                color: isItemInCart ? Colors.green[50] : null,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    items[index].Brand,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class VmCart extends GetxController {
  var cartItems = RxList<String>();
  var itemCount = RxInt(0);

  void addItem(String item) {
    cartItems.add(item);
    itemCount.value++;
  }

  void removeItem(String item) {
    cartItems.remove(item);
    itemCount.value--;
  }
}
class VwCart extends StatelessWidget {
  final VmCart cartController = Get.find<VmCart>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Cart'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Obx(
                    () {
                  return cartController.cartItems.isEmpty
                      ? const Center(
                    child: Text('Your cart is empty!'),
                  )
                      : ListView.builder(
                    itemCount: cartController.cartItems.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        child: ListTile(

                          title: Text(
                            cartController.cartItems[index],
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          trailing: GestureDetector(
                            onTap: () {
                              cartController.removeItem(cartController.cartItems[index]);
                            },
                            child: Icon(Icons.remove_circle, color: Colors.red),
                          ),
                        ),
                      );
                    },
                  );

                },
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                child: Text('Checkout'),
                onPressed: () {
                  // TODO: Implement checkout logic
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class moduser{
  String product="";
  String company="";
  int productid=0;

}

class ModTest {
  String Item = "";
  String Desc = "";
  String Brand = "";
  String Model = "";
  String Make = "";

  ModTest({required this.Item, required this.Desc, required this.Brand, required this.Model, required this.Make});


}
