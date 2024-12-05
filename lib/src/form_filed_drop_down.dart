import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'animated_section.dart';
import 'signatures.dart';

class FormFiledDropDown<T> extends StatefulWidget {

  /// List of strings to display in the dropdown.
  final List<T> item;


  /// Use this for[TextFormField] text form fields you want to read only.
  final bool filedReadOnly;

  /// call when change drop-down opening offset
  final Offset? dropdownOffset;
  final double? errorWidgetHeight;

  /// Use this for [FromFieldDropDown] to read only from the dropdown you want.
  final bool readOnly;

  /// If a [textController] is not specified, [initialItem] can be used to give
  /// the automatically generated controller an initial value.
  ///
  final T? initialItem;

  /// use if you using api api
  final bool isApiLoading;

  /// call when you want to show cursor
  final bool? showCursor;

  /// call when you need to change cursor color
  final Color? cursorColor;

  /// call when you need to change cursor Height
  final double? cursorHeight;

  /// call when you need to change cursor Width
  final double? cursorWidth;

  /// call when you need to change cursor Radius
  final Radius? cursorRadius;

  /// call when you need to change cursor cursor Error Color
  final Color? cursorErrorColor;


  /// Use this to style your search or selected text.
  final TextStyle textStyle;

  /// Use this if you want to provide your custom widget when using the API
  final Widget? loaderWidget;

  /// Call when we need to focus; your drop-down is searchable.
  final FocusNode? focusNode;

  /// [errorMessage] Show a custom message when [item] is empty.
  final Text? errorMessage;

  /// provide drop-down tile height
  final double? overlayHeight;


  /// call when you need add button or need any kind for button functionality
  /// open a dialog navigate to other page's ect...
  /// dart
  /// InkWell(
  ///   onTap: () {
  ///     // add your event's
  ///  },
  /// child: Container(
  ///       height: 40,
  ///       padding: const EdgeInsets.all(10),
  ///       decoration:BoxDecoration(
  ///         color: Colors.green,
  ///         borderRadius: BorderRadius.circular(2),
  ///       ),
  ///       child: Row(
  ///         children: [
  ///           Expanded(
  ///             child: Text(
  ///                 "Add",
  ///                 maxLines: 1,
  ///                 textAlign:TextAlign.start,
  ///                 overflow: TextOverflow.ellipsis,
  ///                 style: const TextStyle(color: Colors.white)
  ///             ),
  ///           ),
  ///           Icon(
  ///            Icons.add,
  ///             color: Colors.white,
  ///          )
  ///         ],
  ///      ),
  ///    ),
  /// )
  final Widget? addButton;

  /// TextFormFiled text controller
  final TextEditingController textController;

  /// Callback function when an item is selected.
  final Function(T? value) onChanged;

  /// give your drop-down custom decoration style
  /// dart
  /// BoxDecoration(
  ///    color: Colors.white,
  ///    borderRadius: BorderRadius.circular(2),
  ///   ),
  final BoxDecoration? menuDecoration;

  /// * [InputDecorator], which shows the labels and other visual elements that
  /// Creates a [TextFormField] with an [InputDecoration]
  /// ///
  /// dart
  /// TextFormField(
  ///   decoration: const InputDecoration(
  ///     icon: Icon(Icons.person),
  ///     hintText: 'What do people call you?',
  ///     labelText: 'Name *',
  ///   ),
  final InputDecoration filedDecoration;

  /// call when [FormFiledDropDown] you are using the API or to load your list items
  final Future<List<T>> Function()? onTap;

  /// Enable the validation listener on item change.
  /// This implies to [validator] everytime when the item change.
  final AutovalidateMode? autovalidateMode;

  /// Use the [OverlayPortalController] to display or conceal your drop-down.
  final OverlayPortalController controller;

  /// Build your drop-down listing custom UI using this property.
  /// dart
  /// listItemBuilder: (context, item, isSelected, onItemSelect) {
  ///    return Container(
  ///      decoration: BoxDecoration(
  ///        color: isSelected ? Colors.green : Colors.transparent,
  ///        borderRadius: BorderRadius.circular(2)
  ///    ),
  ///    child: Text(
  ///       item,
  ///       style: TextStyle(
  ///       fontSize: 12,
  ///       color: Colors.black,
  ///         fontWeight: FontWeight.w400
  ///      ),
  ///     ),
  ///   );
  /// },
  final ListItemBuilder<T> listItemBuilder;

