import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hairdresser/data/models/product.dart';

class AddProductPage extends StatelessWidget {
  AddProductPage({Key? key, required this.addProduct}) : super(key: key);
  final dio = Dio();
  final storage = new FlutterSecureStorage();
  final Function addProduct;
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final priceController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsetsDirectional.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Create Product",
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  ),
                  SizedBox(height: 40),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          decoration: const InputDecoration(
                              border: UnderlineInputBorder(),
                              labelText: 'Name'
                          ),
                          // The validator receives the text that the user has entered.
                          validator: (value) {

                            if (value == null || value.isEmpty) {
                              return 'Name is required';
                            }
                            return null;
                          },
                          controller: nameController,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                              border: UnderlineInputBorder(),
                              labelText: 'Price'
                          ),
                          // The validator receives the text that the user has entered.
                          validator: (value) {

                            if (value == null || value.isEmpty) {
                              return 'Price is required';
                            }
                            return null;
                          },
                          controller: priceController,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              _submitButton(context)
            ],
          ),
        ),
      ),
    );
  }
  Widget _submitButton(context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0,0,0,50),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            primary: Colors.blueGrey, // This is what you need!
            padding: const EdgeInsets.all(15)
        ),
        onPressed: (){
          addNewProduct(context);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text(
              "Ajouter",
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            Icon(Icons.add)
          ],
        ),
      ),
    );
  }

  Future<void> addNewProduct(context) async {
    print('addNewProduct');
    String? token = await storage.read(key: "jwt");

    dio.options.headers['content-Type'] = 'application/json';
    dio.options.headers["authorization"] = "Bearer ${token}";
    var response = await dio.post("https://labonnecoupe.azurewebsites.net/api/Hairdresser/AddProductToCatalog",
        data: {
          "name":nameController.text
        });
    print(response.data);
    if(response.data["succeeded"]){
      addProduct(Product(name: nameController.text, price: double.parse(priceController.text)));
      Navigator.pop(context);
    }

  }
}


