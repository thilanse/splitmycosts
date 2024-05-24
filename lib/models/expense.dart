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

  void removeAllContributions() {
    for (Contribution contribution in _contributions) {
      contribution.updateContributedAmount(0.0);
    }
  }

  double get totalCost => _contributions.fold<double>(0, (prev, value) => prev + value.contributedAmount);

  int get participants => _contributions.where((c) => c.hasContributed).length;

  double get costPerPerson {
    return (participants > 0)? totalCost / participants: 0.0;
  }
}