import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:myapp/controllers/authentication_controller.dart';
import 'package:myapp/screens/home_screen.dart'; // Import your home screen

class LoginScreen extends StatelessWidget {
  final TextEditingController nimController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginScreen({Key? key});

  void showLoginFailedSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Failed to log in. Please try again.'),
    ));
  }

  @override
  Widget build(BuildContext context) {
    double side = MediaQuery.of(context).size.width * 0.05;
    final authenticationController =
        Provider.of<AuthenticationController>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
          centerTitle: false,
          title: Image.asset('assets/images/appbar.png', height: 25),
          toolbarHeight: 50,
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.black)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Masukkan Informasi Akun Kamu', // First text
              style: TextStyle(
                fontSize: 24, // Adjust font size as needed
                fontWeight: FontWeight.bold, // Make it bold
              ),
            ),
            Align(
              alignment: Alignment.centerLeft, // Align text to left
              child: Padding(
                padding: EdgeInsets.only(left: side, top: 5, bottom: 10),
                child: const Text(
                  'Jika ada kebingungan, hubungi developer', // Second text
                  style: TextStyle(
                    fontSize: 14, // Adjust font size as needed
                    color: Colors.grey, // Change text color
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10, left: side, right: side),
              child: TextField(
                controller: nimController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'NIM',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                        width: 3,
                        color: Colors.blue), // Highlight color when clicked
                  ),
                ),
              ),
            ),
            Padding(
              padding:
                  EdgeInsets.only(left: side, right: side, top: 10, bottom: 10),
              child: TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                        width: 3,
                        color: Colors.blue), // Highlight color when clicked
                  ),
                ),
              ),
            ),
            Builder(
              builder: (BuildContext context) {
                return ElevatedButton(
                  onPressed: () async {
                    final nim = nimController.text;
                    final password = passwordController.text;
                    final response = await http.post(
                      Uri.parse('https://api.sipadu.dev/auth/signin'),
                      body: {
                        'nim': nim,
                        'password': password,
                      },
                    );
                    if (response.statusCode == 200) {
                      final responseData = json.decode(response.body);
                      final accessToken = responseData['access_token'];

                      // Save access token to shared preferences
                      final prefs = await SharedPreferences.getInstance();
                      prefs.setString('access_token', accessToken);

                      // Perform login action
                      authenticationController.login();

                      // Navigate to home screen without showing back button
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomeScreen()),
                        (route) => false,
                      );
                    } else {
                      // Handle error
                      showLoginFailedSnackBar(context);
                    }
                  },
                  child: SizedBox(
                    height: MediaQuery.of(context).size.width * 0.1,
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: const Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Log in',
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
