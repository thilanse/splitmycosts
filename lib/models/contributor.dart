import 'package:splitmycosts/models/transfer.dart';

class Contributor {
  
  final String contributorName;
  double totalSpent = 0.0;
  double totalCost = 0.0;
  double intermediateTransfer = 0.0; // this value is set only when a creditor does a transfer to another creditor
  double totalPaid = 0.0;

  List<Transfer> receivedTransfer = [];

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
  }

  void recordIntermediateTransfer(double amount) {
    intermediateTransfer = amount;
  }

  void recordPayment(double amount) {
    totalPaid = amount;
  }

  double get totalToReceive => totalSpent - totalCost;

  double get totalToPay => totalCost - totalSpent + totalPaid;

  double get totalReceived => receivedTransfer.fold(0, (previousValue, element) => previousValue + element.amount);

  double get totalLeft => totalSpent - totalReceived + intermediateTransfer;
}