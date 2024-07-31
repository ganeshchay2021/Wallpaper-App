// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:wallpaperapp/Admin/Admin%20Login/widgets/custom_text_field.dart';
import 'package:wallpaperapp/Admin/admin%20dashboard/ui/admin_dashboard.dart';

class AdminLogin extends StatefulWidget {
  const AdminLogin({super.key});

  @override
  State<AdminLogin> createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  // final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: SizedBox(
        child: Stack(
          children: [
            Container(
              height: height,
              width: width,
              margin: EdgeInsets.only(top: height / 2),
              padding: EdgeInsets.only(
                  top: height * 0.051,
                  right: height * 0.023,
                  left: height * 0.023),
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.vertical(top: Radius.elliptical(width, 110)),
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.topRight,
                  colors: [Color.fromARGB(255, 53, 51, 51), Colors.black],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                  right: height * 0.032,
                  left: height * 0.032,
                  top: height * 0.069),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Let's start with\nAdmin",
                    style: TextStyle(
                      fontSize: height * 0.028,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: height * 0.034,
                  ),
                  Material(
                    elevation: 3.0,
                    borderRadius: BorderRadius.circular(width * 0.048),
                    child: Container(
                      height: height / 2.2,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(width * 0.048),
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            height: height * 0.059,
                          ),
                          CustomTextField(
                            controller: _usernameController,
                            width: width,
                            height: height,
                            hintText: "Username",
                            errorText: "Please enter username",
                          ),
                          SizedBox(
                            height: height * 0.040,
                          ),
                          CustomTextField(
                            controller: _passwordController,
                            width: width,
                            height: height,
                            hintText: "Password",
                            errorText: "Please enter password",
                            obscureText: true,
                          ),
                          SizedBox(
                            height: height * 0.059,
                          ),
                          GestureDetector(
                            onTap: () {
                              loginAdmin(height);
                            },
                            child: Container(
                              alignment: Alignment.center,
                              height: height * 0.065,
                              width: width,
                              padding: EdgeInsets.symmetric(
                                  vertical: height * 0.013),
                              margin: EdgeInsets.symmetric(
                                  horizontal: width * 0.048),
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.circular(height * 0.012),
                                  color: Colors.black),
                              child: Text(
                                "Login",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: height * 0.025,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  loginAdmin(double height) {
    FirebaseFirestore.instance.collection("Admin").get().then((snapshot) {
      for (var result in snapshot.docs) {
        if (result.data()['id'] != _usernameController.text.trim()) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              duration: const Duration(seconds: 1),
              backgroundColor: Colors.red,
              content: Text(
                "Incorrect username",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: height * 0.020,
                ),
              ),
            ),
          );
        } else if (result.data()['password'] !=
            _passwordController.text.trim()) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              duration: const Duration(seconds: 1),
              backgroundColor: Colors.red,
              content: Text(
                "Incorrect password",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: height * 0.020,
                ),
              )));
        } else {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AdminDashBoard(),
              ));
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.green,
              duration: const Duration(seconds: 1),
              content: Text(
                "Login Successfully",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: height * 0.020,
                ),
              )));
          _usernameController.clear();
          _passwordController.clear();
        }
      }
    });
  }
}
