import 'package:test/test.dart';
import 'package:splitmycosts/models/contributor.dart';
import 'package:splitmycosts/services/expense_settler.dart';

void main() {
  group('ExpenseSettler', () {
    test('should separate debtors and creditors correctly', () {
      var contributor1 = Contributor('Alice');
      contributor1.updateContributedAmount(0, 100); // Total spent: 100

      var contributor2 = Contributor('Bob');
      contributor2.updateTotalCost(50); // Total cost: 50

      var contributor3 = Contributor('Charlie');
      contributor3.updateContributedAmount(0, 70); // Total spent: 70
      contributor3.updateTotalCost(100); // Total cost: 100

      var contributors = [contributor1, contributor2, contributor3];
      var expenseSettler = ExpenseSettler();

      expenseSettler.separateDebtorsFromCreditors(contributors);

      expect(expenseSettler.creditors, contains(contributor1));
      expect(expenseSettler.debtors, contains(contributor2));
      expect(expenseSettler.debtors, contains(contributor3));
    });

    test('should sort debtors and creditors correctly', () {
      var contributor1 = Contributor('Alice');
      contributor1.updateContributedAmount(0, 100); // Total spent: 100
      contributor1.updateTotalCost(50); // Total cost: 50

      var contributor2 = Contributor('Bob');
      contributor2.updateContributedAmount(0, 30); // Total spent: 30
      contributor2.updateTotalCost(70); // Total cost: 70

      var contributor3 = Contributor('Tom');
      contributor3.updateContributedAmount(0, 120); // Total spent: 120
      contributor3.updateTotalCost(50); // Total cost: 50

      var contributor4 = Contributor('Alan');
      contributor4.updateContributedAmount(0, 30); // Total spent: 30
      contributor4.updateTotalCost(100); // Total cost: 100

      var contributor5 = Contributor('Charlie');
      contributor5.updateContributedAmount(0, 30); // Total spent: 30
      contributor5.updateTotalCost(150); // Total cost: 150

      var contributors = [contributor1, contributor2, contributor3, contributor4, contributor5];
      var expenseSettler = ExpenseSettler();

      expenseSettler.separateDebtorsFromCreditors(contributors);
      expenseSettler.sortDebtorsAndCreditors();

      expect(expenseSettler.creditors[0], contributor3);
      expect(expenseSettler.creditors[1], contributor1);
      expect(expenseSettler.debtors[0], contributor5);
      expect(expenseSettler.debtors[1], contributor4);
      expect(expenseSettler.debtors[2], contributor2);
    });

    test('should settle transfers correctly', () {
      var contributor1 = Contributor('Alice');
      contributor1.updateContributedAmount(0, 900); // Total spent: 100
      contributor1.updateTotalCost(400); // Total cost: 50

      var contributor2 = Contributor('Bob');
      contributor2.updateContributedAmount(0, 300); // Total spent: 30
      contributor2.updateTotalCost(400); // Total cost: 70

      var contributor3 = Contributor('Charlie');
      contributor3.updateContributedAmount(0, 0); // Total spent: 20
      contributor3.updateTotalCost(400); // Total cost: 30

      var contributors = [contributor1, contributor2, contributor3];
      var expenseSettler = ExpenseSettler();

      expenseSettler.separateDebtorsFromCreditors(contributors);
      expenseSettler.sortDebtorsAndCreditors();
      expenseSettler.settleTransfers();

      expect(contributor1.totalLeft, 0);
      expect(contributor2.totalToPay, 0);
      expect(contributor3.totalToPay, 0);
    });
  });
}
