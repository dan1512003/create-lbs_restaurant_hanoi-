import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant/presentation/screens/user/user_page.dart';
import 'signup_page.dart';

import '../../../presentation/state/provider/user_provider.dart';

class EmailPage extends StatefulWidget {
  const EmailPage({super.key});

  @override
  State<EmailPage> createState() => _EmailPageState();
}

class _EmailPageState extends State<EmailPage> {
  final TextEditingController emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  Future<void> _handleNext(UserProvider userProvider) async {
    final email = emailController.text.trim();

   
    await userProvider.checkMail(email);


    final token = userProvider.token;


    if (!mounted) return;

   
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => token.isEmpty ? const SignUpPage() : const UserPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = context.read<UserProvider>();

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // AppBar
          Material(
            elevation: 7,
            color: Colors.white,
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                decoration: BoxDecoration(),
                height: 50,
                child: Row(
                  children: [
                    const Icon(Icons.chevron_left, size: 30),
                    const SizedBox(width: 8),
                    const Text(
                      'Back',
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                    )
                  ],
                ),
              ),
            ),
          ),

          // Body
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 30),

                  // Email input
                  Container(
                    decoration: BoxDecoration(),
                    height: MediaQuery.of(context).size.height * 0.1,
                    width: double.infinity,
                    child: Row(
                      children: [
                        Material(
                          elevation: 3,
                          color: Colors.white,
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.08,
                            width: MediaQuery.of(context).size.height * 0.08,
                            alignment: Alignment.center,
                            child: Icon(Icons.email,
                                size: MediaQuery.of(context).size.height * 0.05),
                          ),
                        ),
                        Expanded(
                          child: Material(
                            elevation: 1,
                            color: Colors.white,
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.08,
                              decoration: const BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(color: Colors.grey, width: 1),
                                ),
                              ),
                              child: TextField(
                                controller: emailController,
                                textAlign: TextAlign.left,
                                decoration: const InputDecoration(
                                  hintText: 'Email',
                                  border: InputBorder.none,
                                  isDense: true,
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 20, horizontal: 10),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 50),

                  // NEXT button
                  Center(
                    child: Material(
                      elevation: 3,
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.red,
                      child: GestureDetector(
                        onTap: () => _handleNext(userProvider),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          height: 50,
                          alignment: Alignment.center,
                          child: const Text(
                            "NEXT",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 50),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
