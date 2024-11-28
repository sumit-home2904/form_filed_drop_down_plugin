import 'package:flutter/material.dart';
import 'AnimatedSection.dart';
import 'Signatures.dart';

class DropdownTextField<T> extends StatefulWidget {
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
  final TextEditingController textController;
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

  const DropdownTextField({
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
  State<DropdownTextField<T>> createState() => _DropdownTextFieldState<T>();
}

class _DropdownTextFieldState<T> extends State<DropdownTextField<T>> {
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

    Future.delayed(Duration.zero, () async {
      if(widget.focusNode!=null){
        widget.focusNode!.addListener(() async {
          if(widget.focusNode!.hasFocus){
            if(widget.onTap!=null){
              items = await widget.onTap!();
            }
          }
        });
      }

      WidgetsBinding.instance.addPostFrameCallback((_) async {
        items = widget.item ?? [];
        if (key1.currentContext != null || key2.currentContext != null) {
          final RenderBox? render1 =
          key1.currentContext?.findRenderObject() as RenderBox?;
          final RenderBox? render2 =
          key2.currentContext?.findRenderObject() as RenderBox?;

          if (render1 != null && render2 != null) {
            final screenHeight = MediaQuery.of(context).size.height;
            double y = render1.localToGlobal(Offset.zero).dy;

            if (screenHeight - y < render2.size.height) {
              displayOverlayBottom = false;
            }
          }
        }


      });
      setState(() {});
    });
  }


  String? selectedItemConvertor({T? listData}) {
    if (widget.selectedItemBuilder != null && listData != null) {
      return (widget.selectedItemBuilder!(context, item: listData as T)).data;
    }
    return null;
  }

  @override
  void didUpdateWidget(covariant DropdownTextField<T> oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.item != oldWidget.item && (widget.item ?? []).isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        items = widget.item!;
      });
    }

    if(widget.textController != oldWidget.textController){
      if(widget.onSearch != null) widget.onSearch!("");
    }

    if(selectedItem != null ){
      widget.textController.text = selectedItemConvertor(listData: selectedItem)!;
    }
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
            widget.controller.hide();
          },
          child: Container(
            color: Colors.transparent,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            // padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Stack(
              children: [
                CompositedTransformFollower(
                    link: layerLink,
                    offset: Offset(0, displayOverlayBottom ? 45 : -10),
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


  double baseOnHeightCalculate(){
    const double itemHeight = 30.0;

    if(widget.canShowButton){
      return items.length * itemHeight + 35;
    }

    return items.length * itemHeight;
  }

  double calculateHeight(){

    if(widget.overlayHeight != null){
      if(baseOnHeightCalculate() > widget.overlayHeight!){
        return widget.overlayHeight!;
      }else{
        return baseOnHeightCalculate();
      }
    }
    return baseOnHeightCalculate();
  }

  BoxDecoration menuDecoration(){
    if (widget.menuDecoration != null) return widget.menuDecoration!;

    return BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(5)
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
      widget.controller.show();
      if (widget.onTap != null) items = await widget.onTap!();
      setState(() {});
    }else{
      FocusScope.of(context).unfocus();
    }
  }

  onChange(value) async {
    if (value.isEmpty) {
      selectedItem = null;
      widget.onChanged(null);
      onSearchCalled(value);
    }

    onSearchCalled(value);
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
                    onTap: () {
                      widget.controller.hide();
                      widget.onChanged(items[index]);
                      selectedItem = items[index];
                      setState(() {});
                    },
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


