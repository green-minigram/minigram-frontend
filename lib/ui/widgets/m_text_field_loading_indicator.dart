import 'package:flutter/material.dart';
import 'package:minigram/_core/styles/m_color.dart';

class MTextFieldLoadingIndicator extends StatelessWidget {
  const MTextFieldLoadingIndicator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 18,
      height: 18,
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(MColor.kText.normal),
        ),
      ),
    );
  }
}
