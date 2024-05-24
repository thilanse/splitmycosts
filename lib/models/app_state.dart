import 'package:flutter/cupertino.dart';
import 'package:splitmycosts/models/contributor.dart';

class AppState extends ChangeNotifier{

  final List<Contributor> _contributors = [];

  List<Contributor> get contributors => _contributors;

  String? addContributor(String contributorName) {
    bool alreadyExists = _contributors.any((c) => c.contributorName == contributorName);
    
    if (alreadyExists){
      return "$contributorName already added!";
    }

    Contributor contributor = Contributor(contributorName: contributorName);
    _contributors.add(contributor);
    notifyListeners();
    return null;
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