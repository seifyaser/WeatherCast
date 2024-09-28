import 'package:flutter/material.dart';

class align1 extends StatelessWidget {
  const align1({super.key});

  @override
  Widget build(BuildContext context) {
    return  Align(
  alignment: AlignmentDirectional(3,-0.3),
  child: Container(
    height: 300,
    width: 300,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: Colors.deepPurple
    ),
  ),
 );
  }
}

class align2 extends StatelessWidget {
  const align2({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
  alignment: AlignmentDirectional(-3,-0.3),
  child: Container(
    height: 300,
    width: 300,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: Colors.deepPurple
    ),
  ),
 );
  }

  
}

class align3 extends StatelessWidget {
  const align3({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
  alignment: AlignmentDirectional(0,-1.2),
  child: Container(
    height: 300,
    width: 300,
    decoration: BoxDecoration(
      color: Color(0xffffab40)
    ),
  ),
 );
  }
}