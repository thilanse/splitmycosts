import 'package:splitmycosts/models/contributor.dart';

class ExpenseSettler{

  List<Contributor> creditors = [];
  List<Contributor> debtors = [];

  void separateDebtorsFromCreditors(List<Contributor> contributors){
    for(Contributor contributor in contributors) {
      if (contributor.totalToReceive > 0) {
        creditors.add(contributor);
      } else {
        debtors.add(contributor);
      }
    }
  }

  void sortDebtorsAndCreditors() {
    creditors.sort((a, b) => b.totalToReceive.compareTo(a.totalToReceive));
    debtors.sort((a, b) => b.totalToPay.compareTo(a.totalToPay));
  }

  void settleTransfersOnlyDebtorsPay(List<Contributor> contributors) {

    separateDebtorsFromCreditors(contributors);
    sortDebtorsAndCreditors();

    // perform straight forward transactions from debtors to creditors
    for(Contributor creditor in creditors) {
      for(Contributor debtor in debtors) {
        if (debtor.canPay && creditor.canReceive && (debtor.totalToPay < creditor.totalToReceive)) {
          creditor.receiveTransfer(debtor, debtor.totalToPay);
        }
      }
    }

    // remove settled transfers
    creditors.removeWhere((element) => element.totalToReceive == 0.0);
    debtors.removeWhere((element) => element.totalToPay == 0.0);

    print(creditors);
  }


  // void settleTransfers() {
  //   // Debtors pay creditors where possible
  //   for(Contributor creditor in creditors) {
  //     for(Contributor debtor in debtors) {
  //       if (debtor.totalToPay > 0 && debtor.totalToPay <= creditor.totalToReceive) {
  //         creditor.receiveTransfer(debtor, debtor.totalToPay);
  //         debtor.recordPayment(debtor.totalToPay);
  //     }
  //     }
  //   }

  //   // remove settled transfers
  //   creditors.removeWhere((element) => element.totalLeft == 0.0);
  //   debtors.removeWhere((element) => element.totalToPay == 0.0);

  //   // creditors pay each other until one remains
  //   while(creditors.length > 1) {
  //     Contributor creditor = creditors.removeAt(0);
  //     creditor.receiveTransfer(creditors.last, creditor.totalLeft);
  //     creditors.last.recordIntermediateTransfer(creditor.totalLeft);
  //   }

  //   // assert(debtors.length == 1, "At this point, there should only be one debtor remaining");

  //   // settle final transfers
  //   for (Contributor debtor in debtors) {
  //     creditors.first.receiveTransfer(debtor, debtor.totalToPay);
  //   }

  //   creditors.clear();
  //   debtors.clear();
  // }
}