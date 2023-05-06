import 'package:brotani/home/land/detail/land_detail_page.dart';
import 'package:brotani/models/land/land.dart';
import 'package:brotani/services/land/land_services.dart';
import 'package:brotani/shared/api_url.dart';
import 'package:brotani/shared/colors.dart';
import 'package:flutter/material.dart';
import 'package:brotani/home/land/land.dart';
import '../../shared/flutter_flow_theme.dart';

class LandList extends StatefulWidget {
  final List<LandCoba> lands;
  const LandList({
    Key? key,
    required this.lands,
  }) : super(key: key);

  @override
  State<LandList> createState() => _LandListState();
}

class _LandListState extends State<LandList> {
  final _landService = LandService();

  @override
  Widget build(BuildContext context) {
    var _myData = _landService.getLandList();

    var futureBuilder = FutureBuilder(
      future: _myData,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return Center(
                child: CircularProgressIndicator(
              color: greenBold,
            ));
          default:
            if (snapshot.hasError) {
              return Scaffold(
                body: RefreshIndicator(
                  onRefresh: () => _myData = _landService.getLandList(),
                  child: Center(
                    child: Column(
                      children: [
                        Icon(Icons.error),
                        Text('Failed to fetch data.'),
                      ],
                    ),
                  ),
                ),
              );
            } else {
              if (snapshot.data.length != 0) {
                return ListView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (BuildContext context, int index) {
                    var landItem = widget.lands[0];
                    LandItem landItemApi = snapshot.data[index];
                    return InkWell(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return LandDetail(
                            landItem: landItem,
                            land: landItemApi,
                          );
                        }));
                      },
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(24, 12, 24, 12),
                        child: Container(
                          width: double.infinity,
                          height: 350,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                          ),
                          child: Container(
                            width: 100,
                            height: MediaQuery.of(context).size.height * 1,
                            child: Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(16),
                                  child: Image.network(
                                    baseUrl +
                                        snapshot.data?[index].imgGreenhouse,
                                    fit: BoxFit.fill,
                                    width: MediaQuery.of(context).size.width,
                                    height: MediaQuery.of(context).size.height,
                                    loadingBuilder: (BuildContext context,
                                        Widget child,
                                        ImageChunkEvent? loadingProgress) {
                                      if (loadingProgress == null) return child;
                                      return Center(
                                        child: CircularProgressIndicator(
                                          color: greenBold,
                                          value: loadingProgress
                                                      .expectedTotalBytes !=
                                                  null
                                              ? loadingProgress
                                                      .cumulativeBytesLoaded /
                                                  loadingProgress
                                                      .expectedTotalBytes!
                                              : null,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                ClipRRect(
                                    borderRadius: BorderRadius.circular(16),
                                    child: Container(
                                      color: Colors.black.withOpacity(0.1),
                                    )),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      16, 16, 16, 16),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SelectionArea(
                                          child: Text(
                                        landItemApi.nameGreenhouse,
                                        style: FlutterFlowTheme.of(context)
                                            .title1
                                            .override(
                                              fontFamily: 'Poppins',
                                              color: Colors.white,
                                            ),
                                      )),
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0, 0, 8, 0),
                                            child: Icon(
                                              Icons.location_on,
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryBtnText,
                                              size: 24,
                                            ),
                                          ),
                                          SelectionArea(
                                              child: Text(
                                            landItemApi.addressGreenhouse,
                                            style: FlutterFlowTheme.of(context)
                                                .bodyText1
                                                .override(
                                                  fontFamily: 'Poppins',
                                                  color: Colors.white,
                                                ),
                                          )),
                                        ],
                                      ),
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0, 0, 6, 0),
                                            child: Icon(
                                              Icons.landscape_rounded,
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryBtnText,
                                              size: 24,
                                            ),
                                          ),
                                          SelectionArea(
                                              child: Text(
                                            '${landItemApi.luas} m²',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyText1
                                                .override(
                                                  fontFamily: 'Poppins',
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primaryBtnText,
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
                  itemCount: snapshot.data?.length,
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
                          'assets/images/no_data_img.png',
                          height: 200,
                        )),
                    Text(
                      'Belum Ada Greenhouse yang Terdaftar',
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
      },
    );

    return Scaffold(
        body: RefreshIndicator(
            onRefresh: () {
              setState(() {
                _myData = _landService.getLandList();
              });
              return Future<void>.delayed(const Duration(seconds: 2));
            },
            child: futureBuilder));
  }
}
