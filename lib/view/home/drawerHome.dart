import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:foodbany/view/reviewCart/reviewCart.dart';
import 'package:flutter/material.dart';
import 'package:foodbany/view/support/support.dart';
import 'package:foodbany/view/wishList/wishList.dart';
import 'package:provider/provider.dart';
import '../../providers/facebookSignInProvider.dart';
import '../myProfile/profilePage.dart';

class DrawerHome extends StatelessWidget {
  const DrawerHome({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return ListView(
      children: [
        DrawerHeader(
            child: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.orange,
              radius: 50,
              child: CircleAvatar(
                radius: 48,
                backgroundImage: user != null
                    ? NetworkImage(user.photoURL!)
                    : NetworkImage(
                        'https://cdn.tgdd.vn/Products/Images/8788/272179/bhx/dua-hau-khong-hat-trai-tu-3kg-tro-len-202206131005175915.jpg'),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                user != null ?Text(
                  user.displayName!,
                  style: const TextStyle(fontSize: 20),
                ): Text('Welcome to BTG'),
                user != null ? Text(user.email!) : Text('nike123')
              ],
            )
          ],
        )),
        ListTile(
          leading: const Icon(Icons.home_outlined, size: 32),
          title: const Text(
            'Trang chủ',
            style: TextStyle(fontSize: 20, color: Colors.black),
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        ListTile(
          leading: const Icon(Icons.person_off_outlined, size: 32),
          title: const Text(
            'Hồ sơ',
            style: TextStyle(fontSize: 20, color: Colors.black),
          ),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ProfilePage(),
                ));
          },
        ),
        ListTile(
          leading: const Icon(Icons.shop_outlined, size: 32),
          title: const Text(
            'Giỏ hàng',
            style: TextStyle(fontSize: 20, color: Colors.black),
          ),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ReviewCart(),
                ));
          },
        ),
        ListTile(
          leading: const Icon(Icons.favorite_outline, size: 32),
          title: const Text(
            'Yêu thích',
            style: TextStyle(fontSize: 20, color: Colors.black),
          ),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => WishList(),
                ));
          },
        ),
        ListTile(
          leading: const Icon(Icons.star_outline, size: 32),
          title: const Text(
            'Liên hệ hỗ trợ',
            style: TextStyle(fontSize: 20, color: Colors.black),
          ),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Support(),
                ));
          },
        ),
      ],
    );
  }
}
