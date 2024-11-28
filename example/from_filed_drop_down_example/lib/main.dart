import 'package:flutter/material.dart';
import 'package:from_filed_drop_down/from_filed_drop_down.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const DropDownClass(),
    );
  }
}

class DropDownClass extends StatefulWidget {
  const DropDownClass({super.key});

  @override
  State<DropDownClass> createState() => _DropDownClassState();
}

class _DropDownClassState extends State<DropDownClass> {
  final dropdownController = OverlayPortalController();
  final textController = TextEditingController();
  String? selectedDropDownValue;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: DropdownTextField<String>(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          controller: dropdownController,
          textController: textController,
          overlayHeight: 210,
          initialItem: selectedDropDownValue,
          item : const ["item","item2","item3"],
          textStyle: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400
          ),
          menuDecoration: BoxDecoration(
              color: Colors.black26,
              borderRadius: BorderRadius.circular(4),
              border: Border.all(
                  color: Colors.blueAccent
              )
          ),

          filedDecoration: const InputDecoration(),
          onChanged: (String? value) {
            setState(() {
              selectedDropDownValue = value;
            });
          },
          listItemBuilder: (context, item, isSelected, onItemSelect) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
              child: Text(
                item,
                style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400
                ),
              ),
            );
          },
          selectedItemBuilder: (context, {item}) {
            return Text(
              item!,
              style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400
              ),
            );
          },
        ),
      ),
    );
  }
}

