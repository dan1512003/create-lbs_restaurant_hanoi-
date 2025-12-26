import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant/presentation/state/provider/user_provider.dart';

class EditUserPage extends StatefulWidget {
  const EditUserPage({super.key});

  @override
  State<EditUserPage> createState() => _EditUserPageState();
}

class _EditUserPageState extends State<EditUserPage> {
  late TextEditingController firstnameController;
  late TextEditingController lastnameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;

  bool hasChanged = false;

  @override
  void initState() {
    super.initState();

    final user = context.read<UserProvider>().user;
   
    firstnameController = TextEditingController(text: user!.firstName);
    lastnameController = TextEditingController(text: user.lastName);
    emailController = TextEditingController(text: user.email);
    phoneController = TextEditingController(text: user.phone);

    firstnameController.addListener(_checkChanged);
    lastnameController.addListener(_checkChanged);
    emailController.addListener(_checkChanged);
    phoneController.addListener(_checkChanged);
  }

  void _checkChanged() {
    final user = context.read<UserProvider>().user;

    final bool isDifferent =
        firstnameController.text.trim() != user!.firstName ||
        lastnameController.text.trim() != user.lastName ||
        emailController.text.trim() != user.email ||
        phoneController.text.trim() != user.phone;

    if (isDifferent != hasChanged) {
      setState(() {
        hasChanged = isDifferent;
      });
    }
  }

  @override
  void dispose() {
    firstnameController.dispose();
    lastnameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = context.watch<UserProvider>();

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          //appbar
          Container(
            height: 50,
            color: Colors.red,
            child: Row(
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(
                    Icons.chevron_left,
                    size: 30,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(width: 4),
                const Text(
                  'Cancel',
                  style: TextStyle(fontSize: 14),
                ),
              ],
            ),
          ),

          //body
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const SizedBox(height: 30),

                  _buildRow("Lastname:", lastnameController),
                  _buildRow("Firstname:", firstnameController),
                  _buildRow("Email:", emailController),
                  _buildRow("Number phone:", phoneController),

                  const SizedBox(height: 30),

          
                  if (hasChanged)
                    ElevatedButton(
                      onPressed: () {
                         final user = context.read<UserProvider>().user;
                        userProvider.editUser(
                          phoneController.text.trim(),
                          emailController.text.trim(),
                          lastnameController.text.trim(),
                          firstnameController.text.trim(),
                          user!.email
                        );
                      },
                      child: const Text('Save'),
                    ),

           
                  if (userProvider.error.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 12),
                      child: Text(
                        userProvider.error,
                        style: const TextStyle(color: Colors.red),
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

  Widget _buildRow(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          SizedBox(
            width: 110,
            child: Text(label),
          ),
          Expanded(
            child: TextField(
              controller: controller,
              decoration: const InputDecoration(
                border: InputBorder.none,
              ),
            ),
          ),
          const Icon(Icons.chevron_right),
        ],
      ),
    );
  }
}
