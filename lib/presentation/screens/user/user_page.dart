import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant/presentation/screens/user/edit_user_page.dart';
import 'package:restaurant/presentation/state/provider/user_provider.dart';
import '../settingnavigator.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  final List<Map<String, Icon>> menuList = const [
    {'Save': Icon(Icons.bookmark)},
    {'Reviews': Icon(Icons.calendar_month)},
  ];

  
  Color getRandomColor() {
    final random = Random();
    return Color.fromARGB(
      255,
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
    );
  }


  Future<void> _handleSignOut() async {
    await context.read<UserProvider>().signout();

    if (!mounted) return;

    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const Settingnavigator()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = context.watch<UserProvider>();
    final user = userProvider.user;

    final userName = (user?.name?.isNotEmpty ?? false) ? user?.name! : 'User';
    final initial = userName?[0].toUpperCase();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // AppBar
            Container(
              height: 50,
              decoration: const BoxDecoration(color: Colors.red),
            ),

            // Body
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                  
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      color: Colors.red,
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 40,
                            backgroundColor:
                                (user?.image == null ||  user!.image!.isEmpty)
                                    ? getRandomColor()
                                    : Colors.transparent,
                            backgroundImage:
                                (user?.image != null && user!.image!.isNotEmpty)
                                    ? NetworkImage(user.image!)
                                    : null,
                            child:
                                (user?.image == null || user!.image!.isEmpty)
                                    ? Text(
                                        initial!,
                                        style: const TextStyle(
                                            fontSize: 40,
                                            color: Colors.white),
                                      )
                                    : null,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            userName!,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                  
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'My purchases',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          SizedBox(
                            height: 80,
                            child: LayoutBuilder(
                              builder: (context, constraints) {
                                final itemWidth =
                                    constraints.maxWidth / 2;
                                return ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: menuList.length,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      width: itemWidth,
                                      alignment: Alignment.center,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          menuList[index].values.first,
                                          const SizedBox(height: 4),
                                          Text(
                                              menuList[index].keys.first),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const EditUserPage(),
                            ),
                          );
                        },
                        child: const Row(
                          mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Account settings",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Icon(Icons.chevron_right),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

             
                    Center(
                      child: GestureDetector(
                        onTap: _handleSignOut,
                        child: const Text(
                          'Sign out',
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
      ),
    );
  }
}
