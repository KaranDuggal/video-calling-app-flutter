import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  const Button({super.key,required this.title, required this.onTap});
  final String title;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Theme.of(context).colorScheme.secondary,
            boxShadow: [
              BoxShadow(
                blurRadius: 5,
                offset: const Offset(5.0,5.0),
                color: Theme.of(context).colorScheme.primary,
              ),
              BoxShadow(
                blurRadius: 10,
                offset: const Offset(3.0,3.0),
                color: Theme.of(context).colorScheme.primary,
              ),
            ]
        ),
        child: Center(
          child: Text(title,style: Theme.of(context).textTheme.displaySmall,),
        ),
      ),
    );
  }
}