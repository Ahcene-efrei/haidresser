import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_verification_code/flutter_verification_code.dart';
import 'package:hairdresser/presentation/screens/login/register_screen.dart';
import 'package:hairdresser/data/models/hairdresser.dart';
import 'package:hairdresser/data/models/User.dart';
import 'package:hairdresser/data/models/ApiResponse.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class CodePage extends StatefulWidget {
  final String phoneNumber;
  CodePage({Key? key, required this.phoneNumber}) : super(key: key);
  final dio = Dio(BaseOptions(contentType: "application/json; charset=utf-8"));
  // Create storage
  final storage = new FlutterSecureStorage();
  @override
  _CodePageState createState() => _CodePageState();
}

class _CodePageState extends State<CodePage> {
  String code = '';
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
                    "Saisissez le code à 4 chiffres envoyé au ${widget.phoneNumber}",
                    style: TextStyle(
                      fontSize: 20,

                    ),
                  ),
                  SizedBox(height: 40),
                  VerificationCode(
                    textStyle: TextStyle(fontSize: 20.0),
                    keyboardType: TextInputType.number,
                    // in case underline color is null it will use primaryColor: Colors.red from Theme
                    underlineColor: Colors.amber,
                    length: 4,

                    onCompleted: (String value) {
                      code = value;
                    },
                    onEditing: (bool value) {
                      if(code != ''){
                        code = '';
                      }
                    },
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0,0,0,50),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Colors.black, // This is what you need!
                      padding: const EdgeInsets.all(15)
                  ),
                  onPressed: (){
                    sendCode(widget.phoneNumber, code, context);
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
              )
            ],
        ),
        ),
      ),
    );
  }

  Future<void> sendCode(String phoneNumber, String code, BuildContext context) async {
    var jsonData = null;
    //SharedPreferences preferences = await SharedPreferences.getInstance();
    //await preferences.clear();
    print("aza");
    var response = await widget.dio.post(
        'https://labonnecoupe.azurewebsites.net/api/Hairdresser/AuthenticateOrRegister',
        data: {
          'phoneNumber': phoneNumber,
          'token':code
        },
      );

    jsonData = jsonDecode(jsonEncode(response.data["data"]));
    if(response.statusCode == 200 && response.data['succeeded']){

      //preferences.setString('token', jsonData['data']['jwtToken']);
      var user = jsonData['user'];
      print(user);
      Hairdresser loggedUser = Hairdresser(
        firstname: user["firstname"],
        phoneNumber: user['phoneNumber']
      );
      await widget.storage.write(key: 'jwt', value: jsonData['jwtToken']);
      await widget.storage.write(key: 'user', value: jsonEncode(loggedUser.toJson()));
      print(loggedUser.firstname);
      if(loggedUser.isRegistered()){
        Navigator.pushNamedAndRemoveUntil(context, "/homepage", (route) => false);
      }else{
        Navigator.push(context, MaterialPageRoute(
          builder: (context) => RegisterPage(hairdresser: loggedUser),
        ),);
      }
    }
  }
}



