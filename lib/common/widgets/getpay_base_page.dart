import 'package:flutter/material.dart';

class GetPayBasePage extends StatelessWidget {
  final Widget? child;
  final Widget? appBar;
  final Widget? drawer;
  final double appBarHeight;
  final String alignment;
  final double childWidgetBottomPadding;

  GetPayBasePage({
    this.appBar,
    this.child,
    this.drawer,
    this.appBarHeight = 0,
    this.alignment = "center",
    this.childWidgetBottomPadding = 25.0,
  });

  Size get preferredSize => new Size.fromHeight(appBarHeight);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: preferredSize,
        child: Container(child: appBar),
      ),
      drawer: drawer,
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: [
            alignment.toLowerCase() == "center" ? Center(child: Padding(
                padding: EdgeInsets.only(top: 16.0, bottom: 0.0),
                child: child)) : Padding(padding: EdgeInsets.only(top: 0.0, bottom: 0.0), child: child?? Text(""))
          ],
        ),
      ),
      extendBodyBehindAppBar: true,
      bottomNavigationBar: BottomAppBar(elevation: 0, color: Colors.yellow),
    );
  }

}
