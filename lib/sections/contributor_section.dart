import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:splitmycosts/common/add_item.dart';
import 'package:splitmycosts/models/app_state.dart';
import 'package:splitmycosts/models/contributor.dart';

class ContributorSection extends StatelessWidget {
  const ContributorSection({super.key,});

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
    if (_controller.text.trim().isNotEmpty) {
      setState(() {
        var appState = context.read<AppState>();
        final String contributorName = _controller.text;
        errorMessage = appState.addContributor(contributorName);
        _controller.clear();
      });
    } else {
      setState(() {
        errorMessage = null;
      });
    }
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
      // height: 100.0,
      child: Consumer<AppState>(builder: (context, appState, child) {
        return ListView.separated(
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              return ContributorItem(contributor: appState.contributors[index],);
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
    required this.contributor,
  });

  final Contributor contributor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () {
            var appState = context.read<AppState>();
            appState.removeContributor(contributor.contributorName);
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
        Text(contributor.contributorName),
        const Spacer(),
        Text("Total Spent: ${contributor.totalSpent}"),
        const SizedBox(width: 10.0),
        Text("Total Cost: ${contributor.totalCost}"),
      ],
    );
  }
}
