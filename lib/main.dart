import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:foodbany/auth/signIn.dart';
import 'package:foodbany/providers/checkOutProvider.dart';
import 'package:foodbany/providers/facebookSignInProvider.dart';
import 'package:foodbany/providers/googleSignInProvider.dart';
import 'package:foodbany/providers/productProvider.dart';
import 'package:foodbany/providers/reviewCartProvider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:foodbany/providers/wishListProvider.dart';
import 'package:foodbany/view/home/homePage.dart';
import 'package:foodbany/view/image/home.dart';
import 'package:provider/provider.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
  configLoading();
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.yellow
    ..backgroundColor = Colors.green
    ..indicatorColor = Colors.yellow
    ..textColor = Colors.yellow
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = true
    ..dismissOnTap = false;
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => ProductProvider()),
          ChangeNotifierProvider(create: (_) => ReviewCartProvider()),
          ChangeNotifierProvider(create: (_) => GoogleSignInProvider()),
          ChangeNotifierProvider(create: (_) => FacebookSignInProvider()),
          ChangeNotifierProvider(create: (_) => WishListProvider()),
          ChangeNotifierProvider(create: (_) => CheckOutProvider())
        ],
        child: MaterialApp(
            theme: ThemeData(primarySwatch: Colors.orange),
            builder: EasyLoading.init(),
            debugShowCheckedModeBanner: false,
            home: StreamBuilder(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, snap) {
                if (snap.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snap.hasError) {
                  return const Center(
                    child: Text('Something went Wrong'),
                  );
                } else if (snap.hasData) {
                  return const HomePick();
                } else {
                  return const SignIn();
                }
              },
            )));
  }
}
