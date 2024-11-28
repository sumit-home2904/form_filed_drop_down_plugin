# from_filed_drop_down

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

```dart
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
