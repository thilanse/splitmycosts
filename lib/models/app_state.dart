import 'package:flutter/cupertino.dart';
import 'package:splitmycosts/models/contributor.dart';

class AppState extends ChangeNotifier{

  final List<Contributor> _contributors = [
    Contributor(contributorName: "Thilan"),
    Contributor(contributorName: "Bula"),
    Contributor(contributorName: "Shasi"),
  ];

  List<Contributor> get contributors => _contributors;

  void addContributor(Contributor contributor) {
    if (!_contributors.contains(contributor)){
      _contributors.add(contributor);
      notifyListeners();
    }
  }

  void removeContributor(Contributor contributor) {
    if (_contributors.contains(contributor)) {
      _contributors.remove(contributor);
      notifyListeners();
    }
  }
}