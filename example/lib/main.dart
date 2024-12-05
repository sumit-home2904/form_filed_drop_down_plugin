import 'package:flutter/material.dart';
import 'package:form_filed_drop_down/form_filed_drop_down.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FormFiled DropDown Example',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          primary: Colors.deepPurple,
        ),
        appBarTheme:const AppBarTheme(
          color:  Colors.deepPurple,
        ),
        useMaterial3: true,
      ),
      home: const DropDownClass(),
    );
  }
}

final itemController = OverlayPortalController();
final itemTextController = TextEditingController();

String? selectedItem;
List<String> itemList = ["item","item 2","item 3","item 4","item 5","item 6"];

class DropDownClass extends StatelessWidget {
  const DropDownClass({super.key});



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: MediaQuery.sizeOf(context).height * 0.9),
            FormFiledDropDown<String>(
              item : itemList,
              errorWidgetHeight: 120,
              overlayHeight: 100,
              controller: itemController,
              textController: itemTextController,
              dropdownOffset: const Offset(0, 50),
              textStyle: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400
              ),
              onTap: () async => itemList,
              menuDecoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(
                      color: Colors.blueAccent
                  )
              ),
              filedDecoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(2),
                    borderSide: const BorderSide(
                        color: Colors.blueAccent
                    )
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(2),
                  borderSide: const BorderSide(
                      color: Colors.blueAccent
                  )
                ),
              ),
              onSearch: (value) async{
                return itemList.where((element) {
                  return element.contains(value);
                }).toList();
              },
              onChanged: (String? value) {},
              listPadding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
              listItemBuilder: (context, item, isSelected) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    item,
                    style: const TextStyle(
                        fontSize: 12,
                        color:  Colors.black,
                        fontWeight: FontWeight.w400
                    ),
                  ),
                );
              },
              selectedItemBuilder: (context, item) {
                return Text(item);
              },
            ),
          ],
        ),
      ),
    );
  }
}


