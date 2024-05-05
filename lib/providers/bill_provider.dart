import 'package:flutter/material.dart';

class BillProvider extends ChangeNotifier {
  TextEditingController searchItemController = TextEditingController();
  TextEditingController get getsearchItemController => searchItemController;
}
