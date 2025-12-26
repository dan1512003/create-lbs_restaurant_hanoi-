import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant/presentation/state/provider/user_provider.dart';
import 'email_page.dart';

class PhonePage extends StatefulWidget {
  const PhonePage({super.key});

  @override
  State<PhonePage> createState() => _PhonePageState();
}

class _PhonePageState extends State<PhonePage> {
  final TextEditingController phoneController = TextEditingController();

  @override
  void dispose() {
    phoneController.dispose();
    super.dispose();
  }

  Future<void> _handleUseEmail(UserProvider userProvider) async {
   
    await userProvider.checkPhone(phoneController.text);

   
    if (!mounted) return;

    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const EmailPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = context.read<UserProvider>();

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // App Bar
          Material(
            elevation: 7,
            color: Colors.white,
            child: Container(height: 50),
          ),

          // Body
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 30),

                  // Phone input row
                  Container(
                    height: MediaQuery.of(context).size.height * 0.1,
                    width: double.infinity,
                    alignment: Alignment.center,
                    child: Row(
                      children: [
                        Material(
                          elevation: 3,
                          color: Colors.white,
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.08,
                            width: MediaQuery.of(context).size.height * 0.08,
                            alignment: Alignment.center,
                            child: Icon(
                              Icons.phone,
                              size: MediaQuery.of(context).size.height * 0.05,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Material(
                            color: Colors.white,
                            elevation: 1,
                            child: Container(
                              height:
                                  MediaQuery.of(context).size.height * 0.08,
                              decoration: const BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: Colors.grey,
                                    width: 1,
                                  ),
                                ),
                              ),
                              child: TextField(
                                controller: phoneController,
                                textAlign: TextAlign.left,
                                decoration: const InputDecoration(
                                  hintText: 'Number phone',
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

                          onTap: () => _handleUseEmail(userProvider),
                     
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

                  // Use email instead
                  Center(
                    child: GestureDetector(
                       onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const EmailPage()),
                          );
                        },
                      child: const Text(
                        'Use email instead',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
