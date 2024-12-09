# form_filed_drop_down 🛠️

A highly customizable dropdown widget for Flutter with powerful features like search, API integration, 
custom UI support, and validation.

---

## Features

- Display static items or fetch them dynamically via APIs.
- Fully customizable dropdown appearance using BoxDecoration and custom item builders.
- Support for readonly and searchable dropdowns, along with additional customization options.
- Easy integration with TextFormField for validation and decoration.
- Advanced cursor styling for an enhanced user interface.
- Seamless integration of an add-button for custom functionality.
- Flexible search and filter options, supporting both local and API-based data.

---

## Installation
1.Add the latest version of package to your pubspec.yaml (and run flutter pub get):

```yaml
dependencies:
  form_filed_drop_down: latest_version
```

2.Import the package and use it in your Flutter App.
```dart
import 'package:form_filed_drop_down/form_filed_drop_down.dart';
```

## Example usage
### **1.Basic FormFiledDropDown**

```dart
import 'package:flutter/material.dart';
import 'package:from_filed_drop_down/form_filed_drop_down.dart';
final itemController = OverlayPortalController();
final itemTextController = TextEditingController();

String? selectedItem;
List<String> itemList = ["item","item 2","item 3","item 4","item 5","item 6"];

class DropDownClass extends StatelessWidget {
  const DropDownClass({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FormFiledDropDown<String>(
        controller: itemController,
        textController: itemTextController,
        item : itemList,
        textStyle: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400
        ),
        filedDecoration: const InputDecoration(),
        onChanged: (String? value) {},
        listItemBuilder: (context, item, isSelected, onItemSelect) {
          return Text(
            item,
            style: TextStyle(
                fontSize: 12,
                color: isSelected ? Colors.white : Colors.black,
                fontWeight: FontWeight.w400
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
    );
  }
}
```


### **2.FormFiledDropDown with a Custom Add Button**
The addButton property lets you define a custom widget to trigger additional actions, such as 
opening a dialog box, navigating to another screen, or performing user-defined functionality.

```dart
class DropDownClass extends StatelessWidget {
  const DropDownClass({super.key});
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Column(
        children: [
          FormFiledDropDown<String>(
            item : itemList,
            controller: itemController,
            canShowButton: true,
            addButton:  InkWell(
              onTap: () {
                // add your event's
              },
              child: Container(
                height: 40,
                padding: const EdgeInsets.all(10),
                decoration:BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(2),
                ),
                child: const Row(
                  children: [
                    Expanded(
                      child: Text(
                          "Add",
                          maxLines: 1,
                          textAlign:TextAlign.start,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: Colors.white)
                      ),
                    ),
                    Icon(
                      Icons.add,
                      color: Colors.white,
                    )
                  ],
                ),
              ),
            ),
            textController: itemTextController,
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
            filedDecoration: const InputDecoration(),
            onChanged: (String? value) {},
            listItemBuilder: (context, item, isSelected, onItemSelect) {
              return Text(
                item,
                style: TextStyle(
                    fontSize: 12,
                    color: isSelected ? Colors.white : Colors.black,
                    fontWeight: FontWeight.w400
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
```

### **3.FormFiledDropDown with Dynamic Search or API Integration**

Advanced usage example for fetching dropdown items dynamically from an API.

```dart
class DropDownClass extends StatelessWidget {
  const DropDownClass({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Column(
        children: [
          FormFiledDropDown<String>(
            controller: itemController,
            textController: itemTextController,
            initialItem: selectedItem,
            item : itemList,
            onTap: () async{
              // example API, or return your API list.
              return itemList;
            },
            textStyle: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400
            ),
            filedDecoration: InputDecoration(
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
            },
            onSearch: (value) async {
              // We can call your API and search from it. Also, I can implement local search in your static list.
              return itemList.where((element) {
                return element.contains(value.toLowerCase());
              }).toList();
            },
            listItemBuilder: (context, item, isSelected, onItemSelect) {
              return Text(
                item,
                style: TextStyle(
                    fontSize: 12,
                    color: isSelected ? Colors.white : Colors.black,
                    fontWeight: FontWeight.w400
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
```

### **3.FormFiledDropDown with keyboard shortcut and local search**

Advanced usage example for fetching dropdown items dynamically from an API.

