import 'package:brotani/home/notification/notification.dart';
import 'package:brotani/shared/colors.dart';
import 'package:flutter/material.dart';

import '../../shared/flutter_flow_theme.dart';

class NotificationList extends StatelessWidget {
  final List<Notif> notifs;
  const NotificationList({
    Key? key,
    required this.notifs,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    print(notifs.length);
    if (notifs.length != 0) {
      return Padding(
        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 24),
        child: ListView.builder(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemBuilder: (BuildContext context, int index) {
            Notif notifItem = notifs[index];
            return InkWell(
              onTap: () {},
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(24, 12, 24, 0),
                child: Container(
                  width: double.infinity,
                  height: 70,
                  decoration: BoxDecoration(
                    color: greenBold,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    child: Stack(
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SelectionArea(
                                  child: FittedBox(
                                fit: BoxFit.contain,
                                child: Text(
                                  notifItem.name,
                                  style: FlutterFlowTheme.of(context)
                                      .title1
                                      .override(
                                        fontFamily: 'Poppins',
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                      ),
                                ),
                              )),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  SelectionArea(
                                      child: FittedBox(
                                    fit: BoxFit.contain,
                                    child: Text(
                                      notifItem.description,
                                      style: FlutterFlowTheme.of(context)
                                          .bodyText1
                                          .override(
                                              fontFamily: 'Poppins',
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryBtnText,
                                              fontWeight: FontWeight.normal,
                                              fontSize: 12),
                                    ),
                                  )),
                                ],
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
          },
          itemCount: notifs.length,
        ),
      );
    } else {
      return Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Opacity(
              opacity: 0.5,
              child: Image.asset(
                'assets/images/silence.png',
                height: 200,
              )),
          Text(
            'Belum Ada Notifikasi',
            overflow: TextOverflow.clip,
            maxLines: 3,
            style: FlutterFlowTheme.of(context).bodyText1.override(
                  fontFamily: 'Poppins',
                  color: Colors.grey,
                ),
          ),
        ],
      ));
    }
  }
}
