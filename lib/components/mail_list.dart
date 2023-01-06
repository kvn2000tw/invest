import 'package:flutter/material.dart';
import '../custom/custom_theme.dart';
import '../data.dart';

class MailList extends StatelessWidget {

  bool star = false;
  bool has_open = false;
  
  late String text;
  late String date;
  late String no;
  Map<String,dynamic> map;

  MailList({required this.map})
  {
    text = map['name'];
    date = map['date'];
    no = map['no'];
    if(map['favorite'] == 1)
        star = true;

    if(map['has_open'] == 1)
    {
      has_open = true;
    }
  
  }
  @override
  Widget build(BuildContext context) {

    String star_image = 'assets/images/star.png';

    Color bg = Data.mail_grey;

    if(this.star == false)
    {
      star_image = 'assets/images/star-e.png';
      
    }

  var weight = FontWeight.bold;

  if(has_open)
  {
    weight = FontWeight.normal;
    bg = Data.mail_white;

  }
  return InkWell(
    onTap: (){
      print("list clicked"); 
     
      Data.url = '${Data.home_page}user/vip_contents/${no}?view_source_from=app';
    
      Data.update_status(Status.Browser);
      Data.update_view_change();
    },child:Container(
    
    decoration: BoxDecoration(
      color:bg,
      border: Border(top:BorderSide(color: Data.grey),bottom:BorderSide(color: Data.grey))
    ),
    child: Row(
      mainAxisSize: MainAxisSize.max,
      children: [
      Padding(
        padding: EdgeInsetsDirectional.fromSTEB(10, 10, 0, 10),
        child: Image.asset(
          star_image,
          width: 18,
          height: 17,
          fit: BoxFit.contain,
        ),
      ),
      Expanded(
        child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(10, 10, 0, 10),
          child: Text(
            text,
            maxLines: 3,
            style: FlutterFlowTheme.of(context).bodyText1.override(
              fontFamily: 'Poppins',
              fontSize: 14,
              fontWeight: weight,
            ),
          ),
        ),
      ),
      
      Padding(
        padding: EdgeInsetsDirectional.fromSTEB(10, 10, 0, 10),
        child: Text(
          date,
          style: FlutterFlowTheme.of(context).bodyText1.override(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.normal,
        ),
      ),
      ),
    ],
    ),
    ));
  }
}