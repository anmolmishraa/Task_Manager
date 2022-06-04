import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../const/ConstText.dart';
import '../const/colour.dart';

class NewTaskAdd extends StatefulWidget {
  const NewTaskAdd({Key? key}) : super(key: key);

  @override
  _NewTaskAddState createState() => _NewTaskAddState();
}

class _NewTaskAddState extends State<NewTaskAdd> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:ConstColor.NewTaskAppBarColor ,

      appBar: AppBar(
        backgroundColor: ConstColor.NewTaskAppBarColor,
        title: Text(ConstText.NewTasktitleAppBar,style: GoogleFonts.pacifico(color:ConstColor.NewTaskTextAppBarColor ),),
        centerTitle: true,
        elevation: 0,
       leading:  Icon(Icons.arrow_back_ios_new,color:Colors.black),
      ),

      body: Padding(
        padding: const EdgeInsets.only(left: 10,right: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
crossAxisAlignment: CrossAxisAlignment.start,

          children: [
Divider(thickness: 1,color: ConstColor.NewTaskTextAppBarColor ,),
            Padding(padding: EdgeInsets.only(top: 15,bottom: 10),
            child: Text(ConstText.NewTasktitle,style: GoogleFonts.openSans(fontWeight: FontWeight.bold,fontSize: 18))
            ),

            TextField(
              decoration: InputDecoration(
               hintText: 'Task Name',
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(width: 2, color: ConstColor.AppBarBackground),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(width: 2, color:ConstColor.AppBarBackground),
                    borderRadius: BorderRadius.circular(10),
                  )),
            ),
            Padding(padding: EdgeInsets.only(top: 15,bottom: 10),
                child: Text(ConstText.NewTaskCategory,style: GoogleFonts.openSans(fontWeight: FontWeight.bold,fontSize: 18))
            ),







          ],

        ),
      ),



    );
  }
}

