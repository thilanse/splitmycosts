import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:splitmycosts/models/app_state.dart';
import 'package:splitmycosts/models/contributor.dart';

class AddItemSection extends StatefulWidget {
  const AddItemSection({
    super.key,
    required this.controller,
    required this.addBtnCallback,
    required this.inputLabel,
  });

  final TextEditingController controller;
  final void Function() addBtnCallback;
  final String inputLabel;

  @override
  State<AddItemSection> createState() => _AddItemSectionState();
}

class _AddItemSectionState extends State<AddItemSection> {

  final _controller = TextEditingController();
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
              controller: _controller,
              onSubmitted: (_) {
                widget.addBtnCallback();
              },
              style: Theme.of(context).textTheme.bodyMedium,
              decoration: InputDecoration(
                hintText: widget.inputLabel,
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
          onPressed: () {
            var appState = context.read<AppState>();
            final String contributorName = _controller.text;
            Contributor contributor = Contributor(contributorName: contributorName);
            appState.addContributor(contributor);
          
            // widget.addBtnCallback();
          },
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
