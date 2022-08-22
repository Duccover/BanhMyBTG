import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodbany/providers/googleSignInProvider.dart';
import 'package:provider/provider.dart';
class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          'Hồ sơ của tôi',
          style: TextStyle(fontSize: 18),
        ),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                height: 100,
                color: Colors.orange,
              ),
              Container(
                height: MediaQuery.of(context).size.height / 1.44,
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30))),
                child: ListView(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          width: 250,
                          height: 80,
                          padding: const EdgeInsets.only(left: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    user.displayName!,
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  user != null ? Text(user.email!) : Text('')
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    const ListTile(
                      leading: Icon(Icons.location_on_outlined),
                      title: Text('Địa chỉ của tôi'),
                      trailing: Icon(Icons.keyboard_arrow_right_outlined),
                    ),
                    ListTile(
                      leading: const Icon(Icons.exit_to_app),
                      title: const Text('Đăng xuất'),
                      onTap: () {
                        var provider = Provider.of<GoogleSignInProvider>(
                            context,
                            listen: false);
                        provider.logOut();
                        Navigator.pop(context);
                      }
                    ),
                  ],
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 40, left: 30),
            child: CircleAvatar(
              radius: 50,
              child: CircleAvatar(
                radius: 48,
                backgroundImage: NetworkImage(user.photoURL!),
              ),
            ),
          )
        ],
      ),
    );
  }
}
