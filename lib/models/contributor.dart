import 'package:splitmycosts/models/transfer.dart';

class Contributor {
  
  final String contributorName;
  double totalSpent = 0.0;
  double totalCost = 0.0;

  List<Transfer> receivedTransfer = [];
  List<double> payments = [];

  Contributor(this.contributorName);

  void updateContributedAmount(double oldAmount, double newAmount) {
    totalSpent = totalSpent - oldAmount + newAmount;
  }

  void resetTotalCost(){
    totalCost = 0.0;
  }

  void updateTotalCost(double newtotalCost) {
    totalCost += newtotalCost;
  }

  void receiveTransfer(Contributor contributor, double amount){
    Transfer transfer = Transfer(contributor, amount);
    receivedTransfer.add(transfer);
    contributor.recordPayment(amount);
  }

  void recordPayment(double amount) {
    payments.add(amount);
  }

  double get totalReceived => receivedTransfer.fold(0, (previousValue, element) => previousValue + element.amount);

  double get totalPaid => (payments.length > 0)? payments.reduce((a, b) => a + b): 0.0;

  double get totalToReceive => totalSpent - totalCost - totalReceived + totalPaid;

  double get totalToPay => totalCost - totalSpent - totalPaid;

  bool get canPay => totalToPay > 0;

  bool get canReceive => totalToReceive > 0;
}