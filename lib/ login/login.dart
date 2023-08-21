import 'package:app_3/usermodel/usermodal.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../signup/signup.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _emailCntrlr = TextEditingController();
  final TextEditingController _passwordCntrlr = TextEditingController();

  /*final _auth = FirebaseAuth.instance;
  final furmkey = GlobalKey<FormState>();
*/

  void check_login_value() {
    String email = _emailCntrlr.text.trim();
    String password = _passwordCntrlr.text.trim();

    if (email == "" || password == "") {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.lightBlue.shade300,
          content: const Text(
            'Pleas fill the  all Feilds ',
            style: TextStyle(color: Colors.black),
          )));
    } else {
           Loginnup  (email, password);
    }
  }

  void Loginnup(String email, String password) async {

      UserCredential? cred_of_login;

      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: email, password: password);
      }on FirebaseAuthException catch(exeption_login){

        print(exeption_login.toString());

      }

      if(cred_of_login!= null){

        String uid = cred_of_login.user!.uid;

        DocumentSnapshot userdata = await FirebaseFirestore.instance.collection('users').doc(uid).get();
        UserModel userModel = UserModel.this_User_Map(userdata.data() as Map<String, dynamic>);

        print('Login Succeed !!!!!');



      }


  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            const Text(
              'We-Chat.',
              style: TextStyle(color: Colors.lightBlue, fontSize: 30),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _emailCntrlr,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  filled: true,
                  hintText: 'email *',
                  fillColor: Colors.white,
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter an email';
                  }
                  final emailRegExp = RegExp(
                      r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");
                  if (!emailRegExp.hasMatch(value)) {
                    return 'Please enter a valid email';
                  }
                  return null; // Return null if the input is valid
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _passwordCntrlr,
                obscureText: true,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    filled: true,
                    hintText: 'password *',
                    fillColor: Colors.white),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
                style:
                    ElevatedButton.styleFrom(minimumSize: const Size(300, 50)),
                onPressed: () {
                  check_login_value();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const Signup()),
                  );
                },
                child: const Text(
                  'Login',
                  style: TextStyle(fontSize: 20),
                )),
            const SizedBox(
              height: 80,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Don't have an account ?",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const Signup()),
                      );


                    },
                    child: const Text('Sign Up',
                        style:
                            TextStyle(color: Colors.lightBlue, fontSize: 20)))
              ],
            ),
          ]),
        ),
        backgroundColor: Colors.black,
      ),
    );
  }
}
