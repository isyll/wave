import 'package:flutter/material.dart';

class PrefixSearchField extends StatelessWidget {
  final Widget? prefix;
  final String? hintText;
  final TextEditingController? controller;

  const PrefixSearchField(
      {super.key, required this.prefix, this.hintText, this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
          border: Border.all(width: 1, color: Colors.black.withOpacity(0.25)),
          borderRadius: BorderRadius.circular(8)),
      child: Row(
        children: [
          const Icon(Icons.search, size: 32),
          if (prefix != null) prefix!,
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  focusedErrorBorder: InputBorder.none,
                  border: InputBorder.none,
                  isDense: true,
                  hintText: hintText,
                  hintStyle: TextStyle(
                      fontWeight: FontWeight.normal,
                      color: Colors.black.withOpacity(0.4))),
            ),
          )
        ],
      ),
    );
  }
}
