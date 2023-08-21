import 'package:app_3/%20login/login.dart';
import 'package:app_3/usermodel/usermodal.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  TextEditingController emailcontrlr = TextEditingController();
  TextEditingController passwordcontrlr = TextEditingController();
  TextEditingController conformpassword = TextEditingController();

  void checkvalue() {
    String email = emailcontrlr.text.trim();
    String password = passwordcontrlr.text.trim();
    String confompaswrd = conformpassword.text.trim();

    if (email == "" || password == "" || confompaswrd == "") {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.lightBlue.shade300,
          content: const Text(
            'Pleas fill the  all Feilds ',
            style: TextStyle(color: Colors.black),
          )));
    } else if (password != confompaswrd) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.lightBlue.shade300,
          content: const Text('Password Do not Match !!',
              style: TextStyle(color: Colors.black))));
    } else {
      signup(email, password);
    }
  }

  void signup(String email, String password) async {
    UserCredential? auth_user_cred;

    try {
      auth_user_cred = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (find_the_exeption) {
      print(find_the_exeption.toString());
    }

    if (auth_user_cred != null) {
      String uid = auth_user_cred.user!.uid;
      UserModel for_new_users =
          UserModel(id: uid, email: email, name: "", profilepic: "");
      await FirebaseFirestore.instance
          .collection("Users")
          .doc(uid)
          .set(for_new_users.tooMaps())
          .then((value) {
        print('New User Created !!!!!');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              const Text(
                'We-Chat.',
                style: TextStyle(color: Colors.lightBlue, fontSize: 30),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: emailcontrlr,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      filled: true,
                      hintText: 'email *',
                      fillColor: Colors.white),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: passwordcontrlr,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      filled: true,
                      hintText: 'password *',
                      fillColor: Colors.white),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: conformpassword,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      filled: true,
                      hintText: 'conform password *',
                      fillColor: Colors.white),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size(300, 50)),
                  onPressed: () {
                     checkvalue();
                     },
                  child: const Text(
                    'Sign up',
                    style: TextStyle(fontSize: 20),
                  )),
              const SizedBox(
                height: 80,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Already have an account ?",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  TextButton(
                      onPressed: () {

                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const Login()),
                        );
                      },
                      child: const Text('Login',
                          style:
                              TextStyle(color: Colors.lightBlue, fontSize: 20)))
                ],
              ),
            ]),
          ),
        ),
        backgroundColor: Colors.black,
      ),
    );
  }
}
