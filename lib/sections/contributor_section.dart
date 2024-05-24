import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:splitmycosts/common/add_item.dart';
import 'package:splitmycosts/models/app_state.dart';

class ContributorSection extends StatelessWidget {
  const ContributorSection({
    super.key,
    required this.deleteContributor,
  });

  final void Function(String) deleteContributor;

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ContributorDetailsSection(),
        SizedBox(height: 10.0,),
        ContributorAddSection(),
        SizedBox(height: 10.0,),
        ContributorListSection()
      ],
    );
  }
}

class ContributorDetailsSection extends StatelessWidget {
  const ContributorDetailsSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Contributors"),
        SizedBox(height: 10.0,),
        Text(
          "Contributors are all participants taking part in the event. For example, they can be all those going on a trip. The expenses will be split among all the contributors.",
          softWrap: true,
        ),
      ],
    );
  }
}

class ContributorAddSection extends StatefulWidget {
  const ContributorAddSection({
    super.key,
  });

  @override
  State<ContributorAddSection> createState() => _ContributorAddSectionState();
}

class _ContributorAddSectionState extends State<ContributorAddSection> {

  final _controller = TextEditingController();
  final String inputLabel = "Add contributor...";
  String? errorMessage;

  void addContributor(BuildContext context) {
    var appState = context.read<AppState>();
    final String contributorName = _controller.text;

    setState(() {
      errorMessage = appState.addContributor(contributorName);
    });
    
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return AddItemSection(
      inputLabel: inputLabel,
      controller: _controller,
      addBtnCallback: addContributor,
      errorMessage: errorMessage
      );
  }
}

class ContributorListSection extends StatelessWidget {
  const ContributorListSection({super.key,});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100.0,
      child: Consumer<AppState>(builder: (context, appState, child) {
        return ListView.separated(
            itemBuilder: (BuildContext context, int index) {
              return ContributorItem(name: appState.contributors[index].contributorName,);
            },
            separatorBuilder: (BuildContext context, int index) =>
                const SizedBox(height: 5.0),
            itemCount: appState.contributors.length);
      }),
    );
  }
}

class ContributorItem extends StatelessWidget {
  const ContributorItem({
    super.key,
    required this.name,
  });

  final String name;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () {
            var appState = context.read<AppState>();
            appState.removeContributor(name);
          },
          icon: const Icon(
            Icons.delete,
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
