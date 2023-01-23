import 'package:dynamic_form/constants/dynamic_form_constants.dart';
import 'package:dynamic_form/widgets/shadow__container.dart';
import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  Widget child;
  Function() onTap;
  bool includePadding;
  bool showDivider;

  CustomListTile(
      {this.child,
        this.onTap,
        this.includePadding = true,
        this.showDivider = true});

  @override
  Widget build(BuildContext context) {
    return ShadowContainer(
      color: Colors.transparent,
      elevation: 0.0,
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: double.infinity,
            child: includePadding
                ? Padding(padding: const EdgeInsets.all(16.0), child: child)
                : child,
          ),
          showDivider ? Divider(height: 0.0) : nothing,
        ],
      ),
    );
  }
}