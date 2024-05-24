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

  void removeContributor(String contributorName) {
    for (Contributor contributor in _contributors){
      if (contributor.contributorName == contributorName){
        _contributors.remove(contributor);
        notifyListeners();
        break;
      }
    }
  }
}