import 'package:flutter/material.dart';
import 'package:splitmycosts/common/add_item.dart';

class ExpenseSection extends StatelessWidget {
  const ExpenseSection(
      {super.key,
      required this.expenses,
      required this.addExpense,
      required this.removeExpense,
      required this.controller});

  final List<String> expenses;
  final void Function() addExpense;
  final void Function(String expense) removeExpense;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const ExpenseDetailsSection(),
        const SizedBox(height: 10.0,),
        const ExpenseAddSection(),
        const SizedBox(height: 10.0,),
        ...expenses.map((e) => Text(e))
      ],
    );
  }
}

class ExpenseDetailsSection extends StatelessWidget {
  const ExpenseDetailsSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Expenses"),
        SizedBox(height: 10.0,),
        Text("Add all expenses for the event. For each expense, you can add the contributed amount by each contributor. The checkboxes denote if the contributor took part in the expense. If someone opted out of participating in an expense, you can untick the checkbox for that contributor."),
      ],
    );
  }
}

class ExpenseAddSection extends StatefulWidget {
  const ExpenseAddSection({super.key,});

  @override
  State<ExpenseAddSection> createState() => _ExpenseAddSectionState();
}

class _ExpenseAddSectionState extends State<ExpenseAddSection> {
  
  final _controller = TextEditingController();
  final String inputLabel = "Add expense...";
  String? errorMessage;

  void addExpense(BuildContext context) {
    if (_controller.text.trim().isNotEmpty) {
      setState(() {
        // var appState = context.read<AppState>();
        // final String contributorName = _controller.text;
        // errorMessage = appState.addContributor(contributorName);
        _controller.clear();
      });
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return AddItemSection(
      inputLabel: inputLabel,
      controller: _controller,
      addBtnCallback: addExpense,
      errorMessage: errorMessage
      );
  }
}

