import 'dart:html';
import 'package:google_fonts/google_fonts.dart';
import 'package:drag_and_drop_lists/drag_and_drop_item.dart';
import 'package:drag_and_drop_lists/drag_and_drop_list.dart';
import 'package:drag_and_drop_lists/drag_and_drop_lists.dart';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart';

import '../const/ConstText.dart';
import '../const/colour.dart';
import '../data/draggable_lists.dart';
import '../model/draggable_list.dart';





class MainPage extends StatefulWidget {
  @override
  _MainPage createState() => _MainPage();
}

class _MainPage extends State<MainPage> {
  late List<DragAndDropList> lists;
  var _selectedDestination;

  @override
  void initState() {
    super.initState();

    lists = allLists.map(buildList).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ConstColor.ScaffoldbackgroundColor,
      endDrawer: EndDrawer(),

      appBar: AppBar(
        backgroundColor: ConstColor.AppBarBackground,
        title: Text(ConstText.Consttitle,style: GoogleFonts.pacifico(fontWeight: FontWeight.bold),),
        centerTitle: true,
      ),
      body: DragAndDropLists(

        // lastItemTargetHeight: 50,
        // addLastItemTargetHeightToTop: true,
        // lastListTargetSize: 30,
        listPadding: EdgeInsets.all(16),
        listInnerDecoration: BoxDecoration(
          color: ConstColor.ListBoxColor,
          borderRadius: BorderRadius.circular(10),
        ),
        children: lists,
        itemDivider: Divider(
            thickness: 4, height: 4, color: ConstColor.ScaffoldbackgroundColor),
        itemDecorationWhileDragging: BoxDecoration(
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
        ),
        listDragHandle: buildDragHandle(isList: true),
        itemDragHandle: buildDragHandle(),
        onItemReorder: onReorderListItem,
        onListReorder: onReorderList,
      ),
    );
  }

  DragHandle buildDragHandle({bool isList = false}) {
    final verticalAlignment = isList
        ? DragHandleVerticalAlignment.top
        : DragHandleVerticalAlignment.center;
    final color = isList ? Colors.blueGrey : Colors.black26;

    return DragHandle(
      verticalAlignment: verticalAlignment,
      child: Container(
        padding: EdgeInsets.only(right: 10),
        child: Icon(Icons.menu, color: color),
      ),
    );
  }

  DragAndDropList buildList(DraggableList list) => DragAndDropList(
    header: Container(
      padding: EdgeInsets.all(8),
      child: Text(
        list.header,
        style:  TextStyle(fontSize: 18,fontWeight: FontWeight.bold),
      ),
    ),
    children: list.items
        .map((item) => DragAndDropItem(
      child: ListTile(
        leading: Image.network(
          item.urlImage,
          width: 40,
          // height: 40,
          fit: BoxFit.cover,
        ),
        title: Text(item.title),

        // subtitle: Text(item.id),
      ),
    ))
        .toList(),
  );

  onReorderListItem(
      int oldItemIndex,
      int oldListIndex,
      int newItemIndex,
      int newListIndex,
      ) {
    setState(() {
      final oldListItems = lists[oldListIndex].children;
      final newListItems = lists[newListIndex].children;

      final movedItem = oldListItems.removeAt(oldItemIndex);
      newListItems.insert(newItemIndex, movedItem);

      print("");
    });
  }

  void onReorderList(
      int oldListIndex,
      int newListIndex,
      ) {
    setState(() {
      final movedList = lists.removeAt(oldListIndex);
      lists.insert(newListIndex, movedList);
    });
  }

  Widget EndDrawer() {
    return Drawer(
      child: ListView(
        scrollDirection: Axis.vertical,
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  'Task Manager',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
                Column(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundImage: NetworkImage(
                          "https://images.pexels.com/photos/2379004/pexels-photo-2379004.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500"),
                      backgroundColor: ConstColor.CircleAvatarImageBackGround,
                    ),
                    Text("Jon",style: GoogleFonts.pacifico(fontSize: 15),)
                  ],
                )
              ],
            ),
          ),
          Divider(
            height: 1,
            thickness: 1,
          ),

          Padding(
            padding: const EdgeInsets.only(top: 15,),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width*.25,
                  height: 50,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage("data:image/png;base64,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"),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: null /* add child content here */,
                ),
                Text("Project Name ",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
              ],
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.border_all,
            ),
            title: Text('EP board'),
            selected: _selectedDestination == 0,
            onTap: () => selectDestination(0),
            selectedColor: _selectedDestination == 0
                ? ConstColor.CircleAvatarImageBackGround
                : Colors.black,
          ),
          ListTile(
            leading: Icon(Icons.computer),
            title: Text('Issues'),
            selected: _selectedDestination == 1,
            onTap: () => selectDestination(1),
            selectedColor: _selectedDestination == 1
                ? ConstColor.CircleAvatarImageBackGround
                : Colors.black,
          ),
          ListTile(
            leading: Icon(Icons.settings_input_component_outlined),
            title: Text('Components'),
            selected: _selectedDestination == 2,
            onTap: () => selectDestination(2),
            selectedColor: _selectedDestination == 2
                ? ConstColor.CircleAvatarImageBackGround
                : Colors.black,
          ),

          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'DEVELOPMENT',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
            ),
          ),
          ListTile(
            leading: Icon(Icons.code_off_outlined),
            title: Text('Code'),
            selected: _selectedDestination == 3,
            onTap: () => selectDestination(3),
            selectedColor: _selectedDestination == 3
                ? ConstColor.CircleAvatarImageBackGround
                : Colors.black,
          ),
          ListTile(
            leading: Icon(Icons.new_releases_outlined),
            title: Text('Releases'),
            selected: _selectedDestination == 4,
            onTap: () => selectDestination(4),
            selectedColor: _selectedDestination == 4
                ? ConstColor.CircleAvatarImageBackGround
                : Colors.black,
          ),
          Divider(height: 1,),

          ListTile(
            leading: Icon(Icons.pages_rounded),
            title: Text('Project Pages'),
            selected: _selectedDestination == 5,
            onTap: () => selectDestination(5),
            selectedColor: _selectedDestination == 5
                ? ConstColor.CircleAvatarImageBackGround
                : Colors.black,
          ),

          SizedBox(height: MediaQuery.of(context).size.height*.2,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              CircleAvatar(
                radius: 18,
                backgroundColor: Colors.white,
                backgroundImage: AssetImage("images/facebook.png"),
              ),
              CircleAvatar(
                radius: 18,
                backgroundColor: Colors.white,
                backgroundImage: AssetImage("images/google.png"),
              ),
              CircleAvatar(
                radius: 18,
                backgroundColor: Colors.white,
                backgroundImage: AssetImage("images/linkdin.png"),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void selectDestination(int index) {
    setState(() {
      _selectedDestination = index;
    });
  }


}
