import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(color: Colors.black),
          BoxShadow(color: Colors.black),
          BoxShadow(color: Colors.black),
        ],
        borderRadius: BorderRadius.circular(16),
        image: DecorationImage(
          image: Image.asset("assets/background.jpg").image,
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.black.withOpacity(0.5),
        ),
        child: Center(
          child: Text(
            "CheckUser",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
