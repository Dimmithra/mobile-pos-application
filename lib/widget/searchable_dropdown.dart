import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';

class CommonDropdownField extends StatelessWidget {
  const CommonDropdownField({
    super.key,
    required this.jobRoleCtrl,
    required this.hintText,
    required this.items,
    this.onChanged,
    this.padding = 8,
    this.validateOnChange = true,
    this.closedSuffixIcon,
  });

  final TextEditingController jobRoleCtrl;
  final String hintText;
  final List<String>? items;
  final dynamic Function(String)? onChanged;
  final double padding;
  final bool validateOnChange;
  final Widget? closedSuffixIcon;
  @override
  Widget build(BuildContext context) {
    return CustomDropdown.search(
      errorText: '$hintText is Required',
      excludeSelected: false,
      fillColor: Colors.grey.shade400,
      borderSide: const BorderSide(color: Colors.black54, width: 1),
      hintStyle: const TextStyle(
        color: Colors.black,
      ),
      fieldSuffixIcon: Icon(
        Icons.arrow_drop_down_circle_outlined,
        color: Colors.indigo.shade900,
      ),
      selectedStyle: const TextStyle(
        color: Colors.black,
      ),
      hintText: hintText,
      // listItemStyle: TextStyle(backgroundColor: kErrorColor),
      items: items,
      controller: jobRoleCtrl,
      onChanged: onChanged,
    );
  }
}
