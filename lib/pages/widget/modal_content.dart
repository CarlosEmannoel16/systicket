import 'package:flutter/material.dart';

class ModalContent extends StatelessWidget {
  const ModalContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: const Center(
        child: Text('Conteúdo do modal'),
      ),
    );
  }
}
