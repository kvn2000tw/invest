import 'package:flutter/material.dart';
import '../custom/custom_theme.dart';

class MemberList extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final showDate = 
      Align(
        alignment: AlignmentDirectional(0, 0),
        child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(169, 0, 0, 0),
          child: Container(
          width: 79,
          height: 20,
          decoration: BoxDecoration(
            color: FlutterFlowTheme.of(context)
              .secondaryBackground,
            ),
          child: Text(
            '2022-11-04',
              style:
              FlutterFlowTheme.of(context).bodyText1.override(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
        ),
      );
    final showContent = 
      Container(
        width: 98,
        height: 20,
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context)
            .secondaryBackground,
        ),
        child: Text(
          '文章標題在這邊',
          style: FlutterFlowTheme.of(context)
            .bodyText1
            .override(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500,
          ),
        ),
      );
    final showImage = 
      Container(
      width: 21,
      height: 21,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context)
                  .secondaryBackground,
      ),
      child: Image.asset(
        'assets/images/star.png',
        width: 100,
        height: 100,
        fit: BoxFit.contain,
      ),
    );

    final showTitle = 
      Padding(
        padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
        child: Container(
          width: 122,
          height: 21,
          decoration: BoxDecoration(
            color:
            FlutterFlowTheme.of(context).secondaryBackground,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              showImage,
              showContent,
            ],
          ),
        ),
      );

    return 
      Container(
        width: 390,
        height: 41,
        padding:EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).secondaryBackground,
                  //border: Border.all(color: Colors.blueAccent)
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            showTitle,
            showDate,
          ],
        ),
      );
  }
   
}
