import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hairdresser/data/models/Hairdresser.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class RegisterPage extends StatefulWidget {
  Hairdresser hairdresser;
  RegisterPage({Key? key, required this.hairdresser}) : super(key: key);
  var dio = Dio();
  final storage = new FlutterSecureStorage();



  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String? token;
  final _formKey = GlobalKey<FormState>();
  final firstnameController = TextEditingController();
  final lastnameController = TextEditingController();
  final emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
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
                    "Create Account",
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
                              labelText: 'Firstname'
                          ),
                          // The validator receives the text that the user has entered.
                          validator: (value) {

                            if (value == null || value.isEmpty) {
                              return 'firstname is required';
                            }
                            return null;
                          },
                          controller: firstnameController,
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                              border: UnderlineInputBorder(),
                              labelText: 'Lastname'
                          ),
                          // The validator receives the text that the user has entered.
                          validator: (value) {

                            if (value == null || value.isEmpty) {
                              return 'lastname is required';
                            }
                            return null;
                          },
                          controller: lastnameController,
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                              border: UnderlineInputBorder(),
                              labelText: 'Email'
                          ),
                          // The validator receives the text that the user has entered.
                          validator: (value) {
                            bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value!);

                            if (!emailValid) {
                              return 'Email is required';
                            }
                            return null;
                          },
                          controller: emailController,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              _submitButton()
            ],
          ),
        ),
      ),
    );
  }

  Widget _entryField(String title, {bool isPassword = false}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
              obscureText: isPassword,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  fillColor: Color(0xfff3f3f4),
                  filled: true))
        ],
      ),
    );
  }

  Widget _submitButton() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0,0,0,50),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            primary: Colors.black, // This is what you need!
            padding: const EdgeInsets.all(15)
        ),
        onPressed: (){
          if (_formKey.currentState!.validate()) {

            register();
          }
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text(
              "Continuer",
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            Icon(Icons.arrow_forward_ios)
          ],
        ),
      ),
    );
  }

  Future<void> register() async {
    String? token = await widget.storage.read(key: "jwt");
    print(token);
    widget.dio.options.headers['content-Type'] = 'application/json';
    widget.dio.options.headers["authorization"] = "Bearer ${token}";
    var url = "https://labonnecoupe.azurewebsites.net/api/Hairdresser/UpdateInformation";
    print(firstnameController.text);
    var data = {
      "firstname": firstnameController.text,
      "lastname": lastnameController.text,
      "email": emailController.text,
      "pictureUrl": "http://domain.ltd",
      "gender": 1,
      "addresses": [
        {
          "name": "adresse vide",
          "address1": "",
          "address2": "",
          "city": "",
          "country": "",
          "zipCode": ""
        }
      ]
    };
    Hairdresser hairdresser = Hairdresser(firstname: firstnameController.text);
    hairdresser.fromJson(data);
    print(hairdresser.toJson());
    var response = await widget.dio.put(url, data: hairdresser.toJson()).catchError((error)=>{
      print(error.response)
    });
    await widget.storage.write(key: 'user', value: jsonEncode(hairdresser.toJson()));
    Navigator.pushNamedAndRemoveUntil(context, "/homepage", (route) => false);

  }

}
