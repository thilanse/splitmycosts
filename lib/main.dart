import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: ExpenseContributorApp(),
        ),
      ),
    );
  }
}

class ExpenseContributorApp extends StatefulWidget {
  const ExpenseContributorApp({
    super.key,
  });

    @override
  State<ExpenseContributorApp> createState() => _ExpenseContributorAppState();
}

class _ExpenseContributorAppState extends State<ExpenseContributorApp> {

  final List<String> contributors = [];
  final List<String> expenses = [];

  final TextEditingController _contributorController = TextEditingController();
  final TextEditingController _expenseController = TextEditingController();

  void _addContributor() {
    final String contributorName = _contributorController.text;
    if (contributorName.isNotEmpty) {
      setState(() {
        contributors.add(contributorName);
      });
      _contributorController.clear();
    }
  }

  void _deleteContributor(String contributor) {
    if (contributors.contains(contributor)) {
      setState(() {
        contributors.remove(contributor);
      });
    }
  }

  void _addExpense() {
    final String expenseName = _expenseController.text;
    if (expenseName.isNotEmpty) {
      setState(() {
        expenses.add(expenseName);
      });
      _expenseController.clear();
    }
  }

  void _removeExpense(String expense) {
    if (expenses.contains(expense)) {
      setState(() {
        expenses.remove(expense);
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromARGB(255, 224, 216, 192),
      constraints: const BoxConstraints(
        minWidth: 400.0,
        maxWidth: 600.0,
      ),
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            ContributorSection(
              contributors: contributors,
              addContributor: _addContributor,
              deleteContributor: _deleteContributor,
              controller: _contributorController
            ),
            const SizedBox(height: 20.0,),
            ExpenseSection(
              expenses: expenses,
              addExpense: _addExpense,
              removeExpense: _removeExpense,
              controller: _expenseController
            ),
          ],
        ),
      ),
    );
  }
}

class ExpenseSection extends StatelessWidget {
  const ExpenseSection({
    super.key, 
    required this.expenses, 
    required this.addExpense, 
    required this.removeExpense, 
    required this.controller
  });

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
        const Text("Add all expenses for the event. For each expense, you can add the contributed amount by each contributor. The checkboxes denote if the contributor took part in the expense. If someone opted out of participating in an expense, you can untick the checkbox for that contributor."),
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
          child: ListView.separated(
            itemBuilder: (BuildContext context, int index) {
              return ContributorItem(name: contributors[index], deleteContributor: deleteContributor);
            },
            separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 5.0), 
            itemCount: contributors.length
          ),
        )
        // ...contributors.map((e) => ContributorItem(name: e, deleteContributor: deleteContributor)),
      ],
    );
  }
}

class AddItemSection extends StatelessWidget {
  const AddItemSection({
    super.key,
    required this.controller,
    required this.addBtnCallback,
    required this.inputLabel,
  });

  final TextEditingController controller;
  final void Function() addBtnCallback;
  final String inputLabel;

  final double borderRadius = 5.0;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 200.0, minWidth: 50.0,),
            child: TextField(
              controller: controller,
              onSubmitted: (_) {addBtnCallback();},
              style: Theme.of(context).textTheme.bodyMedium,
              decoration: InputDecoration(
                hintText: inputLabel,
                contentPadding: const EdgeInsets.all(10.0),
                isDense: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(borderRadius))
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 10.0,),
        FilledButton(
          onPressed: (){addBtnCallback();}, 
          style: FilledButton.styleFrom(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(borderRadius)))
          ),
          child: const Text("Add"),
        ),
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
          onPressed: () {deleteContributor(name);}, 
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
