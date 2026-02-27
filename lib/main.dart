import 'package:flutter/material.dart';
import 'web_shop_screen.dart';

void main() => runApp(const WebShopApp());

class WebShopApp extends StatelessWidget {
  const WebShopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Web Shop',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.orange,
        scaffoldBackgroundColor: const Color(0xFFF4F4F4),
      ),
      home: const WebShopScreen(),
    );
  }
}