import 'package:flutter/material.dart';

class AddItemSection extends StatelessWidget {
  const AddItemSection({
    super.key,
    required this.inputLabel,
    required this.controller,
    required this.addBtnCallback,
  });

  final String inputLabel;
  final TextEditingController controller;
  final void Function(BuildContext) addBtnCallback;

  final double borderRadius = 5.0;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          child: Container(
            constraints: const BoxConstraints(
              maxWidth: 200.0,
              minWidth: 50.0,
            ),
            child: TextField(
              controller: controller,
              onSubmitted: (_) {addBtnCallback(context);},
              style: Theme.of(context).textTheme.bodyMedium,
              decoration: InputDecoration(
                hintText: inputLabel,
                contentPadding: const EdgeInsets.all(10.0),
                isDense: true,
                border: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.all(Radius.circular(borderRadius))),
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 10.0,
        ),
        FilledButton(
          onPressed: () {addBtnCallback(context);},
          style: FilledButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.all(Radius.circular(borderRadius)))),
          child: const Text("Add"),
        ),
      ],
    );
  }
}
