import 'package:flutter/material.dart';

class CustomWidget<T> extends StatelessWidget {
  final T value;
  final T groupValue;
  final Widget leading;
  final ValueChanged<T?> onChanged;

  const CustomWidget({super.key,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    required this.leading,
  });
//
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onChanged(value),
      child: Row(
        children: [
          _customRadioButton,
        ],
      ),
    );
  }

  Widget get _customRadioButton {
    final isSelected = value == groupValue;
    return Container(
      padding:const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xff0F172A) : Colors.white,
        borderRadius: BorderRadius.circular(4),
      ),
      child: leading,
    );
  }
}