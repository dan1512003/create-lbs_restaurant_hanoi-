import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant/presentation/state/provider/user_provider.dart';
import '../screens/user/user_page.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  bool isButtonEnabled = false;
  bool isLoading = false;

  void checkFields() {
    setState(() {
      isButtonEnabled = firstNameController.text.isNotEmpty &&
          lastNameController.text.isNotEmpty &&
          emailController.text.isNotEmpty &&
          phoneController.text.isNotEmpty;
    });
  }

  @override
  void initState() {
    super.initState();
    firstNameController.addListener(checkFields);
    lastNameController.addListener(checkFields);
    emailController.addListener(checkFields);
    phoneController.addListener(checkFields);
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  Future<void> handleNext() async {
    setState(() {
      isLoading = true;
    });

    final provider = Provider.of<UserProvider>(context, listen: false);

    await provider.saveUser(
      phoneController.text,
      emailController.text,
      lastNameController.text,
      firstNameController.text,
    );

    if (!mounted) return; 

    setState(() {
      isLoading = false;
    });

    if (provider.token.isEmpty) {

      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Lỗi'),
          content: const Text('Không thể tạo tài khoản. Vui lòng thử lại.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } else {
     
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const UserPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // AppBar
          Container(
            decoration: BoxDecoration(),
            height: 50,
            child: Row(
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(
                    Icons.chevron_left,
                    color: Color.fromARGB(192, 0, 0, 0),
                    size: 30,
                  ),
                ),
                const SizedBox(width: 4),
                Container(
                  margin: const EdgeInsets.only(top: 5),
                  child: const Text(
                    'Back',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                )
              ],
            ),
          ),

          // Body
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 30),
                  _buildTextField('First name', firstNameController),
                  const SizedBox(height: 20),
                  _buildTextField('Last name', lastNameController),
                  const SizedBox(height: 20),
                  _buildTextField('Email', emailController),
                  const SizedBox(height: 20),
                  _buildTextField('Number phone', phoneController),
                  const SizedBox(height: 50),
                  Center(
                    child: Material(
                      elevation: 3,
                      borderRadius: BorderRadius.circular(8),
                      color: isButtonEnabled ? Colors.red : Colors.grey,
                      child: InkWell(
                        onTap: isButtonEnabled && !isLoading
                            ? handleNext
                            : null,
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          height: 50,
                          alignment: Alignment.center,
                          child: isLoading
                              ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : const Text(
                                  "NEXT",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                        ),
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

  Widget _buildTextField(String hint, TextEditingController controller) {
    return Container(
      decoration: BoxDecoration(),
      width: MediaQuery.of(context).size.width * 0.9,
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hint,
          filled: true,
          fillColor: Colors.white,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
          border: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 0.5),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 0.5),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red, width: 1),
          ),
        ),
        keyboardType: hint == 'Email'
            ? TextInputType.emailAddress
            : hint == 'Number phone'
                ? TextInputType.phone
                : TextInputType.text,
      ),
    );
  }
}
