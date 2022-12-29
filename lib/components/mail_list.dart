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
    if(this.star == false)
    {
      star_image = 'assets/images/star-e.png';
    }

    Color bg = Data.mail_white;
    if(this.is_bg_white == false)
    {
      bg = Data.mail_grey;
    }
    return Container(
  width: 390,
  height: 41,
  decoration: BoxDecoration(
    color: bg,
    border: Border.all(
      color: bg,
    ),
  ),
  child: Row(
    mainAxisSize: MainAxisSize.max,
    children: [
      Expanded(
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
          child: Container(
            width: 122,
            height: 21,
            decoration: BoxDecoration(
              color:bg,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  width: 21,
                  height: 21,
                  decoration: BoxDecoration(
                    color: bg,
                  ),
                  child: Image.asset(
                    star_image,
                    width: 100,
                    height: 100,
                    fit: BoxFit.contain,
                  ),
                ),
                Expanded(
                  child: Container(
                    width: 98,
                    height: 20,
                      decoration: BoxDecoration(
                        color:bg,
                      ),
                    child: Text(
                      text,
                      style: FlutterFlowTheme.of(context).bodyText1.override(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      Align(
        alignment: AlignmentDirectional(0.8, 0),
        child: Container(
          width: 79,
          height: 20,
          decoration: BoxDecoration(
            color: bg,
          ),
          child: Text(
            date,
            style: FlutterFlowTheme.of(context).bodyText1.override(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.normal,
                ),
          ),
        ),
      ),
    ],
  ),
);

  }
}