  /// Build your selected value UI using this property.
  /// ```dart
  /// selectedItemBuilder: (context, item) {
  ///    return Text(
  ///      item!,
  ///      style: const TextStyle(
  ///         fontSize: 12,
  ///         fontWeight: FontWeight.w400
  ///      ),
  ///    );
  /// },
  final SelectedItemBuilder<T> selectedItemBuilder;
  /// To search for your item, use the search functionality in the enter list,
  /// or we can utilize the API search functionality.
  final Future<List<T>> Function(String value)? onSearch;

  /// call for [listPadding] to provide padding for the list view
  final EdgeInsets? listPadding;

  /// call for [menuMargin] to provide Margin for the list view item container
  final EdgeInsets? menuMargin;


  /// When the value of [canShowButton] is true, the add button becomes visible.
  final bool canShowButton;




  /// ccall when you need to change the search field textAlign [TextAlign.start]
  final TextAlign textAlign;

  /// call when [keyboardType] you need to obtain a specific type of input, such as a number, email, etc.
  final TextInputType? keyboardType;

  /// When [canShowButton] is true, the add button becomes available, allowing
  /// you to use onButtonTab to navigate or open a dialog box, etc..
  final List<TextInputFormatter>? inputFormatters;


  /// we can validate your drop-down using a [validator]
  final String? Function(String?)? validator;


  /// Creates a [Drop-down] that contains a [TextField].
  ///
  /// When a [controller] is specified, [initialItem] must be null (the
  /// default). If [controller] is null, then a [TextEditingController]
  /// will be constructed automatically and its `text` will be initialized
  /// to [initialItem] or the empty string.

  const FormFiledDropDown({
    super.key,
    this.onTap,
    this.onSearch,
    this.focusNode,
    this.addButton,
    this.validator,
    this.showCursor,
    this.menuMargin,
    this.listPadding,
    this.cursorColor,
    this.initialItem,
    this.cursorWidth,
    this.keyboardType,
    this.cursorRadius,
    this.cursorHeight,
    this.loaderWidget,
    this.errorMessage,
    required this.item,
    this.overlayHeight,
    this.menuDecoration,
    this.dropdownOffset,
    this.inputFormatters,
    this.cursorErrorColor,
    this.readOnly = false,
    this.errorWidgetHeight,
    this.autovalidateMode,
    required this.textStyle,
    required this.onChanged,
    required this.controller,
    this.isApiLoading = false,
    this.filedReadOnly = false,
    this.canShowButton = false,
    required this.textController,
    required this.listItemBuilder,
    required this.filedDecoration,
    required this.selectedItemBuilder,
    this. textAlign = TextAlign. start,
  });

  @override
  State<FormFiledDropDown<T>> createState() => _FormFiledDropDownState<T>();
}

class _FormFiledDropDownState<T> extends State<FormFiledDropDown<T>> {
  T? selectedItem;
  late List<T> items;
  final layerLink = LayerLink();
  bool displayOverlayBottom = true;
  final GlobalKey textFieldKey = GlobalKey();
  final key1 = GlobalKey(), key2 = GlobalKey();







