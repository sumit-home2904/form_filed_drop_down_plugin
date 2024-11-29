import 'package:flutter/material.dart';

typedef ListItemBuilder<T> = Widget Function(
    BuildContext context, T item,
    bool isSelected, VoidCallback onItemSelect,
);

typedef SelectedItemBuilder<T> = Text Function(
    BuildContext context, {T? item}
);
