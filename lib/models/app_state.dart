import 'package:flutter/cupertino.dart';
import 'package:splitmycosts/models/contribution.dart';
import 'package:splitmycosts/models/contributor.dart';
import 'package:splitmycosts/models/expense.dart';

class AppState extends ChangeNotifier{

  final List<Contributor> _contributors = [];
  final List<Expense> _expenses = [];

  AppState() {
    addExpense("Fuel");
    addExpense("Dinner");
    addExpense("Hotel");
  }

  List<Contributor> get contributors => _contributors;

  List<Expense> get expenses => _expenses;

  String? addContributor(String contributorName) {

    String contributorNameFormatted = contributorName.toLowerCase().trim();

    bool alreadyExists = _contributors.any((c) => c.contributorName == contributorNameFormatted);

    if (alreadyExists){
      return "$contributorName already added!";
    }

    Contributor contributor = Contributor(contributorNameFormatted);
    _contributors.add(contributor);
    notifyListeners();
    return null;
  }

  void removeContributor(String contributorName) {
    for (Contributor contributor in _contributors){
      if (contributor.contributorName == contributorName){
        _contributors.remove(contributor);
        notifyListeners();
        break;
      }
    }
  }

  void addExpense(String expenseName) {
    Expense expense = Expense(expenseName);
    for(Contributor contributor in _contributors) {
      Contribution contribution = Contribution(contributor);
      expense.addContribution(contribution);
    }
    _expenses.add(expense);
  }
}