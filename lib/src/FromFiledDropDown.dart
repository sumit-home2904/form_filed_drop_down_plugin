import 'package:flutter/material.dart';
import 'AnimatedSection.dart';
import 'Signatures.dart';

class FromFiledDropDown<T> extends StatefulWidget {
  final List<T>? item;
  final bool filedReadOnly;
  final bool readOnly;
  final T? initialItem;
  final bool isApiLoading;
  final bool? showCursor;
  final Color? cursorColor;
  final TextStyle textStyle;
  final double? cursorHeight;
  final double? cursorWidth;
  final Radius? cursorRadius;
  final Widget? loaderWidget;
  final FocusNode? focusNode;
  final Text? errorMessage;
  final double? overlayHeight;
  final Color? cursorErrorColor;
  TextEditingController textController;
  final Function(T? value) onChanged;
  final BoxDecoration? menuDecoration;
  final InputDecoration filedDecoration;
  final Future<List<T>> Function()? onTap;
  final AutovalidateMode? autovalidateMode;
  final OverlayPortalController controller;
  final ListItemBuilder<T> listItemBuilder;
  final SelectedItemBuilder<T?>? selectedItemBuilder;
  final Future<List<T>> Function(String value)? onSearch;
  final EdgeInsets? itemsListPadding, listPadding, menuMargin, padding;

  final int? viewHeight;
  final BoxDecoration? buttonDecoration;
  final EdgeInsets? buttonMargin;
  final EdgeInsets? buttonPadding;
  final String? buttonTitle;
  final TextStyle? buttonTextStyle;
  final TextAlign? buttonTextAlign;
  final Widget? buttonIcon;
  final bool canShowButton;
  final VoidCallback? buttonTab;
  final String? Function(String?)? validator;

  FromFiledDropDown({
    super.key,
    this.item,
    this.onTap,
    this.padding,
    this.onSearch,
    this.focusNode,
    this.menuMargin,
    this.listPadding,
    this.cursorColor,
    this.viewHeight,
    this.initialItem,
    this.cursorRadius,
    this.showCursor,
    this.cursorHeight,
    this.cursorWidth,
    this.loaderWidget,
    this.errorMessage,
    this.overlayHeight,
    this.menuDecoration,
    this.itemsListPadding,
    this.cursorErrorColor,
    this.filedReadOnly = false,
    this.readOnly = false,
    this.buttonTab,
    this.buttonTextAlign,
    this.buttonMargin,
    this.buttonIcon,
    this.buttonPadding,
    this.buttonTitle,
    this.autovalidateMode,
    this.canShowButton = false,
    this.buttonTextStyle,
    this.buttonDecoration,
    this.validator,
    required this.textController,
    required this.textStyle,
    required this.onChanged,
    required this.controller,
    this.selectedItemBuilder,
    this.isApiLoading = false,
    required this.listItemBuilder,
    required this.filedDecoration,
  });

  @override
  State<FromFiledDropDown<T>> createState() => _FromFiledDropDownState<T>();
}

class _FromFiledDropDownState<T> extends State<FromFiledDropDown<T>> {
  T? selectedItem;
  late List<T> items;
  final layerLink = LayerLink();
  bool displayOverlayBottom = true;
  final GlobalKey textFieldKey = GlobalKey();
  final key1 = GlobalKey(), key2 = GlobalKey();

  double baseOnHeightCalculate() {
    const double itemHeight = 38.0;

    if (widget.canShowButton) {
      return items.length * itemHeight + 35;
    }

    if(items.isNotEmpty) return items.length * itemHeight;
    return 80;
  }
  double calculateHeight() {
    const double staticHeight = 150.0; // Static value fallback
    final double calculatedHeight = baseOnHeightCalculate();

    // If widget.overlayHeight is not provided, use staticHeight
    final double maxHeight = widget.overlayHeight ?? staticHeight;

    print(calculatedHeight > maxHeight ? maxHeight : calculatedHeight);
    // Return the smaller value between the calculated height and maxHeight
    return calculatedHeight > maxHeight ? maxHeight : calculatedHeight;
  }

