import 'package:flutter/material.dart';
import '../custom/custom_theme.dart';
import '../data.dart';
import 'head_ele.dart';
class MailHead extends StatelessWidget {

  final ValueNotifier<int> tag_index = ValueNotifier(0);
  List<bool> enable_arr = [false,false,false,false,];

  final  tags = ['TAG','全文'];
  MailHead()
  {
    enable_arr[Data.selectHead] = true;
  }
  Widget _dropdownBuilder(BuildContext context, int selectedItem, Widget? child) {
   return Container( 
      decoration: BoxDecoration(
    
      border: Border.all(color:Data.grey),
    ),
   child:DropdownButton(
      items: <DropdownMenuItem> [
        DropdownMenuItem(
          child: Text(tags[0], style: const TextStyle(fontSize: 14),),
          value: 0,
        ),
      DropdownMenuItem(
          child: Text(tags[1], style: const TextStyle(fontSize: 14),),
          value: 1,
        ),
      ],
      onChanged: (dynamic value) => {tag_index.value = value},
      hint: const Text('TAG', style: TextStyle(fontSize: 14),),
      value: tag_index.value,//selectedItem < 0 ? null : selectedItem,
    ));

  }
  void _headChange(int value)
  {
    Data.selectHead = value;
    Data.update_view_change();
  }
  _searchHead()
  {
    print('_searchHead');
  }
  _myFavorite()
  {
    print('_myFavorite');
  }  
  @override
  Widget build(BuildContext context) {

    final TextEditingController textController = TextEditingController(text:'');
    bool? checkboxListTileValue;

    final title1 =Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
     
      child: Container(
        //width: 390,
        height: 51,
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).secondaryBackground,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
          Align(
            alignment: AlignmentDirectional(0, 0),
            child: HeadEle(text:'總覧',enable:enable_arr[0],
            onTag:(){_headChange(0);},
            ),
          ),
          HeadEle(text:'週報',enable:enable_arr[1],
          onTag:(){_headChange(1);},),
          HeadEle(text:'產業報告',width:90,enable:enable_arr[2],
          onTag:(){_headChange(2);},),
          HeadEle(text:'個股報告',width:90,enable:enable_arr[3],
          onTag:(){_headChange(3);},),
         
        ],
      ),
    ),
  );


  final title2 =
  
  Container(
    //width: 390,
    height: 50,
    decoration: BoxDecoration(
      color: FlutterFlowTheme.of(context).secondaryBackground,
    ),
    child: Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(41, 0, 0, 0),
          child: InkWell(
            onTap:(){_myFavorite();},
            child:Container(
            width: 54,
            height: 21,
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).secondaryBackground,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                 Container(
                  width: 21,
                  height: 21,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                  ),
                  child: Image.asset(
                    'assets/images/star.png',
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  width: 30,
                  height: 21,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                  ),
                  child: Text(
                    '最愛',
                    style: FlutterFlowTheme.of(context).bodyText1.override(
                        fontFamily: 'Poppins',
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
            ],
            ),
          ),
        )),
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
          child: Container(
            width: 140,
            height: 30,
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).secondaryBackground,
              //border: Border.all(color: Colors.blueAccent)
            ),
            child: Align(
              alignment: AlignmentDirectional(0, 0),
              child: TextFormField(
                controller: textController,
                obscureText: false,
                decoration: InputDecoration(
                  hintText: '搜尋郵件',
                  hintStyle: FlutterFlowTheme.of(context).bodyText2,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                    color: Data.black,
                    width: 1,
                  ),
                  borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(4.0),
                  topRight: Radius.circular(4.0),
                ),
              ),
              focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Data.black,
                width: 1,
              ),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(4.0),
                topRight: Radius.circular(4.0),
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Color(0x00000000),
                width: 1,
              ),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(4.0),
                topRight: Radius.circular(4.0),
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(
              color: Color(0x00000000),
              width: 1,
            ),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(4.0),
              topRight: Radius.circular(4.0),
            ),
          ),
          contentPadding: EdgeInsetsDirectional.fromSTEB(5, 5, 0, 0),
        ),
        style: FlutterFlowTheme.of(context).bodyText1,
        textAlign: TextAlign.start,
      ),
    ),
  ),
  ),
      Padding(
        padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
        child: Container(
          width: 64,
          height: 30,
          decoration: BoxDecoration(
            color: FlutterFlowTheme.of(context).secondaryBackground,
          ),
          child:ValueListenableBuilder<int>(
            builder: _dropdownBuilder,
            valueListenable: tag_index,
          ) 
        ),
      ),
      InkWell(
    onTap:(){_searchHead();},
      child:Container(
        margin: const EdgeInsets.fromLTRB(20.0,10,10,10),
        width: 20,
        height: 20,
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).secondaryBackground,
        ),
        child: Image.asset(
          'assets/images/search.png',
          width: 100,
          height: 100,
          fit: BoxFit.contain,
        ),
      ),
    )],
  ),
);

  return Column(
    children:[title1,title2]
  );
  }
}  