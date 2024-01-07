import 'package:flutter/material.dart';
import 'package:ui_test/screen/meetup.dart';
import 'package:ui_test/widgets/toasts.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'widgets/apptextfield.dart';
import 'package:crypto/crypto.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isCheck = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal:18.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            
            const SizedBox(height: 60,),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('promilo',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w700),),
              ],
            ),
            const SizedBox(height: 60,),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Hi, Welcome Back!',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w700),),
              ],
            ),
            const SizedBox(height: 50,),
            const Text('Please sign in to continue'),
            const SizedBox(height: 5,),
            AppTextField(
              controller:emailController ,
              keyboardType: TextInputType.emailAddress,
              hintText: 'Enter Email or Mob No',
              validator: (value){
                if (value!.isEmpty) {
                      return 'This filed can\'t be left empty';
                }
                if (!RegExp(
                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                .hasMatch(value)) {
                return 'Please enter a vaild email';
                }
                return null;
              },
             // onChangedVal: (value) {
                //   value = emailController.text;
                // },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(onPressed: (){}, child: const Text('Sign in With OTP',style: TextStyle(color: Colors.blue),))
            ],),
            const Text('Password'),
            const SizedBox(height: 5,),
            AppTextField(
              controller:passwordController ,
              keyboardType: TextInputType.text,
              hintText: 'Password',
              validator: (value){
                 if (value!.isEmpty) {
                      return 'This filed can\'t be left empty';
                    }
                    if (value.length < 10) {
                      return 'Password must of length 10';
                    }
                    return null;
              },
              // onChangedVal: (value) {
              //     value = passwordController.text;
              //   },
              
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Checkbox(
                      shape: ContinuousRectangleBorder(side:const BorderSide(width: 1,color: Colors.grey),borderRadius: BorderRadius.circular(10)),
                      value: isCheck, onChanged: (_){
                    setState(() {
                      isCheck=!isCheck;
                    });
                    }),
                    const Text('Remember me',style: TextStyle(color: Colors.grey),)
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(onPressed: (){}, child: const Text('Forget Password',style: TextStyle(color: Colors.blue),))
                ],),
              ],
            ),
            const SizedBox(height: 25,),
            GestureDetector(
              onTap: loginUser,
              child: Container(
                alignment: Alignment.center,
                height: 50,
                decoration: BoxDecoration(
                color:(emailController.text.isNotEmpty&&passwordController.text.isNotEmpty)? Colors.blueAccent:Colors.lightBlue,
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(12)),
                child:const Padding(
                  padding:  EdgeInsets.all(8.0),
                  child: Text('Submit',style:TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.w700),),
                )
              ),
            ),
            const SizedBox(height: 50,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: MediaQuery.sizeOf(context).width/2.5,
                  child:const Divider(color: Colors.grey,thickness: 0.2),),
                const Text('or'),
                SizedBox(
                  width: MediaQuery.sizeOf(context).width/2.5,
                  child:const Divider(color: Colors.grey,thickness: 0.2),),
              ],
            ),
            const SizedBox(height: 50,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              Row(
                  children: [
                buildCommonImagePlaceHolder('assests/google.png'),
               const SizedBox(width: 10,),
                buildCommonImagePlaceHolder('assests/linkedin.png'),
                const SizedBox(width: 10,),
                buildCommonImagePlaceHolder('assests/facebook.png'),
                const SizedBox(width: 10,),
                buildCommonImagePlaceHolder('assests/instagram.png'),
                const SizedBox(width: 10,),
                buildCommonImagePlaceHolder('assests/whatsapp.png'),
                  ],
                )
              ],
            )
          ],),
        ),
      ),
    );
  }

  void loginUser(){
    if(emailController.text.isEmpty){
      Toasts.showWarningToast('Please enter a email');
      return;
    }
    if(passwordController.text.isEmpty){
      Toasts.showWarningToast('Please enter a password');
      return;
    }

    sendRequest();
  }


void sendRequest() async {
  var url = "https://apiv2stg.promilo.com/user/oauth/token";

  // Your email and password values
  String email = emailController.text.trim();
  String password = passwordController.text.trim();

  String hashedPassword = hashPassword(password);


  var request = http.MultipartRequest('POST', Uri.parse(url));


  request.fields['grant_type'] = 'password';
  request.fields['username'] = email;
  request.fields['password'] = hashedPassword;

  request.headers['Authorization'] = 'Basic UHJvbWlsbzpxNCE1NkBaeSN4MiRHQg==';
  request.headers['Content-Type'] = 'multipart/form-data';

  try {

    var response = await request.send();
    if (response.statusCode <= 200) {
      var responseData = jsonDecode(await response.stream.bytesToString());
      print("Access Token: ${responseData['access_token']}");
      Toasts.showSuccessToast('User logged in successfully');
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>Meetup()));
    } else {
  
      print("Error: ${response.statusCode} - ${await response.stream.bytesToString()}");
      Toasts.showWarningToast('Invalid Id or password');
    }
  } catch (error) {
    
    print("Error: $error");
    Toasts.showWarningToast('Invalid Id or password');
  }
}


String hashPassword(String password) {
  // Hash the password using SHA-256
  var bytes = utf8.encode(password);
  var digest = sha256.convert(bytes);
  return digest.toString();
}


Widget buildCommonImagePlaceHolder(String imagePath){
  return Container(
    height: 40,
    width: 40,
   child: Image.asset(imagePath),
  );
}


  @override
  void dispose() {
    // TODO: implement dispose
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}