```dart
class DropDownClass extends StatefulWidget {
  const DropDownClass({super.key});

  @override
  State<DropDownClass> createState() => _DropDownClassState();
}

class _DropDownClassState extends State<DropDownClass> {

  final countryController = OverlayPortalController();
  final stateController = OverlayPortalController();
  final cityController = OverlayPortalController();
  final itemController = OverlayPortalController();

  final countryTextController = TextEditingController();
  final stateTextController = TextEditingController();
  final cityTextController = TextEditingController();
  final itemTextController = TextEditingController();

  CountryModel? selectedCountry;
  StatesModel? selectedState;
  CityModel? selectedCity;

  List<StatesModel> tempStatesList = [];
  List<CountryModel> countryList = [];
  List<StatesModel> statesList = [];
  List<CityModel> tempCityList = [];
  List<CityModel> cityList = [];


  FocusNode focusNode = FocusNode();
  FocusNode focusNode2 = FocusNode();
  FocusNode focusNode3 = FocusNode();

  Future<void> loadCity() async {
    cityList = [];

    var data = await rootBundle.loadString("assets/JsonFiles/City.json");
    var cityData = json.decode(data);
    List list = cityData['city'].cast<Map<String, dynamic>>();
    cityList.addAll(list.map((e) => CityModel.fromJson(e)).toList());
    setState(() {});

  }

  Future<void> loadState() async {
    statesList = [];
    var data = await rootBundle.loadString("assets/JsonFiles/State.json");
    var stateData = json.decode(data);
    List list = stateData['states'].cast<Map<String, dynamic>>();
    statesList.addAll(list.map((e) => StatesModel.fromJson(e)).toList());
    setState(() {});
  }

  Future<void> loadCountry() async {
    countryList = [];
    var data = await rootBundle.loadString("assets/JsonFiles/Country.json");
    var countryData = json.decode(data);
    List list = countryData['countries'].cast<Map<String, dynamic>>();
    countryList.addAll(list.map((e) => CountryModel.fromJson(e)).toList());
    setState(() {});
  }


  @override
  void initState() {
    super.initState();
    loadCity();
    loadState();
    loadCountry();
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
        child: SingleChildScrollView(
          child: Column(
            children: [
              // SizedBox(height: MediaQuery.sizeOf(context).height * 0.9),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                        child: FormFiledDropDown<CountryModel>(
                          focusNode: focusNode,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: countryController,
                          textController: countryTextController,
                          initialItem: selectedCountry,
                          item : countryList,
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
                                            tempCityList = [];
                                            tempStatesList = [];
                                            // print(tempStatesList.length);
                                            selectedCity = null;
                                            selectedState = null;
                                            selectedCountry = null;
                                            countryTextController.clear();
                                            loadCountry();
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
                          onChanged: (CountryModel? value) {
                            setState(() {
                              selectedCountry = value;
                              selectedCity = null;
                              selectedState = null;
                              tempStatesList = [];
                              tempCityList = [];
                              tempStatesList = statesList.where((element) {
                                return "${element.countryId}" == "${selectedCountry?.id}";
                              }).toList();
                            });
                          },
                          onSearch: (value) async {
                            return countryList.where((element) {
                              return element.name.toLowerCase().contains(value.toLowerCase());
                            }).toList();
                          },
                          listItemBuilder: (context, item, isSelected) {
                            int index = countryList.indexOf(item);
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
                          textController: stateTextController,
                          initialItem: selectedState,
                          item : tempStatesList,
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
                                    if(stateTextController.text.isNotEmpty)
                                      InkWell(
                                        onTap:() {
                                          setState(() {
                                            selectedState = null;
                                            stateTextController.clear();
                                            if(selectedCountry == null) tempStatesList.clear();
                                          });
                                        },
                                        child: const Icon(
                                          Icons.clear,
                                          size: 20,
                                        ),
                                      ),

                                    if(stateTextController.text.isNotEmpty)
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
                            setState(() {
                              tempCityList = [];
                              selectedCity = null;
                              selectedState = value;

                              tempCityList = cityList.where((element) {
                                return "${element.stateId}" == "${selectedState?.id}";
                              }).toList();

                            });
                          },

                          onSearch: (value) async {
                            return statesList.where((element) {
                              return element.name.toLowerCase().contains(value.toLowerCase());
                            }).toList();
                          },
                          listItemBuilder: (context, item, isSelected) {
                            int index = statesList.indexOf(item);
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
                          textController: cityTextController,
                          readOnly: tempCityList.isEmpty,
                          initialItem: selectedCity,
                          item : tempCityList,
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
                                    if(cityTextController.text.isNotEmpty)
                                      InkWell(
                                        onTap:() {
                                          setState(() {
                                            selectedCity = null;
                                            cityTextController.clear();
                                            if(selectedState == null) tempCityList.clear();

                                          });
                                        },
                                        child: const Icon(
                                          Icons.clear,
                                          size: 20,
                                        ),
                                      ),

                                    if(cityTextController.text.isNotEmpty)
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
                            setState(() {
                              selectedCity = value;
                            });
                          },
                          onSearch: (value) async {
                            return tempCityList.where((element) {
                              return element.name.toLowerCase().contains(value.toLowerCase());
                            }).toList();
                          },
                          listItemBuilder: (context, item, isSelected) {
                            int index = cityList.indexOf(item);
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
```

