import 'package:flutter/material.dart';
import 'package:form_filed_drop_down/src/animated_section.dart';
import 'package:form_filed_drop_down/src/signatures.dart';

class OverlayBuilder<T> extends StatefulWidget {
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


  const OverlayBuilder({
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
  State<OverlayBuilder<T>> createState() => _OverlayOutBuilderState<T>();
}

class _OverlayOutBuilderState<T> extends State<OverlayBuilder<T>> {

  T? selectedItem;
  bool displayOverlayBottom = true;
  final GlobalKey textFieldKey = GlobalKey();
  final key1 = GlobalKey(), key2 = GlobalKey();

  /// calculate drop-down height base on item length
  double baseOnHeightCalculate() {
    const double itemHeight = 35.0;

    if (widget.canShowButton) {
      if(widget.item.isNotEmpty) {
        return widget.item.length * itemHeight + 40;
      }else {
        return widget.errorWidgetHeight??120;
      }
    }

    if(widget.item.isNotEmpty) return widget.item.length * (widget.item.length == 1 ? 38 : itemHeight);
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
  void initState() {
    super.initState();
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
            .of(context).size.height;
        double y = render1.localToGlobal(Offset.zero).dy;

        if (screenHeight - y < render2.size.height) {
          displayOverlayBottom = false;
        }

        setState(() {}); // Update the state after calculation.
      }
    }
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
                (widget.item).isEmpty
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
                itemCount: widget.item.length,
                itemBuilder: (_, index) {
                  bool selected = isItemSelected(index);
                  return InkWell(
                    hoverColor: Colors.transparent,
                    onTap: ()=> onItemSelected(index),
                    child: widget.listItemBuilder(
                      context,
                      widget.item[index], selected,
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
    String? selectedIndexValue = selectedItemConvertor(listData: widget.item[index]);
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
    selectedItem = widget.item[index];
    widget.textController.text = selectedItemConvertor(listData: selectedItem)??"";
    widget.onChanged(widget.item[index]);
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