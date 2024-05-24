import 'package:flutter/material.dart';

class AddItemSection extends StatelessWidget {
  const AddItemSection({
    super.key,
    required this.inputLabel,
    required this.controller,
    required this.addBtnCallback,
    required this.errorMessage,
  });

  final String inputLabel;
  final TextEditingController controller;
  final void Function(BuildContext) addBtnCallback;
  final String? errorMessage;

  final double borderRadius = 5.0;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        AddItemTextInput(
          controller: controller, 
          addBtnCallback: addBtnCallback, 
          inputLabel: inputLabel, 
          borderRadius: borderRadius
        ),
        const SizedBox(width: 10.0,),
        AddItemButton(addBtnCallback: addBtnCallback, borderRadius: borderRadius),
        const SizedBox(width: 10.0,),
        if (errorMessage != null) Text(
          errorMessage!,
          style: const TextStyle(color: Colors.red),
        )
      ],
    );
  }
}

class AddItemButton extends StatelessWidget {
  const AddItemButton({
    super.key,
    required this.addBtnCallback,
    required this.borderRadius,
  });

  final void Function(BuildContext p1) addBtnCallback;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: () {addBtnCallback(context);},
      style: FilledButton.styleFrom(
          shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.all(Radius.circular(borderRadius)))),
      child: const Text("Add"),
    );
  }
}

class AddItemTextInput extends StatelessWidget {
  const AddItemTextInput({
    super.key,
    required this.controller,
    required this.addBtnCallback,
    required this.inputLabel,
    required this.borderRadius,
  });

  final TextEditingController controller;
  final void Function(BuildContext p1) addBtnCallback;
  final String inputLabel;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return Flexible(
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
    );
  }
}
