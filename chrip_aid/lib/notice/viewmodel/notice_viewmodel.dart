import 'package:flutter/material.dart';

class NoticeViewModel extends ChangeNotifier {
  bool isDonationChecked = false;
  bool isPersonalInfoChecked = false;
  bool isTaxBenefitChecked = false;
  bool isContactInfoChecked = false;

  bool get isAllChecked =>
      isDonationChecked &&
          isPersonalInfoChecked &&
          isTaxBenefitChecked &&
          isContactInfoChecked;

  void updateDonationChecked(bool value) {
    isDonationChecked = value;
    notifyListeners();
  }

  void updatePersonalInfoChecked(bool value) {
    isPersonalInfoChecked = value;
    notifyListeners();
  }

  void updateTaxBenefitChecked(bool value) {
    isTaxBenefitChecked = value;
    notifyListeners();
  }

  void updateContactInfoChecked(bool value) {
    isContactInfoChecked = value;
    notifyListeners();
  }
}
