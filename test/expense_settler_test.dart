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

    test('should settle transfers for laser tag night', () {
      var contributor1 = Contributor('Omal');
      contributor1.updateContributedAmount(0, 7980); // Total spent: 100
      contributor1.updateTotalCost(4685); // Total cost: 50

      var contributor2 = Contributor('Mindula');
      contributor2.updateContributedAmount(0, 0); // Total spent: 30
      contributor2.updateTotalCost(4685); // Total cost: 70

      var contributor3 = Contributor('Saduni');
      contributor3.updateContributedAmount(0, 0); // Total spent: 120
      contributor3.updateTotalCost(4685); // Total cost: 50

      var contributor4 = Contributor('Bula');
      contributor4.updateContributedAmount(0, 30510); // Total spent: 30
      contributor4.updateTotalCost(4685); // Total cost: 100

      var contributor5 = Contributor('Thilan');
      contributor5.updateContributedAmount(0, 0); // Total spent: 30
      contributor5.updateTotalCost(4685); // Total cost: 150
      // contributor5.allowMultipleTransfers();

      var contributor6 = Contributor('Tharuka');
      contributor6.updateContributedAmount(0, 0); // Total spent: 100
      contributor6.updateTotalCost(4685); // Total cost: 50

      var contributor7 = Contributor('Jitha');
      contributor7.updateContributedAmount(0, 0); // Total spent: 30
      contributor7.updateTotalCost(1089); // Total cost: 70

      var contributor8 = Contributor('Chathu');
      contributor8.updateContributedAmount(0, 0); // Total spent: 120
      contributor8.updateTotalCost(1089); // Total cost: 50

      var contributor9 = Contributor('Shaki');
      contributor9.updateContributedAmount(0, 0); // Total spent: 30
      contributor9.updateTotalCost(4102); // Total cost: 100

      var contributor10 = Contributor('Pramodya');
      contributor10.updateContributedAmount(0, 0); // Total spent: 30
      contributor10.updateTotalCost(4102); // Total cost: 150

      var contributors = [contributor1, contributor2, contributor3, contributor4, contributor5, contributor6, contributor7, contributor8, contributor9, contributor10];
      var expenseSettler = ExpenseSettler();

      // expenseSettler.separateDebtorsFromCreditors(contributors);
      // expenseSettler.sortDebtorsAndCreditors();
      expenseSettler.settleTransfersOnlyDebtorsPay(contributors);

      expect(contributor1.receivedTransfer.length, 1);
      expect(contributor2.receivedTransfer.length, 0);
      expect(contributor3.receivedTransfer.length, 0);
      expect(contributor4.receivedTransfer.length, 8);
      expect(contributor5.receivedTransfer.length, 0);
      expect(contributor6.receivedTransfer.length, 0);
      expect(contributor7.receivedTransfer.length, 0);
      expect(contributor8.receivedTransfer.length, 0);
      expect(contributor9.receivedTransfer.length, 0);
      expect(contributor10.receivedTransfer.length, 0);

      expect(contributor1.receivedTransfer.first.contributor, contributor5);

      expect(contributor4.receivedTransfer[0].contributor, contributor2);
      expect(contributor4.receivedTransfer[1].contributor, contributor3);
      expect(contributor4.receivedTransfer[2].contributor, contributor5);
      expect(contributor4.receivedTransfer[3].contributor, contributor6);
      expect(contributor4.receivedTransfer[4].contributor, contributor9);
      expect(contributor4.receivedTransfer[5].contributor, contributor7);
      expect(contributor4.receivedTransfer[6].contributor, contributor8);
      expect(contributor4.receivedTransfer[7].contributor, contributor10);


    });
  });
}
