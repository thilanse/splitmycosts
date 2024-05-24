class Contributor {
  
  final String contributorName;
  double totalSpent = 0.0;

  Contributor(this.contributorName);

  void updateContributedAmount(double oldAmount, double newAmount) {
    totalSpent = totalSpent - oldAmount + newAmount;
  }
}