  @override
  void initState() {
    super.initState();
    items = [];
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if(widget.focusNode!=null) {
        widget.focusNode!.addListener(() async {
          if (widget.focusNode!.hasFocus) {
            if (widget.onTap != null) {
              items = await widget.onTap!();
            }
          }
        });

        items = widget.item;


        widget.textController.text =
            selectedItemConvertor(listData: widget.initialItem) ?? "";
        selectedItem = widget.initialItem;


      }
    });
  }


  void checkRenderObjects() {
    print(" r345346 ");
    Future.delayed(const Duration(milliseconds: 100), () {
      if (key1.currentContext != null && key2.currentContext != null) {
        print("object qwew");
        final RenderBox? render1 = key1.currentContext?.findRenderObject() as RenderBox?;
        final RenderBox? render2 = key2.currentContext?.findRenderObject() as RenderBox?;

        if (render1 != null && render2 != null) {
          final screenHeight = MediaQuery.of(context).size.height;
          double y = render1.localToGlobal(Offset.zero).dy;

          if (screenHeight - y < render2.size.height) {
            displayOverlayBottom = false;
          }

          setState(() {}); // Update the state after calculation.
        }
      } else {
        print("objectadssd ");
        // Try again if render objects are not ready.
        checkRenderObjects();
      }
    });
  }


  String? selectedItemConvertor({T? listData}) {
    if (listData != null) {
      return (widget.selectedItemBuilder(context, listData as T)).data;
    }
    return null;
  }





  @override
  Widget build(BuildContext context) {
    return OverlayPortal(
      controller: widget.controller,
      overlayChildBuilder: (context) {

        final RenderBox? renderBox =
        textFieldKey.currentContext?.findRenderObject() as RenderBox?;
        return GestureDetector(
          onTap: () {
            if(selectedItem == null) {
              widget.textController.clear();
              if(widget.onSearch != null) {
                widget.onSearch!("");
              }
            };
            widget.controller.hide();
          },
          child: Container(
            color: Colors.transparent,
            child: Stack(
              children: [
                OverlayOutBuilder(
                  selectedItemBuilder: widget.selectedItemBuilder,
                  textController: widget.textController,
                  controller: widget.controller,
                  textStyle: widget.textStyle,
                  onChanged: widget.onChanged,
                  listItemBuilder: widget.listItemBuilder,
                  item: items,
                  layerLink: layerLink,
                  overlayHeight: widget.overlayHeight,
                  listPadding: widget.listPadding,
                  errorWidgetHeight: widget.errorWidgetHeight,
                  dropdownOffset: widget.dropdownOffset,
                  filedReadOnly: widget.filedReadOnly,
                  isApiLoading: widget.isApiLoading,
                  addButton: widget.addButton,
                  canShowButton: widget.canShowButton,
                  loaderWidget: widget.loaderWidget,
                  errorMessage: widget.errorMessage,
                  menuDecoration: widget.menuDecoration,
                  cursorRadius: widget.cursorRadius,
                  cursorErrorColor: widget.cursorErrorColor,
                  initialItem: widget.initialItem,
                  menuMargin: widget.menuMargin,
                  renderBox: renderBox,
                )
              ],
            ),
          ),
        );
      },
      child: CompositedTransformTarget(
        link: layerLink,
        child: TextFormField(
            key: textFieldKey,
            style: widget.textStyle,
            keyboardType: widget.keyboardType,
            inputFormatters: widget.inputFormatters,
            textAlign: widget.textAlign,
            readOnly: widget.filedReadOnly,
            focusNode: widget.focusNode,
            controller: widget.textController,
            showCursor: widget.showCursor,
            cursorHeight: widget.cursorHeight,
            cursorWidth: widget.cursorWidth??2.0,
            cursorRadius: widget.cursorRadius,
            decoration: widget.filedDecoration,
            cursorColor: widget.cursorColor ?? Colors.black,
            cursorErrorColor: widget.cursorErrorColor ?? Colors.black,
            autovalidateMode: widget.autovalidateMode,
            validator: widget.validator,
            onChanged: onChange,
            onTap:textFiledOnTap
        ),
      ),
    );
  }





  /// drop-down on tap function
  textFiledOnTap()async {
    if(!(widget.readOnly)) {
      widget.controller.show();
      if (widget.onTap != null){
        items = await widget.onTap!();
      }
      setState(() {});
    }
  }

  /// drop-down search or text form filed on change function
  onChange(value) async {
    if (value.isEmpty) {
      selectedItem = null;
      widget.onChanged(null);
      onSearchCalled(value);
    }else {
      onSearchCalled(value);
    }
    setState(() {});
  }

  /// when on search is not null then call this function
  onSearchCalled(value) async {
    if (widget.onSearch != null) items = await widget.onSearch!(value);
  }


}

class OverlayOutBuilder<T> extends StatefulWidget {
  final List<T> item;
  final bool filedReadOnly;

  final Offset? dropdownOffset;
  final double? errorWidgetHeight;

  final T? initialItem;
  final bool isApiLoading;


  final Radius? cursorRadius;
  final RenderBox? renderBox;

  final Color? cursorErrorColor;
  final layerLink;


  final TextStyle textStyle;
  final Widget? loaderWidget;


  final Text? errorMessage;
  final double? overlayHeight;
  final Widget? addButton;

  final TextEditingController textController;

  final Function(T? value) onChanged;

  final BoxDecoration? menuDecoration;

  final OverlayPortalController controller;

