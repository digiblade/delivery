import 'package:delivery/Components/ProductCard.dart';
import 'package:flutter/material.dart';

class HorizontalSlider extends StatefulWidget {
  HorizontalSlider({Key? key}) : super(key: key);

  @override
  _HorizontalSliderState createState() => _HorizontalSliderState();
}

class _HorizontalSliderState extends State<HorizontalSlider> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Row(
        children: [
          ProductCard(
            onPressed: () {},
            bgImage: Image.asset("assets/background.jpg").image,
          ),
          ProductCard(
            onPressed: () {},
            bgImage: Image.asset("assets/background.jpg").image,
          ),
          ProductCard(
            onPressed: () {},
            bgImage: Image.asset("assets/background.jpg").image,
          ),
          ProductCard(
            onPressed: () {},
            bgImage: Image.asset("assets/background.jpg").image,
          ),
          ProductCard(
            onPressed: () {},
            bgImage: Image.asset("assets/background.jpg").image,
          ),
          ProductCard(
            onPressed: () {},
            bgImage: Image.asset("assets/background.jpg").image,
          ),
        ],
      ),
    );
  }
}
