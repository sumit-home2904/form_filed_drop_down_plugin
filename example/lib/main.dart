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

class DropDownClass extends StatefulWidget {
  const DropDownClass({super.key});

  @override
  State<DropDownClass> createState() => _DropDownClassState();
}

class _DropDownClassState extends State<DropDownClass> {

  final countryController = OverlayPortalController();
  final countryTextController = TextEditingController();

  String? selectedItem;
  List<String> itemList = ["item","item 2","item 3","item 4","item 5","item 6"];

  @override
  void dispose() {
    countryTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text(
            "FormFiled DropDown Example",
          style: TextStyle(
            color: Colors.white
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              FromFiledDropDown<String>(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: countryController,
                overlayHeight: 200,
                textController: countryTextController,
                initialItem: selectedItem,
                item : itemList,
                onTap: () async{
                  return itemList;
                },

                textStyle: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400
                ),
                menuDecoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(
                        color: Colors.blueAccent
                    )
                ),
                filedDecoration: InputDecoration(
                    suffixIcon: IntrinsicWidth(
                      child: Row(
                        children: [
                          if(countryTextController.text.isNotEmpty)
                            InkWell(
                              onTap:() {
                                setState(() {
                                  selectedItem = null;
                                  countryTextController.clear();
                                });
                              },
                              child: const Icon(
                                Icons.clear,
                                size: 20,
                              ),
                            ),

                          if(countryTextController.text.isNotEmpty)
                            const SizedBox(width: 5),
                          const Icon(
                            Icons.arrow_drop_down_sharp,
                            size: 20,
                          ),
                          const SizedBox(width: 8),

                        ],
                      ),
                    ),
                    contentPadding: const EdgeInsets.all(10),
                    errorStyle:const TextStyle(fontSize: 12,color: Colors.red,),
                    fillColor: Colors.white,
                    hintStyle: TextStyle(color: Colors.grey.shade800),
                    filled: true,
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4),
                        borderSide:  const BorderSide(
                            color: Colors.blueAccent
                        )
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4),
                        borderSide: const BorderSide(
                            color: Colors.blueAccent
                        )
                    ),
                    errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4),
                        borderSide: const BorderSide(
                            color: Colors.red
                        )
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4),
                        borderSide: const BorderSide(
                            color: Colors.red
                        )
                    )
                ),
                onChanged: (String? value) {
                  setState(() {
                    selectedItem = value;
                  });
                },
                onSearch: (value) async {
                  return itemList.where((element) {
                    return element.contains(value.toLowerCase());
                  }).toList();
                },
                listItemBuilder: (context, item, isSelected, onItemSelect) {
                  int index = itemList.indexOf(item);
                  return Container(
                    padding:const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                    margin: EdgeInsets.fromLTRB(5, index == 0 ? 7:2,5,1),
                    decoration: BoxDecoration(
                        color: isSelected ? Colors.green : Colors.transparent,
                        borderRadius: BorderRadius.circular(2)
                    ),
                    child: Text(
                      item,
                      style: TextStyle(
                          fontSize: 12,
                          color: isSelected ? Colors.white : Colors.black,
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
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