  final ListItemBuilder<T> listItemBuilder;

  final SelectedItemBuilder<T> selectedItemBuilder;

  final EdgeInsets? listPadding;

  final EdgeInsets? menuMargin;

  final bool canShowButton;


  const OverlayOutBuilder({
    super.key,
    this.addButton,
    this.menuMargin,
    this.listPadding,
    this.renderBox,
    this.initialItem,
    this.cursorRadius,
    this.loaderWidget,
    this.errorMessage,
    required this.item,
    this.overlayHeight,
    this.menuDecoration,
    this.dropdownOffset,
    this.cursorErrorColor,
    this.errorWidgetHeight,
    required this.textStyle,
    required this.layerLink,
    required this.onChanged,
    required this.controller,
    required this.selectedItemBuilder,
    this.isApiLoading = false,
    this.filedReadOnly = false,
    this.canShowButton = false,
    required this.textController,
    required this.listItemBuilder,
  });

  @override
  State<OverlayOutBuilder<T>> createState() => _OverlayOutBuilderState<T>();
}

class _OverlayOutBuilderState<T> extends State<OverlayOutBuilder<T>> {

  T? selectedItem;
  late List<T> items;
  bool displayOverlayBottom = true;
  final GlobalKey textFieldKey = GlobalKey();
  final key1 = GlobalKey(), key2 = GlobalKey();

  /// calculate drop-down height base on item length
  double baseOnHeightCalculate() {
    const double itemHeight = 35.0;

    if (widget.canShowButton) {
      if(items.isNotEmpty) {
        return items.length * itemHeight + 40;
      }else {
        return widget.errorWidgetHeight??120;
      }
    }

    if(items.isNotEmpty) return items.length * (items.length == 1 ? 38 : itemHeight);
    return widget.errorWidgetHeight??120;
  }


  /// The height of the drop-down container is calculated based on the item length or
  /// the add button, and when no items are available, the default pass height is displayed.
  double calculateHeight() {
    const double staticHeight = 150.0; // Static value fallback
    final double calculatedHeight = baseOnHeightCalculate();

    // If widget.overlayHeight is not provided, use staticHeight
    final double maxHeight = widget.overlayHeight ?? staticHeight;

    // Return the smaller value between the calculated height and maxHeight
    return calculatedHeight > maxHeight ? maxHeight : calculatedHeight;
  }


