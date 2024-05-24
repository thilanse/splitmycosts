import 'package:splitmycosts/models/contribution.dart';

class Expense {

  String expenseName;
  final List<Contribution> _contributions = [];

  Expense(this.expenseName);

  List<Contribution> get contributions => _contributions;

  void addContribution(Contribution contribution) {
    _contributions.add(contribution);
  }

  void updateContribution(int index, double newAmount) {
    _contributions[index].updateContributedAmount(newAmount);
  }

  double get totalCost => _contributions.fold<double>(0, (prev, value) => prev + value.contributedAmount);
}