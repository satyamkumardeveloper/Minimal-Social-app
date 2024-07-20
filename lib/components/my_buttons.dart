import 'package:flutter/material.dart';

class MyButtons extends StatefulWidget {

  final String text;
  final void Function()? onTap;

  const MyButtons({
    super.key,
    required this.onTap,
    required this.text
    });

  @override
  State<MyButtons> createState() => _MyButtonsState();
}

class _MyButtonsState extends State<MyButtons> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(12),

      ),
      padding: const EdgeInsets.all(25),
      child: Center(
        child: Text(
          widget.text,
          style:const TextStyle( 
            fontWeight: FontWeight.bold,
            fontSize: 16
          ),
          ),
      ),
      ),
    );
  }
}