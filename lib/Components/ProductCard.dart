import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final String? name;
  final ImageProvider? bgImage;
  final Color? bgColor;
  final VoidCallback onPressed;

  const ProductCard({
    Key? key,
    this.name,
    this.bgImage,
    required this.onPressed,
    this.bgColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: bgColor,
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Colors.black.withOpacity(0.5),
          ),
          child: Center(
            child: Text(
              name!,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
