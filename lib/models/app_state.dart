import 'package:flutter/cupertino.dart';
import 'package:splitmycosts/models/contribution.dart';
import 'package:splitmycosts/models/contributor.dart';
import 'package:splitmycosts/models/expense.dart';

class AppState extends ChangeNotifier{

  final List<Contributor> _contributors = [
    Contributor("Thilan"), Contributor("Bula")
  ];
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
    addNewContributorToAllExpenses(contributor);
    notifyListeners();
    return null;
  }

  void removeContributor(String contributorName) {
    _contributors.removeWhere((c) => c.contributorName == contributorName);
    removeContributorFromAllExpenses(contributorName);
    notifyListeners();
  }

  void addNewContributorToAllExpenses(Contributor contributor) {
    for (Expense expense in _expenses) {
      Contribution contribution = Contribution(contributor);
      expense.addContribution(contribution);
    }
  }

  void removeContributorFromAllExpenses(String contributorName) {
    for (Expense expense in _expenses) {
      expense.contributions.removeWhere((contribution) => contribution.contributor.contributorName == contributorName);
    }
  }

  void addExpense(String expenseName) {
    Expense expense = Expense(expenseName);
    for(Contributor contributor in _contributors) {
      Contribution contribution = Contribution(contributor);
      expense.addContribution(contribution);
    }
    _expenses.add(expense);
    notifyListeners();
  }

  void removeExpenseByIndex(int index) {
    _expenses[index].removeAllContributions();
    _expenses.removeAt(index);
    notifyListeners();
  }

  void updateContributionAmount(int expenseIndex, int contributionIndex, double newAmount) {
    _expenses[expenseIndex].contributions[contributionIndex].updateContributedAmount(newAmount);
    notifyListeners();
  }
}