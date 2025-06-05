import 'package:flutter/material.dart';

class CustomLoadingIndicator extends StatelessWidget {
  const CustomLoadingIndicator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      child: Center(
        child: CircularProgressIndicator(
          color: Colors.teal,
        ),
      ),
    );
  }
}
