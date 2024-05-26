import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:splitmycosts/models/app_state.dart';
import 'package:splitmycosts/sections/contributor_section.dart';
import 'package:splitmycosts/sections/expense_section.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SingleChildScrollView(
          child: Center(
            child: MultiProvider(providers: [
              ChangeNotifierProvider(
                create: (context) => AppState(),
              ),
            ], child: const ExpenseContributorApp()),
          ),
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

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 224, 216, 192),
      constraints: const BoxConstraints(
        minWidth: 400.0,
        maxWidth: 600.0,
      ),
      child: const Padding(
        padding: EdgeInsets.all(30.0),
        child: Column(
          children: [
            ContributorSection(),
            SizedBox(height: 20.0,),
            ExpenseSection(),
            SizedBox(height: 200.0,)
          ],
        ),
      ),
    );
  }
}