## Properties

| Property              | Type                         | Description                                            |
|-----------------------|------------------------------|--------------------------------------------------------|
| `item`                | `List<T>?`                  | List of dropdown items to display.                     |
| `filedReadOnly`       | `bool`                      | Makes `TextFormField` readonly.                        |
| `readOnly`            | `bool`                      | Makes dropdown readonly.                               |
| `initialItem`         | `T?`                        | Initial value for the dropdown.                        |
| `isApiLoading`        | `bool`                      | Indicates if the API is loading.                       |
| `dropdownOffset`      | `bool`                      | Change drop-down opening offset                        |
| `showCursor`          | `bool?`                     | Toggles the cursor visibility.                         |
| `cursorColor`         | `Color?`                    | Changes the cursor color.                              |
| `cursorHeight`        | `double?`                   | Sets the cursor height.                                |
| `cursorWidth`         | `double?`                   | Sets the cursor width.                                 |
| `errorWidgetHeight`   | `double?`                   | Sets the error widget height.                          |
| `cursorRadius`        | `Radius?`                   | Sets the cursor border radius.                         |
| `cursorErrorColor`    | `Color?`                    | Sets the cursor error color.                           |
| `textStyle`           | `TextStyle`                 | Styles the search or selected text.                    |
| `loaderWidget`        | `Widget?`                   | Custom widget to show during API loading.              |
| `focusNode`           | `FocusNode?`                | Manages focus for searchable dropdowns.                |
| `errorMessage`        | `Text?`                     | Custom error message when no items are found.          |
| `overlayHeight`       | `double?`                   | Height of the dropdown overlay.                        |
| `addButton`           | `Widget?`                   | Adds a custom button for additional functionality.     |
| `textController`      | `TextEditingController`     | Controller for the `TextFormField`.                    |
| `onChanged`           | `Function(T? value)`        | Callback triggered when an item is selected.           |
| `menuDecoration`      | `BoxDecoration?`            | Custom decoration for the dropdown menu.               |
| `filedDecoration`     | `InputDecoration`           | Decoration for the `TextFormField`.                    |
| `onTap`               | `Future<List<T>> Function()`| Loads items dynamically for the dropdown.              |
| `autovalidateMode`    | `AutovalidateMode?`         | Enables validation listener when items change.         |
| `controller`          | `OverlayPortalController`   | Controls dropdown visibility programmatically.         |
| `listItemBuilder`     | `ListItemBuilder<T>`        | Custom builder for dropdown items.                     |
| `selectedItemBuilder` | `SelectedItemBuilder<T?>?`  | Custom builder for the selected item.                  |
| `onSearch`            | `Future<List<T>> Function(String)` | Callback for API-based search functionality.           |
| `listPadding`         | `EdgeInsets?`              | Sets padding for the list view.                        |
| `menuMargin`          | `EdgeInsets?`              | Sets margin for the dropdown item container.           |
| `canShowButton`       | `bool`                      | Toggles the visibility of the add button.              |
| `textAlign`           | `TextAlign`                 | Aligns the text in the search field.                   |
| `keyboardType`        | `TextInputType?`            | Sets the input type for the `TextFormField`.           |
| `maxLine`             | `int?`                      | Limits the maximum number of text lines.               |
| `maxLength`           | `int?`                      | Limits the maximum number of characters.               |
| `inputFormatters`     | `List<TextInputFormatter>?` | Applies input formatting rules to the `TextFormField`. |
| `validator`           | `String? Function(String?)` | Validates the dropdown value.                          |