  @override
  void didUpdateWidget(covariant OverlayOutBuilder<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    super.didUpdateWidget(oldWidget);

    // checkRenderObjects();
    if (widget.item != oldWidget.item) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        items = widget.item;
      });
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {

      if(widget.initialItem != oldWidget.initialItem){
        if(widget.initialItem == null){
          selectedItem = null;
          widget.onChanged(null);
          widget.textController.clear();
          // if(widget.onSearch != null) widget.onSearch!("");
        }else{
          selectedItem = widget.initialItem;
          // if(widget.textController != oldWidget.textController) {
          //   widget.textController.text = selectedItemConvertor(listData: selectedItem)??"";
          // }
          // print("NEWW ITEM SEELCT% $selectedItem");
        }
        // print("NEWW ITEM % $selectedItem");

      }

      // if (selectedItem != null) {
      //   widget.textController.text = selectedItemConvertor(listData: selectedItem)!;
      // }

      if (widget.textController != oldWidget.textController) {
        // print("INSERT DROPDOWN PRINT");
        // if (widget.onSearch != null) widget.onSearch!("");
      }else{
        // print("ELSE PART DROPDOWN PRINT");

      }
    });
  }


  @override
  void initState() {
    super.initState();
      items = widget.item;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      checkRenderObjects(); // Start checking render objects.
    });
  }


  void checkRenderObjects() {

      if (key1.currentContext != null && key2.currentContext != null) {
        final RenderBox? render1 = key1.currentContext
            ?.findRenderObject() as RenderBox?;
        final RenderBox? render2 = key2.currentContext
            ?.findRenderObject() as RenderBox?;

        if (render1 != null && render2 != null) {
          final screenHeight = MediaQuery
              .of(context)
              .size
              .height;
          double y = render1
              .localToGlobal(Offset.zero)
              .dy;

          if (screenHeight - y < render2.size.height) {
            displayOverlayBottom = false;
          }

          setState(() {}); // Update the state after calculation.
        }
      }
      // } else {
      //   // Try again if render objects are not ready.
      //   checkRenderObjects();
      // }

  }


  @override
  Widget build(BuildContext context) {
    return CompositedTransformFollower(
        link: widget.layerLink,
        offset: setOffset(),
        followerAnchor: displayOverlayBottom ? Alignment.topLeft : Alignment.bottomLeft,
        child: SizedBox(
          key: key1,
          width: widget.renderBox?.size.width ?? 0,
          height: calculateHeight(),
          child: AnimatedSection(
            animationDismissed: widget.controller.hide,
            expand: true,
            axisAlignment: displayOverlayBottom ? 1.0 : -1.0,
            child: Container(
                margin: widget.menuMargin ?? EdgeInsets.zero,
                width: MediaQuery.sizeOf(context).width,
                key: key2,
                height: calculateHeight(),
                child: widget.isApiLoading
                    ?
                loaderWidget()
                    :
                (items).isEmpty
                    ?
                emptyErrorWidget()
                    :
                uiListWidget()
            ),
          ),
        )
    );
  }


  /// This function returns the UI of drop-down tiles when the user clicks on
  /// the drop-down. After that, how the drop-down will look is all defined in
  /// this function.
  Widget uiListWidget(){
    return NotificationListener<OverscrollIndicatorNotification>(
      onNotification: (notification) {
        notification.disallowIndicator();
        return true;
      },
      child: Container(
        height: calculateHeight(),
        decoration: menuDecoration(),
        child: Column(
          children: [
            if(widget.canShowButton)
              widget.addButton??SizedBox(),
            const SizedBox(height:2),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                addAutomaticKeepAlives: false,
                addRepaintBoundaries: false,
                padding: widget.listPadding ?? EdgeInsets.zero,
                itemCount: items.length,
                itemBuilder: (_, index) {
                  bool selected = isItemSelected(index);
                  return InkWell(
                    hoverColor: Colors.transparent,
                    onTap: ()=> onItemSelected(index),
                    child: widget.listItemBuilder(
                      context,
                      items[index], selected,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }


  /// This method returns a boolean value for the selected item from the list
  /// or user-defined in the selected item builder. You must first define what
  /// kind of value is visible when the user selects any type of value from the
  /// drop-down, or that kind of data will be available in your list; otherwise,
  /// you will encounter an error.
  bool isItemSelected(int index){
    String? selectedValue = (selectedItemConvertor(listData: selectedItem) ?? "");
    String? selectedIndexValue = selectedItemConvertor(listData: items[index]);
    return selectedIndexValue == selectedValue;
  }

  ///This is for the drop-down container decoration. If the user wants to provide
  /// a custom decoration, they can do so. However, if the widget is not set for
  /// the user side, we will provide our own default decoration.
  BoxDecoration menuDecoration(){
    if (widget.menuDecoration != null) return widget.menuDecoration!;

    return BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(5)
    );
  }


  Offset setOffset(){
    return Offset(
        widget.dropdownOffset?.dx??0,
        displayOverlayBottom ? widget.dropdownOffset?.dy?? 55 : -10
    );
  }

  /// This method is called when the user selects a drop-down value item from the list
  onItemSelected(index){
    widget.controller.hide();
    selectedItem = items[index];
    widget.textController.text = selectedItemConvertor(listData: selectedItem)??"";
    widget.onChanged(items[index]);
    setState(() {});
  }

  String? selectedItemConvertor({T? listData}) {
    if (listData != null) {
      return (widget.selectedItemBuilder(context, listData as T)).data;
    }
    return null;
  }

  /// This call displays an error message to the user when the item list is
  /// empty or the search value is not found, helping them understand what
  /// is happening in the UI. Additionally, the user can enter their custom message as well.
  Widget emptyErrorWidget(){
    print(widget.errorWidgetHeight);
    return Container(
      alignment: Alignment.center,
      decoration: menuDecoration(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if(widget.canShowButton)
            widget.addButton??SizedBox(),

          widget.errorMessage ?? const Text("No options"),
        ],
      ),
    );
  }

  /// this function return loader widget
  Widget loaderWidget(){
    return Container(
      alignment: Alignment.center,
      decoration: menuDecoration(),
      height:calculateHeight(),
      child: Center(
        child: widget.loaderWidget ?? const CircularProgressIndicator(),
      ),
    );
  }
}
