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
        const Text("Expenses"),
        const SizedBox(
          height: 10.0,
        ),
        const Text(
            "Add all expenses for the event. For each expense, you can add the contributed amount by each contributor. The checkboxes denote if the contributor took part in the expense. If someone opted out of participating in an expense, you can untick the checkbox for that contributor."),
        const SizedBox(
          height: 10.0,
        ),
        AddItemSection(
          controller: controller,
          addBtnCallback: addExpense,
          inputLabel: "Add expense...",
        ),
        const SizedBox(
          height: 10.0,
        ),
        ...expenses.map((e) => Text(e))
      ],
    );
  }
}

