import 'package:flutter/material.dart';

Widget dropDownItem(List<DropdownMenuItem<String>> dropdownPlaces,
    BuildContext context, String hint, onValueChanged) {
  return Container(
    padding: EdgeInsets.only(right: 20),
    child: Theme(
      data: Theme.of(context).copyWith(
          canvasColor: Colors.amber[200],
          dropdownMenuTheme: DropdownMenuThemeData(
              menuStyle: MenuStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.amber[200]),
                  elevation: MaterialStatePropertyAll(10),
                  shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      side: BorderSide.none))))),
      child: DropdownButtonFormField(
        items: dropdownPlaces,
        onChanged: onValueChanged,
        alignment: Alignment.centerLeft,
        elevation: 10,
        hint: Text(hint),
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(17.5),
              borderSide: BorderSide.none),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(17.5),
              borderSide: BorderSide.none),
          fillColor: Colors.amber[200],
          filled: true,
        ),
      ),
    ),
  );
}
