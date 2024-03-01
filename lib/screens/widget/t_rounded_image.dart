import 'package:flutter/material.dart';

class TRoundedImage extends StatelessWidget {
  const TRoundedImage({
    Key? key,
    this.padding,
    required this.imageUrl,
    this.fit = BoxFit.scaleDown,
    required this.heading,
    required this.caption,
  }) : super(key: key);

  final String imageUrl;
  final BoxFit fit;
  final EdgeInsetsGeometry? padding;
  final String heading;
  final String caption;

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.only(left: 20, right: 20), 
    child: Column(
      children: [
        Image.asset(
          imageUrl,
          fit: fit,
        ),
        Text(
          heading,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Padding(padding: const EdgeInsets.only(top:12),
        child: Text(
          caption,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 14,
          ),
        ),)
      ],
      ),
    );
  }
}
