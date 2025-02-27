import 'package:connectivity_plus/connectivity_plus.dart'; // Internet check
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:schat/screens/chat_screen.dart';
import 'package:schat/screens/register_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Check Internet Connection
  Future<bool> _hasInternetConnection() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
  }

  // Show No Internet Alert
  void _showNoInternetDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("No Internet Connection"),
        content: Text("Please check your internet and try again."),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("OK"),
          ),
        ],
      ),
    );
  }

  // Email & Password Login
  Future<void> _loginWithEmail() async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => ChatScreen(chatId: "your_chat_id")),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Login Failed: $e")),
      );
    }
  }

  // Google Sign-In
  Future<void> _signInWithGoogle() async {
    if (!await _hasInternetConnection()) {
      _showNoInternetDialog();
      return;
    }

    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) return;

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await _auth.signInWithCredential(credential);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Google Sign-In Successful")),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Google Sign-In Failed: $e")),
      );
    }
  }

  // Facebook Sign-In
  Future<void> _signInWithFacebook() async {
    if (!await _hasInternetConnection()) {
      _showNoInternetDialog();
      return;
    }

    try {
      final LoginResult result = await FacebookAuth.instance.login();
      if (result.status == LoginStatus.success) {
        final credential =
            FacebookAuthProvider.credential(result.accessToken!.token);
        await _auth.signInWithCredential(credential);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Facebook Sign-In Successful")),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Facebook Sign-In Failed")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Facebook Sign-In Failed: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Welcome back to Sap",
                    style:
                        TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                Text("Privacy is freedom",
                    style: TextStyle(fontSize: 16, color: Colors.grey)),
                const SizedBox(height: 40),

                // Email Input
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      labelText: "Email",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(height: 10),

                // Password Input
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: "Password",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Login Button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: ElevatedButton(
                    onPressed: _loginWithEmail,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white,
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    child: const Text("Log In"),
                  ),
                ),
                const SizedBox(height: 10),

                // OR Divider
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(child: Divider(thickness: 1)),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text("or continue with"),
                    ),
                    Expanded(child: Divider(thickness: 1)),
                  ],
                ),
                const SizedBox(height: 10),

                // Google & Facebook Sign-In Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Google Sign-In Button
                    ElevatedButton(
                      onPressed: _signInWithGoogle,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                        side: BorderSide(color: Colors.grey),
                      ),
                      child: Row(
                        children: [
                          Image.asset("assets/google_logo.png", height: 20),
                          SizedBox(width: 10),
                          Text("Google", style: TextStyle(color: Colors.black)),
                        ],
                      ),
                    ),
                    SizedBox(width: 10),

                    // Facebook Sign-In Button
                    ElevatedButton(
                      onPressed: _signInWithFacebook,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                        side: BorderSide(color: Colors.grey),
                      ),
                      child: Row(
                        children: [
                          Image.asset("assets/facebook_logo.png", height: 20),
                          SizedBox(width: 10),
                          Text("Facebook",
                              style: TextStyle(color: Colors.black)),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Signup Link
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RegisterScreen()),
                    );
                  },
                  child: Text.rich(
                    TextSpan(text: "Don't have an account?", children: [
                      TextSpan(
                        text: "Create now",
                        style: TextStyle(color: Colors.blue),
                      )
                    ]),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
