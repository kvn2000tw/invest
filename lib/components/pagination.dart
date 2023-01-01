import 'package:flutter/material.dart';
import '../custom/custom_theme.dart';
import '../data.dart';

class Pagination extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return  Align(
  alignment: AlignmentDirectional(0, 0),
  child: Container(
    //width: 390,
    height: 80,
    decoration: BoxDecoration(
      color: FlutterFlowTheme.of(context).secondaryBackground,
    ),
    child: Align(
      alignment: AlignmentDirectional(0, 0),
      child: Container(
        width: 159,
        height: 80,
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).secondaryBackground,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              width: 40,
              height: 38,
              decoration: BoxDecoration(
                color: Data.blue,
              ),
              child: Align(
                alignment: AlignmentDirectional(0, 0),
                child: Text(
                  '1',
                  textAlign: TextAlign.center,
                  style: FlutterFlowTheme.of(context).bodyText1.override(
                        fontFamily: 'Poppins',
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.normal,
                      ),
                ),
              ),
            ),
            Container(
              width: 40,
              height: 38,
              decoration: BoxDecoration(
                color: Data.mail_white,
              ),
              child: Align(
                alignment: AlignmentDirectional(0, 0),
                child: Text(
                  '2',
                  textAlign: TextAlign.center,
                  style: FlutterFlowTheme.of(context).bodyText1.override(
                        fontFamily: 'Poppins',
                        color: Colors.blue,
                        fontSize: 13,
                        fontWeight: FontWeight.normal,
                      ),
                ),
              ),
            ),
            Container(
              width: 79,
              height: 40,
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).secondaryBackground,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    '下一頁',
                    style: FlutterFlowTheme.of(context).bodyText1.override(
                          fontFamily: 'Poppins',
                          color: FlutterFlowTheme.of(context).primaryColor,
                          fontSize: 13,
                          fontWeight: FontWeight.normal,
                        ),
                  ),
                  Image.asset(
                    'assets/images/chevron_right.png',
                    width: 20,
                    height: 20,
                    fit: BoxFit.contain,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  ),
);
  }
}