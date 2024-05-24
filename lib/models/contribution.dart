import 'package:splitmycosts/models/contributor.dart';

class Contribution {
  Contributor contributor;
  double contributedAmount = 0.0;
  bool hasContributed = true;

  Contribution(this.contributor);

  void updateContributedAmount (double newAmount) {
    contributor.updateContributedAmount(contributedAmount, newAmount);
    contributedAmount = newAmount;
  }

  void toggleHasContributed() {
    if (hasContributed) {
      hasContributed = false;
      updateContributedAmount(0.0); // reset to zero if not contributed
    } else {
      hasContributed = true;
    }
  }
}