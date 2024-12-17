import 'package:example/MainProvider.dart';
import 'package:example/Model/ClientModel.dart';
import 'package:form_filed_drop_down/form_filed_drop_down.dart';
import 'package:provider/provider.dart';
import 'Model/CityModel.dart';
import 'Model/StatesModel.dart';
import 'Model/CountryModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MainProvider()),
      ],
      child: MaterialApp(
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
      ),
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
  final countryController1 = OverlayPortalController();
  final stateController = OverlayPortalController();
  final cityController = OverlayPortalController();
  final itemController = OverlayPortalController();

  late MainProvider mainProvider;
  FocusNode focusNode = FocusNode();
  FocusNode focusNode1 = FocusNode();
  FocusNode focusNode2 = FocusNode();
  FocusNode focusNode3 = FocusNode();



  @override
  void initState() {
    super.initState();
    mainProvider = Provider.of<MainProvider>(context,listen: false);
    Future.delayed(Duration.zero,mainProvider.getAllLocation);
  }

  @override
  Widget build(BuildContext context) {
    mainProvider = Provider.of<MainProvider>(context,listen: true);

    // print(mainProvider.selectedCountry1);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "FormFiled DropDown Example",
          style: TextStyle(
              color: Colors.white
          ),
        ),
      ),
      body: CallbackShortcuts(
        bindings: {
          LogicalKeySet(LogicalKeyboardKey.tab):() async {
            if(focusNode.hasFocus){
              focusNode2.requestFocus();
              stateController.show();
              countryController.hide();
              cityController.hide();
            }else if(focusNode2.hasFocus){
              focusNode3.requestFocus();
              stateController.hide();
              countryController.hide();
              cityController.show();
            }else if(focusNode3.hasFocus){
              focusNode.requestFocus();
              stateController.hide();
              cityController.hide();
              countryController.show();
            }
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                      child: FormFiledDropDown<CountryModel>(
                        focusNode: focusNode,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        controller: countryController,
                        initialItem: mainProvider.selectedCountry,
                        item : mainProvider.countryList,
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
                                  if(mainProvider.selectedCountry != null)
                                    InkWell(
                                      onTap:() {
                                        mainProvider.clearCountry();
                                      },
                                      child: const Icon(
                                        Icons.clear,
                                        size: 20,
                                      ),
                                    ),

                                  if(mainProvider.selectedCountry != null)
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
                        onChanged: (CountryModel? value) {
                          mainProvider.countryOnChange(value);
                        },
                        onSearch: (value) async {
                          return mainProvider.countryList.where((element) {
                            return element.name.toLowerCase().contains(value.toLowerCase());
                          }).toList();
                        },
                        listItemBuilder: (context, item, isSelected) {
                          int index = mainProvider.countryList.indexOf(item);
                          return Container(
                            padding:const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                            margin: EdgeInsets.fromLTRB(5, index == 0 ? 7:2,5,1),
                            decoration: BoxDecoration(
                                color: isSelected ? Colors.green : Colors.transparent,
                                borderRadius: BorderRadius.circular(2)
                            ),
                            child: Text(
                              item.name,
                              style: TextStyle(
                                  fontSize: 12,
                                  color: isSelected ? Colors.white : Colors.black,
                                  fontWeight: FontWeight.w400
                              ),
                            ),
                          );
                        },
                        selectedItemBuilder: (context,item) {
                          return Text(
                            item.name,
                            style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400
                            ),
                          );
                        },
                      )
                  ),
                  const SizedBox(width: 15),

                  Expanded(
                      child: FormFiledDropDown<StatesModel>(
                        focusNode: focusNode2,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        controller: stateController,
                        initialItem: mainProvider.selectedState,
                        item : mainProvider.tempStatesList,
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
                                  if(mainProvider.selectedState != null)
                                    InkWell(
                                      onTap:() {
                                       mainProvider.clearState();
                                      },
                                      child: const Icon(
                                        Icons.clear,
                                        size: 20,
                                      ),
                                    ),

                                  if(mainProvider.selectedState != null)
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
                        onChanged: (StatesModel? value) {
                          mainProvider.stateOnChange(value);
                        },

                        onSearch: (value) async {
                          return mainProvider.statesList.where((element) {
                            return element.name.toLowerCase().contains(value.toLowerCase());
                          }).toList();
                        },
                        listItemBuilder: (context, item, isSelected) {
                          int index = mainProvider.statesList.indexOf(item);
                          return Container(
                            padding:const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                            margin: EdgeInsets.fromLTRB(5, index == 0 ? 7:2,5,1),
                            decoration: BoxDecoration(
                                color: isSelected ? Colors.green : Colors.transparent,
                                borderRadius: BorderRadius.circular(2)
                            ),
                            child: Text(
                              item.name,
                              style: TextStyle(
                                  fontSize: 12,
                                  color: isSelected ? Colors.white : Colors.black,
                                  fontWeight: FontWeight.w400
                              ),
                            ),
                          );
                        },
                        selectedItemBuilder: (context, item) {
                          return Text(
                            item.name,
                            style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400
                            ),
                          );
                        },
                      )
                  ),
                  const SizedBox(width: 15),

                  Expanded(
                      child: FormFiledDropDown<CityModel>(
                        focusNode: focusNode3,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        controller: cityController,
                        readOnly: mainProvider.tempCityList.isEmpty,
                        initialItem: mainProvider.selectedCity,
                        item : mainProvider.tempCityList,
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
                                  if(mainProvider.selectedCity != null)
                                    InkWell(
                                      onTap:() {
                                        mainProvider.clearCity();
                                      },
                                      child: const Icon(
                                        Icons.clear,
                                        size: 20,
                                      ),
                                    ),

                                  if(mainProvider.selectedCity != null)
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
                        onChanged: (CityModel? value) {
                          mainProvider.cityOnChange(value);
                        },
                        onSearch: (value) async {
                          return mainProvider.tempCityList.where((element) {
                            return element.name.toLowerCase().contains(value.toLowerCase());
                          }).toList();
                        },
                        listItemBuilder: (context, item, isSelected) {
                          int index = mainProvider.cityList.indexOf(item);
                          return Container(
                            padding:const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                            margin: EdgeInsets.fromLTRB(5, index == 0 ? 7:2,5,1),
                            decoration: BoxDecoration(
                                color: isSelected ? Colors.green : Colors.transparent,
                                borderRadius: BorderRadius.circular(2)
                            ),
                            child: Text(
                              item.name,
                              style: TextStyle(
                                  fontSize: 12,
                                  color: isSelected ? Colors.white : Colors.black,
                                  fontWeight: FontWeight.w400
                              ),
                            ),
                          );
                        },
                        selectedItemBuilder: (context, item) {
                          return Text(
                            item.name,
                            style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400
                            ),
                          );
                        },
                      )
                  )
                ],
              ),
              const SizedBox(height: 20),

              FormFiledDropDown<ClientModel>(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: itemController,
                initialItem: mainProvider.selectedClient,
                item : mainProvider.clientList,
                isApiLoading: mainProvider.isLoading,
                onTap: () async => mainProvider.getClient(""),
                onSearch: (value) async => mainProvider.getClient(value),
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
                          if(mainProvider.selectedCity != null)
                            InkWell(
                              onTap:() {
                                setState(() {
                                  mainProvider.selectedCity = null;
                                  if(mainProvider.selectedState == null) mainProvider.tempCityList.clear();
                                });
                              },
                              child: const Icon(
                                Icons.clear,
                                size: 20,
                              ),
                            ),

                          if(mainProvider.selectedCity != null)
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
                onChanged: (ClientModel? value) {
                  setState(() {
                    mainProvider.selectedClient = value;
                  });
                },
                listItemBuilder: (context, item, isSelected) {
                  int index = mainProvider.clientList.indexOf(item);
                  return Container(
                    padding:const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                    margin: EdgeInsets.fromLTRB(5, index == 0 ? 7:2,5,1),
                    decoration: BoxDecoration(
                        color: isSelected ? Colors.green : Colors.transparent,
                        borderRadius: BorderRadius.circular(2)
                    ),
                    child: Text(
                      item.name,
                      style: TextStyle(
                          fontSize: 12,
                          color: isSelected ? Colors.white : Colors.black,
                          fontWeight: FontWeight.w400
                      ),
                    ),
                  );
                },
                // selectedItemBuilder: (context, item) {
                //   return Text(
                //     item.name,
                //     style: const TextStyle(
                //         fontSize: 12,
                //         fontWeight: FontWeight.w400
                //     ),
                //   );
                // },
              ),
              const SizedBox(height: 20),


              FormFiledDropDown<CountryModel>(
                focusNode: focusNode1,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: countryController1,
                initialItem: mainProvider.selectedCountry1,
                item : mainProvider.countryList,
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
                          if(mainProvider.selectedCountry1 != null)
                            InkWell(
                              onTap:() {
                                mainProvider.clearCountry();
                              },
                              child: const Icon(
                                Icons.clear,
                                size: 20,
                              ),
                            ),

                          if(mainProvider.selectedCountry1 != null)
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
                onChanged: (CountryModel? value) {
                  mainProvider.countryOnChange(value);
                },
                onSearch: (value) async {
                  return mainProvider.countryList.where((element) {
                    return element.name.toLowerCase().contains(value.toLowerCase());
                  }).toList();
                },
                listItemBuilder: (context, item, isSelected) {
                  int index = mainProvider.countryList.indexOf(item);
                  return Container(
                    padding:const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                    margin: EdgeInsets.fromLTRB(5, index == 0 ? 7:2,5,1),
                    decoration: BoxDecoration(
                        color: isSelected ? Colors.green : Colors.transparent,
                        borderRadius: BorderRadius.circular(2)
                    ),
                    child: Text(
                      item.name,
                      style: TextStyle(
                          fontSize: 12,
                          color: isSelected ? Colors.white : Colors.black,
                          fontWeight: FontWeight.w400
                      ),
                    ),
                  );
                },
                selectedItemBuilder: (context,item) {
                  return Text(
                    item.name,
                    style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

