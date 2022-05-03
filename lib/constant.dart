// STRINGS

import 'package:flutter/material.dart';

const baseUrl = "http://192.168.1.115/api";
const loginUrl = baseUrl + "/user/login";
const registerUrl = baseUrl + "/user/register";
const logoutUrl = baseUrl + "/user/logout";
const userUrl = baseUrl + "/user/user";

// ERRORS
const serverError = "Server error";
const unauthorized = "Unauthorized";
const somethingWentWrong = "Something went wrong, try again!";


// INPUT DECORATİON
InputDecoration kInputDecoration(String label, Icon icon) {
  return InputDecoration(
    labelText: label,
    
    contentPadding: const EdgeInsets.all(10),
    border: const OutlineInputBorder(borderSide: BorderSide(width: 1, color: Colors.pinkAccent)),
    prefixIcon: icon
  );
}

// TEXT BUTTON
TextButton kTextButton(String label, Function onPressed) {
  return TextButton(
    child: Text(label, style: const TextStyle(color: Colors.white),), 
    style: ButtonStyle(
      backgroundColor: MaterialStateColor.resolveWith((states) => Colors.pinkAccent.shade400),
      padding: MaterialStateProperty.resolveWith((states) => const EdgeInsets.symmetric(vertical: 10))
    ),
    onPressed: () => onPressed(),
  );
}

// LoginRegisterHint

Row kLoginRegisterHint(String text, String label, Function onTap) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(text),
      GestureDetector(
        child: Text(label, style: TextStyle(color: Colors.pinkAccent.shade400),),
        onTap: () => onTap(),
      )
    ],
  );
}