import 'package:flutter/material.dart';
import '../custom/custom_theme.dart';
import 'dart:convert';
import '../data.dart';
import '../service.dart';
class AlarmMsg extends StatelessWidget {
  late String no_see;
  late List<String> items;
  List<String> sub_items = [];
  
  AlarmMsg(String no_see,List<String> items,List<String> sub_items)
  {
    this.no_see = no_see;
    this.items = items;

    for(var i=0;i<sub_items.length;i++)
    {
      var ele = sub_items[i].split("T");
      var time = ele[1].split(":");
      this.sub_items.add(ele[0]+' '+time[0]+":"+time[1]);
    }
   
  }
  _nonews(BuildContext context) async
  {
    print('no news');
    await pressReturn(context);

    await Service.seeAll();
    
  }


    _readAll(BuildContext context) async
  {
    print('read all');
    
    await pressReturn(context);
    final ret =  Service.getArticles();
           
    ret.then((value)=>Service.updateArticles(value));
  }
  pressReturn(BuildContext context)
  {
  
    Navigator.pop(context, '');
  }

  @override
  Widget build(BuildContext context) {
   
   const msg_icon = 'assets/images/msg.png';

    final length = items.length  > 5 ? 5:items.length;

    final listView = ListView.separated(
      itemCount: length,
      itemBuilder: (context, index) =>
          ListTile(
            title: Text(items[index], style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
            subtitle:Text(sub_items[index], style: const TextStyle(fontSize: 16),),
            onTap: () => {},//_selectedItem.value = '點選' + items[index],
            leading: Container(
              width:25,
              height:25,
              child: CircleAvatar(backgroundImage: AssetImage(msg_icon,),backgroundColor:Data.white),
              padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 1),
              ),
            //trailing: const Icon(Icons.keyboard_arrow_right,),
           
          ),
      separatorBuilder: (context, index) => const Divider(),
  );
    return  Dialog(
      
      child:ColoredBox(
        color:Data.white,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).secondaryBackground,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          color:
                              FlutterFlowTheme.of(context).secondaryBackground,
                        ),
                        child: Align(
                          alignment: AlignmentDirectional(0, 0),
                          child: Text(
                            no_see,
                            style:
                                FlutterFlowTheme.of(context).bodyText1.override(
                                      fontFamily: 'Poppins',
                                      fontSize: 20,
                                      color:Data.blue,
                                      fontWeight: FontWeight.bold,
                                    ),
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: AlignmentDirectional(0, 0),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 20, 0),
                        child: Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                          ),
                        child: TextButton(
                          child: Text(
                            'X',
                            style: TextStyle(fontSize: 20, color: FlutterFlowTheme.of(context).customColor6),
                          ),
                          style: ElevatedButton.styleFrom(
                          
                          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                        
                          ),
                          onPressed: () => pressReturn(context),
                        ),    
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                height: 400,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).secondaryBackground,
                ),
                child: listView,
              ),
              Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).secondaryBackground,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      width: 100,
                      height: 50,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).secondaryBackground,
                      ),
                      child: Align(
                        alignment: AlignmentDirectional(0.15, 0),
                          child:TextButton(                    
                            style: TextButton.styleFrom(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0, 0, 0, 0),
                                textStyle: TextStyle(fontSize: 16,color:Colors.blue),
                            ),
                            child: Text(
                              '全部已讀',
                              style:TextStyle(fontSize: 20,color:Data.blue),
                              ),
                              onPressed: () => {_nonews(context)},
                          ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          color:
                              FlutterFlowTheme.of(context).secondaryBackground,
                        ),
                        child: Align(
                          alignment: AlignmentDirectional(0.7, 0),
                          child:TextButton(                    
                            style: TextButton.styleFrom(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0, 0, 0, 0),
                                textStyle: TextStyle(fontSize: 16,color:Colors.blue),
                            ),
                            child: Text(
                              '查看全部',
                              style:TextStyle(fontSize: 20,color:Data.blue),
                              ),
                              onPressed: () => {_readAll(context)},
                          ),                        
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
    ));
    }
  }