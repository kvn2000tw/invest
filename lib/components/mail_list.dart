import 'package:flutter/material.dart';
import '../custom/custom_theme.dart';
import '../data.dart';

class MailList extends StatelessWidget {

  late bool star;
  late bool is_bg_white;
  late String text;
  late String date;

  MailList({bool star=false,bool is_bg_white=false,required String text,required String date})
  {
    this.star = star;
    this.is_bg_white = is_bg_white;
    this.text = text;
    this.date = date;
  }
  @override
  Widget build(BuildContext context) {

    String star_image = 'assets/images/star.png';

    Color bg = Data.mail_grey;

    if(this.star == false)
    {
      star_image = 'assets/images/star-e.png';
      bg = Data.mail_white;
    }

  return Container(
    
    decoration: BoxDecoration(
      color:bg,
      border: Border.all(color: Colors.black)
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
              fontWeight: FontWeight.normal,
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
    );
  }
}