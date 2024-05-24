import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:splitmycosts/common/add_item.dart';
import 'package:splitmycosts/models/app_state.dart';
import 'package:splitmycosts/models/contribution.dart';
import 'package:splitmycosts/models/expense.dart';

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
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ExpenseDetailsSection(),
        SizedBox(height: 10.0,),
        ExpenseAddSection(),
        SizedBox(height: 20.0,),
        ExpenseListSection(),
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
        var appState = context.read<AppState>();
        final String expenseName = _controller.text;
        appState.addExpense(expenseName);
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


class ExpenseListSection extends StatelessWidget {
  const ExpenseListSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 400.0,
        child: Consumer<AppState>(builder: (context, appState, child) {
          return ListView.separated(
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              return ExpenseItem(expense: appState.expenses[index], index: index);
            }, 
            separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 10,), 
            itemCount: appState.expenses.length
            );
        },),
      ),
    );
  }
}

class ExpenseItem extends StatelessWidget {
  const ExpenseItem({
    super.key,
    required this.expense,
    required this.index,
  });

  final Expense expense;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromARGB(255, 220, 203, 161),
      padding: EdgeInsets.all(10.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ExpenseItemHeader(expense: expense, index: index,),
          const SizedBox(height: 10.0,),
          ExpenseItemContributionSection(expense: expense),
        ],
      ));
  }
}

class ExpenseItemHeader extends StatelessWidget {
  const ExpenseItemHeader({
    super.key,
    required this.expense,
    required this.index,
  });

  final Expense expense;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(expense.expenseName),
        const Spacer(),
        Row(
          children: [
            SizedBox(width: 120.0, child: Text("Total Cost: ${expense.totalCost.toString()}")),
            const SizedBox(width: 5.0,),
            IconButton(
              onPressed: () {
                var appState = context.read<AppState>();
                appState.removeExpenseByIndex(index);
              },
              icon: const Icon(
                Icons.delete,
              ),
              color: Colors.red,
              iconSize: 16.0,
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(minWidth: 20.0, minHeight: 20.0),
            ),
          ],
        )
      ],
    );
  }
}


class ExpenseItemContributionSection extends StatelessWidget {
  const ExpenseItemContributionSection({
    super.key,
    required this.expense,
  });

  final Expense expense;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
        width: 400.0,
        color: const Color.fromARGB(255, 211, 200, 184),
        child: ListView.separated(
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            return ContributionItem(contribution: expense.contributions[index]);
          }, 
          separatorBuilder: (BuildContext context, int index) {
            return const Divider(
              color: Color.fromARGB(255, 153, 153, 147), 
              height: 0.0,
              indent: 5.0,
              endIndent: 5.0,
            );
          }, 
          itemCount: expense.contributions.length)
      ),
    );
  }
}

class ContributionItem extends StatelessWidget {
  const ContributionItem({
    super.key,
    required this.contribution,
  });

  final Contribution contribution;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        children: [
          Text(contribution.contributor.contributorName),
          Spacer(),
          Text(contribution.contributedAmount.toString())
        ],
      )
    );
  }
}