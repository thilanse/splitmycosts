import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:splitmycosts/models/app_state.dart';
import 'package:splitmycosts/models/contributor.dart';

class ContributorSection extends StatelessWidget {
  const ContributorSection({
    super.key,
    required this.contributors,
    required this.addContributor,
    required this.deleteContributor,
    required this.controller,
  });

  final List<String> contributors;
  final void Function() addContributor;
  final void Function(String) deleteContributor;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Contributors"),
        const SizedBox(
          height: 10.0,
        ),
        const Text(
          "Contributors are all participants taking part in the event. For example, they can be all those going on a trip. The expenses will be split among all the contributors.",
          softWrap: true,
        ),
        const SizedBox(
          height: 10.0,
        ),
        AddItemSection(
          controller: controller,
          addBtnCallback: addContributor,
          inputLabel: "Add contributor...",
        ),
        const SizedBox(
          height: 10.0,
        ),
        SizedBox(
          height: 100.0,
          child: Consumer<AppState>(builder: (context, appState, child) {
            return ListView.separated(
                itemBuilder: (BuildContext context, int index) {
                  return ContributorItem(
                      name: appState.contributors[index].contributorName,
                      deleteContributor: deleteContributor);
                },
                separatorBuilder: (BuildContext context, int index) =>
                    const SizedBox(height: 5.0),
                itemCount: appState.contributors.length);
          }),
        )
        // ...contributors.map((e) => ContributorItem(name: e, deleteContributor: deleteContributor)),
      ],
    );
  }
}

class ContributorItem extends StatelessWidget {
  const ContributorItem({
    super.key,
    required this.name,
    required this.deleteContributor,
  });

  final String name;
  final void Function(String) deleteContributor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () {
            deleteContributor(name);
          },
          icon: const Icon(
            Icons.delete,
            // size: 15.0,
          ),
          color: Colors.red,
          iconSize: 15.0,
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(minWidth: 20.0, minHeight: 20.0),
        ),
        const SizedBox(width: 10.0),
        Text(name),
      ],
    );
  }
}

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

  void addItem(BuildContext context) {
    var appState = context.read<AppState>();
    final String contributorName = _controller.text;
    Contributor contributor = Contributor(contributorName: contributorName);
    appState.addContributor(contributor);
    _controller.clear();
  }

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
              onSubmitted: (_) {addItem(context);},
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
          onPressed: () {addItem(context);},
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
