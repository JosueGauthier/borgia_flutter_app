import 'package:flutter/material.dart';

Widget buildTextFields() => Padding(
      padding: const EdgeInsets.all(35),
      child: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildTextField1(),
            heightSpacer(15),
            buildTextField2(),
            heightSpacer(15),
            buildTextField3(),
            heightSpacer(15),
            buildTextField4(),
            heightSpacer(15),
            buildTextField5(),
          ],
        ),
      ),
    );

Widget buildTextField1() => TextFormField(
    decoration: const InputDecoration(
        border: InputBorder.none,
        prefixIcon: Icon(
          Icons.person,
          color: Colors.teal,
        ),
        hintText: 'Enter your Name',
        hintStyle: TextStyle(color: Colors.teal)));

Widget buildTextField2() => TextFormField(
      decoration: const InputDecoration(
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.orange),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.orange,
          ),
        ),
        prefixIcon: Icon(
          Icons.person,
          color: Colors.orange,
        ),
        hintText: "Enter your Name",
        hintStyle: TextStyle(color: Colors.orange),
      ),
    );

Widget buildTextField3() => TextFormField(
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.circular(5.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.circular(5.5),
        ),
        prefixIcon: const Icon(Icons.person, color: Colors.blue),
        hintText: "Enter your Name",
        hintStyle: const TextStyle(color: Colors.blue),
        filled: true,
        fillColor: Colors.blue[50],
      ),
    );

Widget buildTextField4() => TextFormField(
      decoration: InputDecoration(
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.green),
        ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.green,
          ),
        ),
        prefixIcon: const Icon(
          Icons.person,
          color: Colors.green,
        ),
        filled: true,
        fillColor: Colors.green[50],
        labelText: "Enter your Name",
        labelStyle: const TextStyle(color: Colors.green),
      ),
    );

Widget buildTextField5() => TextFormField(
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red),
          borderRadius: BorderRadius.circular(5.5),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.red,
          ),
        ),
        prefixIcon: const Icon(
          Icons.person,
          color: Colors.red,
        ),
        filled: true,
        fillColor: Colors.red[50],
        labelText: "Enter your Name",
        labelStyle: const TextStyle(color: Colors.red),
      ),
    );

Widget heightSpacer(double myHeight) => SizedBox(height: myHeight);
