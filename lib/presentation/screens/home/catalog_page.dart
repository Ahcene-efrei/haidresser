import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hairdresser/presentation/screens/product/addProduct_page.dart';
import 'package:hairdresser/data/json/home_page_json.dart';
import 'package:hairdresser/data/models/Product.dart';
class CatalogPage extends StatefulWidget {
  CatalogPage({Key? key}) : super(key: key);
  final dio = Dio();
  @override
  _CatalogPageState createState() => _CatalogPageState();
}

class _CatalogPageState extends State<CatalogPage> {
  var listProducts = products;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: listProducts.length,
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              onTap: ()=>{

              },
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)
                ),

                child: Row(
                  children: [
                    Container(
                      height: 100,
                      width: 100,
                      color: Colors.blueGrey,
                      child: Icon(
                        Icons.shopping_cart_outlined,
                        size: 80,
                        color: Colors.white,
                      ),
                    ),
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              listProducts[index].name,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                            SizedBox(height: 7),
                            Text("test"),
                            SizedBox(height: 7),
                            Text(
                              "${listProducts[index].price.toString()} €",
                              style: TextStyle(
                                fontSize: 18
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          }
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add your onPressed code here!
          Navigator.push(context, MaterialPageRoute(
            builder: (context) => AddProductPage(addProduct: addProduct),
          ),);
        },
        child: const Icon(Icons.add),
        backgroundColor: Colors.blueGrey,
      ),
    );
  }

  void addProduct(Product product){
    setState(() {
      listProducts.add(product);
    });
  }
}
