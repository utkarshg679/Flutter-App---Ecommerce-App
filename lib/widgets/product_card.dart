import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final String imageUrl ;
  final String name;
  final double price;
  final Color backgroundColor;
  const ProductCard({super.key,required this.imageUrl, required this.name, required this.price, required this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color:backgroundColor,

      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(name, style: Theme.of(context).textTheme.titleMedium),
            Text('$price', style:Theme.of(context).textTheme.bodySmall),
            Center(child: Image(image: AssetImage(imageUrl),height: 180)),
            
          ],
        ),
      ),
    );
  }
}