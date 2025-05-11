import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text('Welcome Salah',style: TextStyle(fontSize: 15),),
        SizedBox(
          width: 10,
        ),
        CircleAvatar(
          radius: 20,
          backgroundImage: AssetImage('assets/images/1ef5e14e555e2193d62304c0ae4a1e8c.JPG'),),


      ],
    );
  }
}
