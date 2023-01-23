import 'package:dynamic_form/config/app_colors.dart';
import 'package:dynamic_form/config/app_dimen.dart';
import 'package:dynamic_form/config/app_styles.dart';
import 'package:dynamic_form/models/selectable.dart';
import 'package:dynamic_form/utils/device_utils.dart';
import 'package:dynamic_form/utils/widget_utils.dart';
import 'package:dynamic_form/widgets/custom_button.dart';
import 'package:dynamic_form/widgets/custom_list_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomSelectableBottomSheet extends StatefulWidget {
  String title;
  List<Selectable> selectableList;
  Function(Selectable) onValueSelected;

  CustomSelectableBottomSheet(
      {this.title, this.selectableList, this.onValueSelected})
      : assert(selectableList != null);

  @override
  _CustomSelectableBottomSheetState createState() =>
      _CustomSelectableBottomSheetState();
}

class _CustomSelectableBottomSheetState
    extends State<CustomSelectableBottomSheet> {
  bool isSearchMode = false;
  String filterText = "";
  Widget titleWidget;
  Widget searchWidget;
  Widget selectedWidget;
  TextEditingController searchController = TextEditingController();
  final MAX_LENGTH = 15;

  @override
  void initState() {
    super.initState();
    searchWidget = Padding(
      padding: const EdgeInsets.symmetric(horizontal:AppDimen.medium),
      child: TextFormField(
        onChanged: (value) {
          if(searchController.text.trim().length >2) {
            setState(() {
              filterText = searchController.text.trim();
            });
          }else if(searchController.text.trim().length == 0){
            setState(() {
              filterText = "";
            });
          }
        },
        controller: searchController,
        enableInteractiveSelection: false,
        decoration: InputDecoration(
            hintText: widget.title ?? "",
            hintStyle: largeTextStyle(color: AppColors.inputContainerTitleColor),
            suffixIcon: GestureDetector(
                onTap: () {
                  setState(() {
                    isSearchMode = false;
                    selectedWidget = titleWidget;
                    filterText = "";
                  });
                },
                child: Icon(
                  Icons.close,
                  color: AppColors.grey,
                ))),
      ),
    );
    titleWidget = Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppDimen.medium),
      child: Row(
        children: [
          Visibility(
              visible: false,
              maintainAnimation: true,
              maintainSize: true,
              maintainState: true,
              child: Icon(
                Icons.search,
                color: AppColors.inputContainerTitleColor,
              )),
          Expanded(
            child: Text(
              widget.title ?? "",
              textAlign: TextAlign.center,
              style: largeTextStyle(color: AppColors.inputContainerTitleColor),
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                isSearchMode = !isSearchMode;
                selectedWidget = searchWidget;
              });
            },
            child: Visibility(
              visible: widget.selectableList.length>MAX_LENGTH,
              maintainAnimation: true,
              maintainSize: true,
              maintainState: true,
              child: Icon(
                Icons.search,
                color: AppColors.inputContainerTitleColor,
              ),
            ),
          ),
        ],
      ),
    );
    selectedWidget = titleWidget;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        needExpanded(context, widget.selectableList.length)
            ? Expanded(
          child: _buildDialogBody(),
        )
            : _buildDialogBody(),
        verticalMargin(AppDimen.medium),
        CustomButton(
          onButtonTapped: () => Navigator.pop(context),
          title: "Cancel",
          borderRadius: 0.0,
          buttonColor: AppColors.customerTextGrey,
        )
      ],
    );
  }

  _buildDialogBody() {
    return Container(
      decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.all(Radius.circular(0.0))),
      padding: EdgeInsets.only(top: AppDimen.medium, bottom: AppDimen.medium),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          AnimatedSwitcher(
            duration: Duration(milliseconds: 500),
            child: selectedWidget,
          ),
          verticalMargin(),
          isSearchMode?
          Expanded(
            child: Scrollbar(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: buildList(),
              ),
            ),
          ):Flexible(
              child: Scrollbar(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: buildList(),
                ),
              )
          )
        ],
      ),
    );
  }

  needExpanded(BuildContext context, int length) {
    int possibleHeight = length * 80;
    return possibleHeight > DeviceUtils.getHeight(context, percentage: 70);
  }

  buildList() {
    if(isSearchMode && !filterText.isEmpty) {
      List<Selectable> list = List();
      for(int i =0;i< widget.selectableList.length;i++) {
        if(widget.selectableList[i].title.toLowerCase().contains(filterText.toLowerCase())) {
          list.add(widget.selectableList[i]);
        }
      }
      return buildSelectableList(list);
    }else {
      return buildSelectableList(widget.selectableList);
    }
  }

  buildSelectableList(List<Selectable> selectableList) {
    return ListView.builder(
      itemCount: selectableList.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return CustomListTile(
          showDivider: index < selectableList.length - 1,
          child: Text(
              selectableList[index].title??"".toUpperCase(),
              textAlign: TextAlign.center,
              style: largeTextStyle(color:AppColors.orange,fontWeight: FontWeight.bold)),
          onTap: () {
            Navigator.pop(context);
            widget.onValueSelected(selectableList[index]);
          },
        );
      },
    );
  }
}