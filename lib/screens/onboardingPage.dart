import 'package:flutter/material.dart';
import 'package:fjeje_timbu/constants/colors.dart';

class OnBoardingPage extends StatefulWidget {
  final dynamic image;
  final String title, subtitle;

  const OnBoardingPage({
    super.key,
    this.image,
    required this.title,
    required this.subtitle,
  });

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        widget.image is String
            ? Image.asset(
                widget.image,
                width: 150,
                height: 150,
                fit: BoxFit.cover,
              )
            : Icon(
                widget.image as IconData,
                color: colorPrimary,
                size: 150,
              ),
        const SizedBox(height: 40),
        Text(
          widget.title.toUpperCase(),
          style: const TextStyle(
              color: colorPrimary, fontSize: 18.0, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            widget.subtitle,
            style: const TextStyle(color: colorPrimary, fontSize: 14.0),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