  BoxDecoration menuDecoration(){
    if (widget.menuDecoration != null) return widget.menuDecoration!;

    return BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(5)
    );
  }


  @override
  void initState() {
    super.initState();
    items = [];
    print("init 1");
    Future.delayed(Duration.zero, () async {
      if(widget.focusNode!=null){
        print("init 2");
        widget.focusNode!.addListener(() async {
          print("init 3");
          if(widget.focusNode!.hasFocus){
            print("init 4");
            if(widget.onTap!=null){
              print("init 5");
              items = await widget.onTap!();
            }
          }
        });
      }

      widget.textController.text = selectedItemConvertor(listData: widget.initialItem)??"";

      WidgetsBinding.instance.addPostFrameCallback((_) async {
        items = widget.item ?? [];
        if (key1.currentContext != null || key2.currentContext != null) {
          print("init 6");
          final RenderBox? render1 =
          key1.currentContext?.findRenderObject() as RenderBox?;
          final RenderBox? render2 =
          key2.currentContext?.findRenderObject() as RenderBox?;

          if (render1 != null && render2 != null) {
            print("init 7");
            final screenHeight = MediaQuery.of(context).size.height;
            double y = render1.localToGlobal(Offset.zero).dy;

            if (screenHeight - y < render2.size.height) {
              print("init 8");
              displayOverlayBottom = false;
            }
          }
        }else{
          print("init 9");
        }
      });
    });
  }


  String? selectedItemConvertor({T? listData}) {
    if (widget.selectedItemBuilder != null && listData != null) {
      return (widget.selectedItemBuilder!(context, item: listData as T)).data;
    }
    return null;
  }

  @override
  void didUpdateWidget(covariant FromFiledDropDown<T> oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.item != oldWidget.item) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        print("didUpdate 1");
        items = widget.item!;
      });
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {

      if(widget.initialItem != oldWidget.initialItem){
        print("didUpdate 2");
        if(widget.initialItem == null){
          print("didUpdate 3");
          selectedItem = null;
          widget.onChanged(null);
          widget.textController.clear();
          if(widget.onSearch != null) widget.onSearch!("");
        }
      }

      if(selectedItem != null ){
        print("didUpdate 4");
        widget.textController.text = selectedItemConvertor(listData: selectedItem)!;
      }

      // print(widget.textController.text);
      // print(oldWidget.textController.text);

      if(widget.textController != oldWidget.textController){
        print("didUpdate 5");
        if(widget.onSearch != null) widget.onSearch!("");
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    // print(items);

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
                print("GestureDetector 1");
                widget.onSearch!("");
              }
            };
            widget.controller.hide();
          },
          child: Container(
            color: Colors.transparent,
            child: Stack(
              children: [
                CompositedTransformFollower(
                    link: layerLink,
                    offset: Offset(0, displayOverlayBottom ? 55 : -10),
                    followerAnchor: displayOverlayBottom ? Alignment.topLeft : Alignment.bottomLeft,
                    child: SizedBox(
                      key: key1,
                      width: renderBox?.size.width ?? 0,
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
                            showLoader()
                                :
                            (items).isEmpty
                                ?
                            emptyErrorWidget()
                                :
                            uiListWidget()
                        ),
                      ),
                    )
                ),
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




  Widget showLoader(){
    return Container(
      alignment: Alignment.center,
      decoration: menuDecoration(),
      height:calculateHeight(),
      child: Center(
        child: widget.loaderWidget ?? const CircularProgressIndicator(),
      ),
    );
  }

  textFiledOnTap()async {
    if(!(widget.readOnly)) {
      print("textFiledOnTap 1");
      widget.controller.show();
      if (widget.onTap != null) items = await widget.onTap!();
      print("textFiledOnTap 2");
      setState(() {});
    }else{
      print("textFiledOnTap 3");
    }
  }

  onChange(value) async {
    if (value.isEmpty) {
      print("onChange 1");
      selectedItem = null;
      widget.onChanged(null);
      onSearchCalled(value);
    }else {
      print("onChange 2");
      onSearchCalled(value);
    }
    setState(() {});
  }

  onSearchCalled(value) async {
    if (widget.onSearch != null) items = await widget.onSearch!(value);
  }

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
              InkWell(
                onTap: () {
                  widget.buttonTab!();
                  widget.controller.hide();
                },
                child: Container(
                  height: 40,
                  padding: widget.buttonPadding ?? const EdgeInsets.all(10),
                  margin: const EdgeInsets.only(top: 5),
                  decoration:buttonDecoration(),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                            widget.buttonTitle ?? "Add",
                            maxLines: 1,
                            textAlign: widget.buttonTextAlign?? TextAlign.start,
                            overflow: TextOverflow.ellipsis,
                            style: widget.buttonTextStyle ??const TextStyle()
                        ),
                      ),
                      widget.buttonIcon?? defaultIcon()
                    ],
                  ),
                ),
              ),
            const SizedBox(height:2),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                physics:
                const ClampingScrollPhysics(),
                addAutomaticKeepAlives: false,
                addRepaintBoundaries: false,
                padding: widget.listPadding ?? EdgeInsets.zero,
                itemCount: items.length,
                itemBuilder: (_, index) {
                  bool selected = selectedItemConvertor(listData: items[index]) == (selectedItemConvertor(listData: selectedItem) ?? "");
                  return InkWell(
                    hoverColor: Colors.transparent,
                    onTap: ()=> onItemSelected(index),
                    child: Padding(
                      padding: widget.itemsListPadding ?? EdgeInsets.zero,
                      child: widget.listItemBuilder(
                          context,
                          items[index], selected, () {}
                      ),
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


  onItemSelected(index){
    print("onItemSelected 1");
    widget.controller.hide();
    widget.onChanged(items[index]);
    selectedItem = items[index];
    widget.textController.text = selectedItemConvertor(listData: selectedItem)??"";
    setState(() {});
  }

  Widget defaultIcon(){
    return const Icon(
      Icons.add,
      color: Colors.white,
    );
  }

  Widget emptyErrorWidget(){
    return Container(
      alignment: Alignment.center,
      decoration: menuDecoration(),
      height: 50,
      child: widget.errorMessage ?? const Text("No options"),
    );
  }

  BoxDecoration buttonDecoration(){
    if(widget.buttonDecoration != null) return widget.buttonDecoration!;
    return BoxDecoration(
      color: Colors.green,
      borderRadius: BorderRadius.circular(2),
    );
  }

}


