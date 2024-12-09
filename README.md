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
        selectedItemBuilder: (context, item) {
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
            selectedItemBuilder: (context, item) {
              return Text(
                item!,
                style: const TextStyle(
                    fontSize: 12,
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
            selectedItemBuilder: (context, item) {
              return Text(
                item!,
                style: const TextStyle(
                    fontSize: 12,
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
