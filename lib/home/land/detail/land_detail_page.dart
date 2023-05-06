import 'dart:async';

import 'package:brotani/home/land/land.dart';
import 'package:brotani/models/indicator/indicator_model.dart';
import 'package:brotani/services/aktuator/aktuator_services.dart';
import 'package:brotani/services/indicator/indicator_services.dart';
import 'package:brotani/shared/colors.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../models/land/land.dart';
import '../../../shared/api_url.dart';
import '../../../shared/flutter_flow_theme.dart';

class LandDetail extends StatefulWidget {
  final LandCoba landItem;
  final LandItem land;
  const LandDetail({Key? key, required this.landItem, required this.land})
      : super(key: key);

  @override
  _LandDetailState createState() => _LandDetailState();
}

class _LandDetailState extends State<LandDetail> {
  final _indicatorServices = IndicatorServices();
  final _aktuatorService = AktuatorServices();
  int _current = 0;
  final CarouselController _controller = CarouselController();
  PageController? pageViewController;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  String _addedDate(String dateInput, int daysAdded) {
    final DateTime date = DateTime.parse(dateInput);
    final DateTime addedDate = date.add(Duration(days: daysAdded));
    final DateFormat formatter = DateFormat('MMM d, yyyy');
    final String formatted = formatter.format(addedDate);
    return formatted;
  }

  @override
  Widget build(BuildContext context) {
    // const _controller = StaticMapController(
    //   googleApiKey: "AIzaSyB96v1wnMBoXdu_xkhmNtP65R9i5bY4Sak",
    //   width: 400,
    //   height: 400,
    //   zoom: 10,
    //   center: Location(-3.1178833, -60.0029284),
    // );
    final fabKey = GlobalObjectKey<ExpandableFabState>(context);
    int addedDays = 0;
    double unitWeight = 0;
    switch (widget.land.komoditas) {
      case "Melon":
        {
          unitWeight = 4;
          addedDays = 70;
        }
        break;
      case "Semangka":
        {
          unitWeight = 5;
          addedDays = 80;
        }
        break;
      case "Terong":
        {
          unitWeight = 0.25;
          addedDays = 90;
        }
        break;
      case "Anggur":
        {
          unitWeight = 1;
          addedDays = 100;
        }
        break;
      case "Cabai Merah":
        {
          unitWeight = 1;
          addedDays = 90;
        }
        break;
    }
    double bibit = double.parse(widget.land.bibit);

    var _myData = _indicatorServices.getIndicatorList();

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
                  onRefresh: () =>
                      _myData = _indicatorServices.getIndicatorList(),
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
                IndicatorItem _indicator =
                    snapshot.data[snapshot.data.length - 1];

                //cahaya
                double cahaya;
                if (_indicator.cahaya == "") {
                  cahaya = 0.0;
                } else {
                  cahaya = double.parse(_indicator.cahaya);
                }
                double _reqCahaya = 3000;

                //kelembaban Udara
                double kUdara;
                if (_indicator.kelembapanUdara == "") {
                  kUdara = 0.0;
                } else {
                  kUdara = double.parse(_indicator.kelembapanUdara);
                }
                double _reqKUdara = 60.0;

                //kelembaban Tanah
                double kTanah;
                if (_indicator.kelembapanTanah == "") {
                  kTanah = 0.0;
                } else {
                  kTanah = double.parse(_indicator.kelembapanTanah);
                }
                double _reqKTanah = 60.0;

                //suhu udara
                double sUdara;
                if (_indicator.suhuUdara == "") {
                  sUdara = 0.0;
                } else {
                  sUdara = double.parse(_indicator.suhuUdara);
                }

                double _reqSuhu = 30;
                double _reqSuhu2 = 18;

                //pH
                double pH;
                if (_indicator.ph == "") {
                  pH = 0.0;
                } else {
                  pH = double.parse(_indicator.ph);
                }

                double _reqPh = 0;
                return Scaffold(
                  key: scaffoldKey,
                  body: SafeArea(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Stack(children: [
                            Container(
                              width: double.infinity,
                              height: 400,
                              child: Stack(
                                children: [
                                  PageView.builder(
                                    controller: pageViewController ??=
                                        PageController(initialPage: 0),
                                    scrollDirection: Axis.horizontal,
                                    itemCount: 1,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Image.network(
                                        baseUrl + widget.land.imgGreenhouse,
                                        width: 100,
                                        height: 100,
                                        fit: BoxFit.cover,
                                      );
                                    },
                                  ),
                                  Align(
                                    alignment: AlignmentDirectional(0, 1),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 0, 0, 20),
                                      child: SmoothPageIndicator(
                                        controller: pageViewController ??=
                                            PageController(initialPage: 0),
                                        count: 1,
                                        axisDirection: Axis.horizontal,
                                        onDotClicked: (i) {
                                          pageViewController!.animateToPage(
                                            i,
                                            duration:
                                                Duration(milliseconds: 500),
                                            curve: Curves.ease,
                                          );
                                        },
                                        effect: ExpandingDotsEffect(
                                          expansionFactor: 2,
                                          spacing: 8,
                                          radius: 16,
                                          dotWidth: 16,
                                          dotHeight: 16,
                                          dotColor: Colors.white,
                                          activeDotColor: greenBold,
                                          paintStyle: PaintingStyle.fill,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
                              child: InkWell(
                                child: Icon(
                                  Icons.chevron_left,
                                  color: Colors.black,
                                  size: 36,
                                ),
                                onTap: () => Navigator.pop(context),
                              ),
                            ),
                            Align(
                              alignment: AlignmentDirectional(1, 0),
                              child: Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
                                child: Icon(
                                  Icons.view_in_ar,
                                  color: Colors.black,
                                  size: 36,
                                ),
                              ),
                            ),
                          ]),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(16, 8, 16, 8),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SelectionArea(
                                    child: Text(
                                  widget.land.nameGreenhouse,
                                  style: FlutterFlowTheme.of(context)
                                      .title1
                                      .override(
                                        fontFamily: 'Poppins',
                                        color: FlutterFlowTheme.of(context)
                                            .primaryText,
                                      ),
                                )),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 0, 8, 0),
                                      child: Icon(
                                        Icons.location_on,
                                        color: Colors.black,
                                        size: 24,
                                      ),
                                    ),
                                    SelectionArea(
                                        child: Text(
                                      widget.land.addressGreenhouse,
                                      style: FlutterFlowTheme.of(context)
                                          .bodyText1
                                          .override(
                                            fontFamily: 'Poppins',
                                            color: Colors.black,
                                          ),
                                    )),
                                  ],
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0, 0, 6, 0),
                                          child: Icon(
                                            Icons.landscape_rounded,
                                            color: Colors.black,
                                            size: 24,
                                          ),
                                        ),
                                        SelectionArea(
                                            child: Text(
                                          '${widget.land.luas} m²',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyText1
                                              .override(
                                                fontFamily: 'Poppins',
                                                color: Colors.black,
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
                                          child: FaIcon(
                                            FontAwesomeIcons.pagelines,
                                            color: Colors.black,
                                            size: 24,
                                          ),
                                        ),
                                        SelectionArea(
                                            child: Text(
                                          widget.land.komoditas,
                                          style: FlutterFlowTheme.of(context)
                                              .bodyText1
                                              .override(
                                                fontFamily: 'Poppins',
                                                color: Colors.black,
                                              ),
                                        )),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Divider(
                            thickness: 1,
                            indent: 16,
                            endIndent: 16,
                            color: Colors.black,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8, bottom: 8),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        16, 0, 0, 0),
                                    child: Container(
                                      width: 120,
                                      height: 80,
                                      child: Stack(
                                        children: [
                                          Align(
                                            alignment:
                                                AlignmentDirectional(0, 0),
                                            child: Container(
                                              width: double.infinity,
                                              height: double.infinity,
                                              decoration: BoxDecoration(
                                                color: cahaya <= _reqCahaya
                                                    ? Colors.red
                                                    : greenBold,
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                                shape: BoxShape.rectangle,
                                              ),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  SelectionArea(
                                                      child: FittedBox(
                                                    fit: BoxFit.contain,
                                                    child: Text(
                                                      "$cahaya lux",
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .title1
                                                          .override(
                                                            fontFamily:
                                                                'Poppins',
                                                            color: Colors.white,
                                                          ),
                                                    ),
                                                  )),
                                                  SelectionArea(
                                                      child: Text(
                                                    'Cahaya',
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyText1
                                                        .override(
                                                          fontFamily: 'Poppins',
                                                          color: Colors.white,
                                                        ),
                                                  )),
                                                ],
                                              ),
                                            ),
                                          ),
                                          cahaya <= _reqCahaya
                                              ? Positioned(
                                                  right: 0,
                                                  child: Icon(
                                                    Icons.brightness_1,
                                                    color: Colors.orange,
                                                  ))
                                              : Text(""),
                                          InkWell(
                                            onTap: () {
                                              if (cahaya <= _reqCahaya) {
                                                showDialog<String>(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) =>
                                                          AlertDialog(
                                                    title: const Text(
                                                        'Tambahkan Intensitas Cahaya?'),
                                                    content: const Text(
                                                        "Tanaman memerlukan tambahan cahaya (rekomendasi: 3000 lux)"),
                                                    actions: <Widget>[
                                                      TextButton(
                                                        onPressed: () =>
                                                            Navigator.pop(
                                                                context,
                                                                'Tidak'),
                                                        child: const Text(
                                                          'Tidak',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.grey),
                                                        ),
                                                      ),
                                                      TextButton(
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context, 'Ya');
                                                        },
                                                        child: const Text(
                                                          'Ya',
                                                          style: TextStyle(
                                                              color: greenBold),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              }
                                            },
                                            child: Container(
                                              height: 80,
                                              width: 120,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        8, 0, 0, 0),
                                    child: Container(
                                      width: 120,
                                      height: 80,
                                      child: Stack(
                                        children: [
                                          Align(
                                            alignment:
                                                AlignmentDirectional(0, 0),
                                            child: Container(
                                              width: double.infinity,
                                              height: double.infinity,
                                              decoration: BoxDecoration(
                                                color: kTanah <= _reqKTanah
                                                    ? Colors.red
                                                    : greenBold,
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                                shape: BoxShape.rectangle,
                                              ),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  SelectionArea(
                                                      child: FittedBox(
                                                    fit: BoxFit.contain,
                                                    child: Text(
                                                      "$kTanah%",
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .title1
                                                          .override(
                                                            fontFamily:
                                                                'Poppins',
                                                            color: Colors.white,
                                                          ),
                                                    ),
                                                  )),
                                                  SelectionArea(
                                                      child: Text(
                                                    'K. Tanah',
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyText1
                                                        .override(
                                                          fontFamily: 'Poppins',
                                                          color: Colors.white,
                                                        ),
                                                  )),
                                                ],
                                              ),
                                            ),
                                          ),
                                          kTanah <= _reqKTanah
                                              ? Positioned(
                                                  right: 0,
                                                  child: Icon(
                                                    Icons.brightness_1,
                                                    color: Colors.orange,
                                                  ))
                                              : Text(""),
                                          InkWell(
                                            onTap: () {
                                              if (kTanah <= _reqKTanah) {
                                                showDialog<String>(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) =>
                                                          AlertDialog(
                                                    title: const Text(
                                                        'Tambahkan kelembaban tanah?'),
                                                    content: const Text(
                                                        "Tanaman memerlukan tambahan kelembaban tanah (rekomendasi: 60%)"),
                                                    actions: <Widget>[
                                                      TextButton(
                                                        onPressed: () =>
                                                            Navigator.pop(
                                                                context,
                                                                'Tidak'),
                                                        child: const Text(
                                                          'Tidak',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.grey),
                                                        ),
                                                      ),
                                                      TextButton(
                                                        onPressed: () async {
                                                          bool
                                                              aktuatorOnKTanah =
                                                              await _aktuatorService
                                                                  .onAktuatorKelembabanTanah();

                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .showSnackBar(
                                                            SnackBar(
                                                              duration:
                                                                  Duration(
                                                                      seconds:
                                                                          3),
                                                              content: Text(
                                                                  'Aktuator berhasil dihidupkan (60s)'),
                                                            ),
                                                          );

                                                          Navigator.pop(
                                                              context, 'Ya');
                                                          Timer(
                                                              Duration(
                                                                  seconds: 7),
                                                              () async {
                                                            await _aktuatorService
                                                                .offAktuatorKelembabanTanah();
                                                          });
                                                        },
                                                        child: const Text(
                                                          'Ya',
                                                          style: TextStyle(
                                                              color: greenBold),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              }
                                            },
                                            child: Container(
                                              height: 80,
                                              width: 120,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        8, 0, 0, 0),
                                    child: Container(
                                      width: 120,
                                      height: 80,
                                      child: Stack(
                                        children: [
                                          Align(
                                            alignment:
                                                AlignmentDirectional(0, 0),
                                            child: Container(
                                              width: double.infinity,
                                              height: double.infinity,
                                              decoration: BoxDecoration(
                                                color: kUdara <= _reqKUdara
                                                    ? Colors.red
                                                    : greenBold,
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                                shape: BoxShape.rectangle,
                                              ),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  SelectionArea(
                                                      child: Text(
                                                    "${kUdara}%",
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .title1
                                                        .override(
                                                          fontFamily: 'Poppins',
                                                          color: Colors.white,
                                                        ),
                                                  )),
                                                  SelectionArea(
                                                      child: Text(
                                                    'K. Udara',
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyText1
                                                        .override(
                                                          fontFamily: 'Poppins',
                                                          color: Colors.white,
                                                        ),
                                                  )),
                                                ],
                                              ),
                                            ),
                                          ),
                                          kUdara <= _reqKUdara
                                              ? Positioned(
                                                  right: 0,
                                                  child: Icon(
                                                    Icons.brightness_1,
                                                    color: Colors.orange,
                                                  ))
                                              : Text(""),
                                          InkWell(
                                            onTap: () {
                                              if (kUdara <= _reqKUdara) {
                                                showDialog<String>(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) =>
                                                          AlertDialog(
                                                    title: const Text(
                                                        'Tambahkan Kelembaban Udara?'),
                                                    content: const Text(
                                                        "Tanaman memerlukan tambahan kelembaban udara (rekomendasi: 60%)"),
                                                    actions: <Widget>[
                                                      TextButton(
                                                        onPressed: () =>
                                                            Navigator.pop(
                                                                context,
                                                                'Tidak'),
                                                        child: const Text(
                                                          'Tidak',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.grey),
                                                        ),
                                                      ),
                                                      TextButton(
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context, 'Ya');
                                                        },
                                                        child: const Text(
                                                          'Ya',
                                                          style: TextStyle(
                                                              color: greenBold),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              }
                                            },
                                            child: Container(
                                              height: 80,
                                              width: 120,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        8, 0, 8, 0),
                                    child: Container(
                                      width: 120,
                                      height: 80,
                                      child: Stack(
                                        children: [
                                          Align(
                                            alignment:
                                                AlignmentDirectional(0, 0),
                                            child: Container(
                                              width: double.infinity,
                                              height: double.infinity,
                                              decoration: BoxDecoration(
                                                color: sUdara >= _reqSuhu
                                                    ? Colors.red
                                                    : greenBold,
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                                shape: BoxShape.rectangle,
                                              ),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  SelectionArea(
                                                      child: Text(
                                                    "$sUdara°C",
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .title1
                                                        .override(
                                                          fontFamily: 'Poppins',
                                                          color: Colors.white,
                                                        ),
                                                  )),
                                                  SelectionArea(
                                                      child: Text(
                                                    'Suhu Udara',
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyText1
                                                        .override(
                                                          fontFamily: 'Poppins',
                                                          color: Colors.white,
                                                        ),
                                                  )),
                                                ],
                                              ),
                                            ),
                                          ),
                                          sUdara >= _reqSuhu
                                              ? Positioned(
                                                  right: 0,
                                                  child: Icon(
                                                    Icons.brightness_1,
                                                    color: Colors.orange,
                                                  ))
                                              : Text(""),
                                          InkWell(
                                            onTap: () {
                                              if (sUdara >= _reqSuhu) {
                                                showDialog<String>(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) =>
                                                          AlertDialog(
                                                    title: const Text(
                                                        'Atur Suhu Udara?'),
                                                    content: const Text(
                                                        "Tanaman memerlukan suhu udara yang optimal (18-30°C)"),
                                                    actions: <Widget>[
                                                      TextButton(
                                                        onPressed: () =>
                                                            Navigator.pop(
                                                                context,
                                                                'Tidak'),
                                                        child: const Text(
                                                          'Tidak',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.grey),
                                                        ),
                                                      ),
                                                      TextButton(
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context, 'Ya');
                                                        },
                                                        child: const Text(
                                                          'Ya',
                                                          style: TextStyle(
                                                              color: greenBold),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              }
                                            },
                                            child: Container(
                                              height: 80,
                                              width: 120,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Divider(
                            thickness: 1,
                            indent: 16,
                            endIndent: 16,
                            color: Colors.black,
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(16, 16, 16, 16),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SelectionArea(
                                    child: Text(
                                  'Lokasi',
                                  style: FlutterFlowTheme.of(context)
                                      .title1
                                      .override(
                                        fontFamily: 'Poppins',
                                        color: FlutterFlowTheme.of(context)
                                            .primaryText,
                                      ),
                                )),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      16, 16, 16, 16),
                                  child: InkWell(
                                    onTap: () {
                                      showDialog<String>(
                                        context: context,
                                        builder: (BuildContext context) =>
                                            AlertDialog(
                                          title: const Text('Buka di Maps?'),
                                          actions: <Widget>[
                                            TextButton(
                                              onPressed: () => Navigator.pop(
                                                  context, 'Tidak'),
                                              child: const Text(
                                                'Tidak',
                                                style: TextStyle(
                                                    color: Colors.grey),
                                              ),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                MapUtils.openMap(
                                                    widget.land.lat,
                                                    widget.land.long);
                                                Navigator.pop(context, 'Ya');
                                              },
                                              child: const Text(
                                                'Ya',
                                                style:
                                                    TextStyle(color: greenBold),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                    child: Container(
                                      width: double.infinity,
                                      height: 200,
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryBackground,
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(30),
                                        child: Image.network(
                                          'https://maps.geoapify.com/v1/staticmap?style=osm-bright-smooth&width=250&height=150&center=lonlat:${widget.land.long},${widget.land.lat}&zoom=14.0702&marker=lonlat:${widget.land.long},${widget.land.lat};color:%23ff0000;size:medium&apiKey=9da6877d11d748609165155c91cdb207',
                                          width: 100,
                                          height: 100,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Divider(
                                  thickness: 1,
                                  color: Colors.black,
                                ),
                                SelectionArea(
                                    child: Text(
                                  'Detail Masa Tanam',
                                  style: FlutterFlowTheme.of(context)
                                      .title1
                                      .override(
                                        fontFamily: 'Poppins',
                                        color: FlutterFlowTheme.of(context)
                                            .primaryText,
                                      ),
                                )),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 8, 0, 8),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Container(
                                        width: 150,
                                        height: 60,
                                        child: Stack(
                                          children: [
                                            Align(
                                              alignment:
                                                  AlignmentDirectional(0, 0),
                                              child: Container(
                                                width: double.infinity,
                                                height: double.infinity,
                                                decoration: BoxDecoration(
                                                  color: Color(0xFF00C013),
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                  shape: BoxShape.rectangle,
                                                ),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    SelectionArea(
                                                        child: Text(
                                                      _addedDate(
                                                          widget.land.createdAt
                                                              .toString(),
                                                          0),
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .title1
                                                          .override(
                                                            fontFamily:
                                                                'Poppins',
                                                            color: Colors.white,
                                                            fontSize: 16,
                                                          ),
                                                    )),
                                                    SelectionArea(
                                                        child: Text(
                                                      'Tanggal Tanam',
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .bodyText1
                                                          .override(
                                                            fontFamily:
                                                                'Poppins',
                                                            color: Colors.white,
                                                            fontSize: 12,
                                                          ),
                                                    )),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width: 150,
                                        height: 60,
                                        child: Stack(
                                          children: [
                                            Align(
                                              alignment:
                                                  AlignmentDirectional(0, 0),
                                              child: Container(
                                                width: double.infinity,
                                                height: double.infinity,
                                                decoration: BoxDecoration(
                                                  color: Color(0xFF00C013),
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                  shape: BoxShape.rectangle,
                                                ),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    SelectionArea(
                                                        child: Text(
                                                      _addedDate(
                                                          widget.land.createdAt
                                                              .toString(),
                                                          addedDays),
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .title1
                                                          .override(
                                                            fontFamily:
                                                                'Poppins',
                                                            color: Colors.white,
                                                            fontSize: 16,
                                                          ),
                                                    )),
                                                    SelectionArea(
                                                        child: Text(
                                                      'Estimasi Panen',
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .bodyText1
                                                          .override(
                                                            fontFamily:
                                                                'Poppins',
                                                            color: Colors.white,
                                                            fontSize: 12,
                                                          ),
                                                    )),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Align(
                                  alignment: AlignmentDirectional(0, 0),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 8, 0, 16),
                                    child: Container(
                                      width: 150,
                                      height: 60,
                                      child: Stack(
                                        children: [
                                          Align(
                                            alignment:
                                                AlignmentDirectional(0, 0),
                                            child: Container(
                                              width: double.infinity,
                                              height: double.infinity,
                                              decoration: BoxDecoration(
                                                color: Color(0xFF00C013),
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                                shape: BoxShape.rectangle,
                                              ),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  SelectionArea(
                                                      child: Text(
                                                    '${addedDays} Hari',
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .title1
                                                        .override(
                                                          fontFamily: 'Poppins',
                                                          color: Colors.white,
                                                          fontSize: 16,
                                                        ),
                                                  )),
                                                  SelectionArea(
                                                      child: Text(
                                                    'Menuju Panen',
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyText1
                                                        .override(
                                                          fontFamily: 'Poppins',
                                                          color: Colors.white,
                                                          fontSize: 12,
                                                        ),
                                                  )),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Divider(
                                  thickness: 1,
                                  color: Colors.black,
                                ),
                                SelectionArea(
                                    child: Text(
                                  'Estimasi Hasil Panen',
                                  style: FlutterFlowTheme.of(context)
                                      .title1
                                      .override(
                                        fontFamily: 'Poppins',
                                        color: FlutterFlowTheme.of(context)
                                            .primaryText,
                                      ),
                                )),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 8, 0, 8),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Container(
                                        width: 150,
                                        height: 60,
                                        child: Stack(
                                          children: [
                                            Align(
                                              alignment:
                                                  AlignmentDirectional(0, 0),
                                              child: Container(
                                                width: double.infinity,
                                                height: double.infinity,
                                                decoration: BoxDecoration(
                                                  color: Color(0xFF00C013),
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                  shape: BoxShape.rectangle,
                                                ),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    SelectionArea(
                                                        child: Text(
                                                      '$unitWeight Kg',
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .title1
                                                          .override(
                                                            fontFamily:
                                                                'Poppins',
                                                            color: Colors.white,
                                                            fontSize: 16,
                                                          ),
                                                    )),
                                                    SelectionArea(
                                                        child: Text(
                                                      'Berat Satuan',
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .bodyText1
                                                          .override(
                                                            fontFamily:
                                                                'Poppins',
                                                            color: Colors.white,
                                                            fontSize: 12,
                                                          ),
                                                    )),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width: 150,
                                        height: 60,
                                        child: Stack(
                                          children: [
                                            Align(
                                              alignment:
                                                  AlignmentDirectional(0, 0),
                                              child: Container(
                                                width: double.infinity,
                                                height: double.infinity,
                                                decoration: BoxDecoration(
                                                  color: Color(0xFF00C013),
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                  shape: BoxShape.rectangle,
                                                ),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    SelectionArea(
                                                        child: Text(
                                                      bibit.toString(),
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .title1
                                                          .override(
                                                            fontFamily:
                                                                'Poppins',
                                                            color: Colors.white,
                                                            fontSize: 16,
                                                          ),
                                                    )),
                                                    SelectionArea(
                                                        child: Text(
                                                      'Jumlah Satuan',
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .bodyText1
                                                          .override(
                                                            fontFamily:
                                                                'Poppins',
                                                            color: Colors.white,
                                                            fontSize: 12,
                                                          ),
                                                    )),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Align(
                                  alignment: AlignmentDirectional(0, 0),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 8, 0, 16),
                                    child: Container(
                                      width: 150,
                                      height: 60,
                                      child: Stack(
                                        children: [
                                          Align(
                                            alignment:
                                                AlignmentDirectional(0, 0),
                                            child: Container(
                                              width: double.infinity,
                                              height: double.infinity,
                                              decoration: BoxDecoration(
                                                color: Color(0xFF00C013),
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                                shape: BoxShape.rectangle,
                                              ),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  SelectionArea(
                                                      child: Text(
                                                    '${unitWeight * bibit} Kg',
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .title1
                                                        .override(
                                                          fontFamily: 'Poppins',
                                                          color: Colors.white,
                                                          fontSize: 16,
                                                        ),
                                                  )),
                                                  SelectionArea(
                                                      child: Text(
                                                    'Berat Total',
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyText1
                                                        .override(
                                                          fontFamily: 'Poppins',
                                                          color: Colors.white,
                                                          fontSize: 12,
                                                        ),
                                                  )),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  floatingActionButtonLocation: ExpandableFab.location,
                  floatingActionButton: ExpandableFab(
                    key: fabKey,
                    // duration: const Duration(seconds: 1),
                    // type: ExpandableFabType.up,
                    // fanAngle: 70,
                    // child: const Icon(Icons.account_box),
                    // foregroundColor: Colors.amber,
                    backgroundColor: Colors.green,
                    child: Icon(
                      FontAwesomeIcons.leaf,
                      color: Colors.white,
                    ),
                    //   foregroundColor: Colors.deepOrangeAccent,
                    //   backgroundColor: Colors.lightGreen,
                    // ),
                    overlayStyle: ExpandableFabOverlayStyle(
                      // color: Colors.black.withOpacity(0.5),
                      blur: 5,
                    ),
                    onOpen: () {
                      debugPrint('onOpen');
                    },
                    afterOpen: () {
                      debugPrint('afterOpen');
                    },
                    onClose: () {
                      debugPrint('onClose');
                    },
                    afterClose: () {
                      debugPrint('afterClose');
                    },
                    children: [
                      FloatingActionButton(
                        heroTag: null,
                        backgroundColor: Colors.lightBlue,
                        child: const Icon(FontAwesomeIcons.droplet),
                        onPressed: () {},
                      ),
                      FloatingActionButton(
                        heroTag: null,
                        backgroundColor: Colors.lightGreen,
                        child: SizedBox(
                            height: 24,
                            child: Image.asset('assets/icons/fertilizer.png')),
                        onPressed: () {},
                      ),
                      FloatingActionButton(
                        heroTag: null,
                        backgroundColor: Colors.orangeAccent,
                        child: SizedBox(
                            height: 30,
                            child: Image.asset('assets/icons/harvest.png')),
                        onPressed: () {
                          final state = fabKey.currentState;
                          if (state != null) {
                            debugPrint('isOpen:${state.isOpen}');
                            state.toggle();
                          }
                        },
                      ),
                    ],
                  ),
                );
              } else {
                // return Center(
                //     child: Column(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   crossAxisAlignment: CrossAxisAlignment.center,
                //   children: [
                //     Opacity(
                //         opacity: 0.5,
                //         child: Image.asset(
                //           'assets/images/no_data_img.png',
                //           height: 200,
                //         )),
                //     Text(
                //       'Belum Ada Greenhouse yang Terdaftar',
                //       overflow: TextOverflow.clip,
                //       maxLines: 3,
                //       style: FlutterFlowTheme.of(context).bodyText1.override(
                //             fontFamily: 'Poppins',
                //             color: Colors.grey,
                //           ),
                //     ),
                //   ],
                // ));
                double cahaya = 0;
                double _reqCahaya = 3000;
                double kUdara = 0;
                double _reqKUdara = 6.0;
                double kTanah = 0;
                double _reqKTanah = 6.0;
                double sUdara = 0;
                double _reqSuhu = 30;
                double _reqSuhu2 = 18;
                return Scaffold(
                  key: scaffoldKey,
                  body: SafeArea(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Stack(children: [
                            Container(
                              width: double.infinity,
                              height: 400,
                              child: Stack(
                                children: [
                                  PageView.builder(
                                    controller: pageViewController ??=
                                        PageController(initialPage: 0),
                                    scrollDirection: Axis.horizontal,
                                    itemCount: 1,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Image.network(
                                        baseUrl + widget.land.imgGreenhouse,
                                        width: 100,
                                        height: 100,
                                        fit: BoxFit.cover,
                                      );
                                    },
                                  ),
                                  Align(
                                    alignment: AlignmentDirectional(0, 1),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 0, 0, 20),
                                      child: SmoothPageIndicator(
                                        controller: pageViewController ??=
                                            PageController(initialPage: 0),
                                        count: 1,
                                        axisDirection: Axis.horizontal,
                                        onDotClicked: (i) {
                                          pageViewController!.animateToPage(
                                            i,
                                            duration:
                                                Duration(milliseconds: 500),
                                            curve: Curves.ease,
                                          );
                                        },
                                        effect: ExpandingDotsEffect(
                                          expansionFactor: 2,
                                          spacing: 8,
                                          radius: 16,
                                          dotWidth: 16,
                                          dotHeight: 16,
                                          dotColor: Colors.white,
                                          activeDotColor: greenBold,
                                          paintStyle: PaintingStyle.fill,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
                              child: InkWell(
                                child: Icon(
                                  Icons.chevron_left,
                                  color: Colors.black,
                                  size: 36,
                                ),
                                onTap: () => Navigator.pop(context),
                              ),
                            ),
                            Align(
                              alignment: AlignmentDirectional(1, 0),
                              child: Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
                                child: Icon(
                                  Icons.view_in_ar,
                                  color: Colors.black,
                                  size: 36,
                                ),
                              ),
                            ),
                          ]),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(16, 8, 16, 8),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SelectionArea(
                                    child: Text(
                                  widget.land.nameGreenhouse,
                                  style: FlutterFlowTheme.of(context)
                                      .title1
                                      .override(
                                        fontFamily: 'Poppins',
                                        color: FlutterFlowTheme.of(context)
                                            .primaryText,
                                      ),
                                )),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 0, 8, 0),
                                      child: Icon(
                                        Icons.location_on,
                                        color: Colors.black,
                                        size: 24,
                                      ),
                                    ),
                                    SelectionArea(
                                        child: Text(
                                      widget.land.addressGreenhouse,
                                      style: FlutterFlowTheme.of(context)
                                          .bodyText1
                                          .override(
                                            fontFamily: 'Poppins',
                                            color: Colors.black,
                                          ),
                                    )),
                                  ],
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0, 0, 6, 0),
                                          child: Icon(
                                            Icons.landscape_rounded,
                                            color: Colors.black,
                                            size: 24,
                                          ),
                                        ),
                                        SelectionArea(
                                            child: Text(
                                          '${widget.land.luas} m²',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyText1
                                              .override(
                                                fontFamily: 'Poppins',
                                                color: Colors.black,
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
                                          child: FaIcon(
                                            FontAwesomeIcons.pagelines,
                                            color: Colors.black,
                                            size: 24,
                                          ),
                                        ),
                                        SelectionArea(
                                            child: Text(
                                          widget.land.komoditas,
                                          style: FlutterFlowTheme.of(context)
                                              .bodyText1
                                              .override(
                                                fontFamily: 'Poppins',
                                                color: Colors.black,
                                              ),
                                        )),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Divider(
                            thickness: 1,
                            indent: 16,
                            endIndent: 16,
                            color: Colors.black,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8, bottom: 8),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        16, 0, 0, 0),
                                    child: Container(
                                      width: 120,
                                      height: 80,
                                      child: Stack(
                                        children: [
                                          Align(
                                            alignment:
                                                AlignmentDirectional(0, 0),
                                            child: Container(
                                              width: double.infinity,
                                              height: double.infinity,
                                              decoration: BoxDecoration(
                                                color: cahaya <= _reqCahaya
                                                    ? Colors.red
                                                    : greenBold,
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                                shape: BoxShape.rectangle,
                                              ),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  SelectionArea(
                                                      child: Text(
                                                    "$cahaya lux",
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .title1
                                                        .override(
                                                          fontFamily: 'Poppins',
                                                          color: Colors.white,
                                                        ),
                                                  )),
                                                  SelectionArea(
                                                      child: Text(
                                                    'Cahaya',
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyText1
                                                        .override(
                                                          fontFamily: 'Poppins',
                                                          color: Colors.white,
                                                        ),
                                                  )),
                                                ],
                                              ),
                                            ),
                                          ),
                                          cahaya <= _reqCahaya
                                              ? Positioned(
                                                  right: 0,
                                                  child: Icon(
                                                    Icons.brightness_1,
                                                    color: Colors.orange,
                                                  ))
                                              : Text(""),
                                          InkWell(
                                            onTap: () {
                                              if (cahaya <= _reqCahaya) {
                                                showDialog<String>(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) =>
                                                          AlertDialog(
                                                    title: const Text(
                                                        'Tambahkan Intensitas Cahaya?'),
                                                    content: const Text(
                                                        "Tanaman memerlukan tambahan cahaya (rekomendasi: 3000 lux)"),
                                                    actions: <Widget>[
                                                      TextButton(
                                                        onPressed: () =>
                                                            Navigator.pop(
                                                                context,
                                                                'Tidak'),
                                                        child: const Text(
                                                          'Tidak',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.grey),
                                                        ),
                                                      ),
                                                      TextButton(
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context, 'Ya');
                                                        },
                                                        child: const Text(
                                                          'Ya',
                                                          style: TextStyle(
                                                              color: greenBold),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              }
                                            },
                                            child: Container(
                                              height: 80,
                                              width: 120,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        8, 0, 0, 0),
                                    child: Container(
                                      width: 120,
                                      height: 80,
                                      child: Stack(
                                        children: [
                                          Align(
                                            alignment:
                                                AlignmentDirectional(0, 0),
                                            child: Container(
                                              width: double.infinity,
                                              height: double.infinity,
                                              decoration: BoxDecoration(
                                                color: kTanah <= _reqKTanah
                                                    ? Colors.red
                                                    : greenBold,
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                                shape: BoxShape.rectangle,
                                              ),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  SelectionArea(
                                                      child: FittedBox(
                                                    fit: BoxFit.contain,
                                                    child: Text(
                                                      "${kTanah}%",
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .title1
                                                          .override(
                                                            fontFamily:
                                                                'Poppins',
                                                            color: Colors.white,
                                                          ),
                                                    ),
                                                  )),
                                                  SelectionArea(
                                                      child: Text(
                                                    'K. Tanah',
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyText1
                                                        .override(
                                                          fontFamily: 'Poppins',
                                                          color: Colors.white,
                                                        ),
                                                  )),
                                                ],
                                              ),
                                            ),
                                          ),
                                          kTanah <= _reqKTanah
                                              ? Positioned(
                                                  right: 0,
                                                  child: Icon(
                                                    Icons.brightness_1,
                                                    color: Colors.orange,
                                                  ))
                                              : Text(""),
                                          InkWell(
                                            onTap: () {
                                              if (kTanah <= _reqKTanah) {
                                                showDialog<String>(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) =>
                                                          AlertDialog(
                                                    title: const Text(
                                                        'Tambahkan kelembaban tanah?'),
                                                    content: const Text(
                                                        "Tanaman memerlukan tambahan kelembaban tanah (rekomendasi: 60%)"),
                                                    actions: <Widget>[
                                                      TextButton(
                                                        onPressed: () =>
                                                            Navigator.pop(
                                                                context,
                                                                'Tidak'),
                                                        child: const Text(
                                                          'Tidak',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.grey),
                                                        ),
                                                      ),
                                                      TextButton(
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context, 'Ya');
                                                        },
                                                        child: const Text(
                                                          'Ya',
                                                          style: TextStyle(
                                                              color: greenBold),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              }
                                            },
                                            child: Container(
                                              height: 80,
                                              width: 120,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        8, 0, 0, 0),
                                    child: Container(
                                      width: 120,
                                      height: 80,
                                      child: Stack(
                                        children: [
                                          Align(
                                            alignment:
                                                AlignmentDirectional(0, 0),
                                            child: Container(
                                              width: double.infinity,
                                              height: double.infinity,
                                              decoration: BoxDecoration(
                                                color: kUdara <= _reqKUdara
                                                    ? Colors.red
                                                    : greenBold,
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                                shape: BoxShape.rectangle,
                                              ),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  SelectionArea(
                                                      child: FittedBox(
                                                    fit: BoxFit.contain,
                                                    child: Text(
                                                      "${kUdara}%",
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .title1
                                                          .override(
                                                            fontFamily:
                                                                'Poppins',
                                                            color: Colors.white,
                                                          ),
                                                    ),
                                                  )),
                                                  SelectionArea(
                                                      child: Text(
                                                    'K. Udara',
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyText1
                                                        .override(
                                                          fontFamily: 'Poppins',
                                                          color: Colors.white,
                                                        ),
                                                  )),
                                                ],
                                              ),
                                            ),
                                          ),
                                          kUdara <= _reqKUdara
                                              ? Positioned(
                                                  right: 0,
                                                  child: Icon(
                                                    Icons.brightness_1,
                                                    color: Colors.orange,
                                                  ))
                                              : Text(""),
                                          InkWell(
                                            onTap: () {
                                              if (kUdara <= _reqKUdara) {
                                                showDialog<String>(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) =>
                                                          AlertDialog(
                                                    title: const Text(
                                                        'Tambahkan Kelembaban Udara?'),
                                                    content: const Text(
                                                        "Tanaman memerlukan tambahan kelembaban udara (rekomendasi: 60%)"),
                                                    actions: <Widget>[
                                                      TextButton(
                                                        onPressed: () =>
                                                            Navigator.pop(
                                                                context,
                                                                'Tidak'),
                                                        child: const Text(
                                                          'Tidak',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.grey),
                                                        ),
                                                      ),
                                                      TextButton(
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context, 'Ya');
                                                        },
                                                        child: const Text(
                                                          'Ya',
                                                          style: TextStyle(
                                                              color: greenBold),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              }
                                            },
                                            child: Container(
                                              height: 80,
                                              width: 120,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        8, 0, 16, 0),
                                    child: Container(
                                      width: 120,
                                      height: 80,
                                      child: Stack(
                                        children: [
                                          Align(
                                            alignment:
                                                AlignmentDirectional(0, 0),
                                            child: Container(
                                              width: double.infinity,
                                              height: double.infinity,
                                              decoration: BoxDecoration(
                                                color: sUdara >= _reqSuhu ||
                                                        sUdara <= _reqSuhu2
                                                    ? Colors.red
                                                    : greenBold,
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                                shape: BoxShape.rectangle,
                                              ),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  SelectionArea(
                                                      child: Text(
                                                    "$sUdara°C",
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .title1
                                                        .override(
                                                          fontFamily: 'Poppins',
                                                          color: Colors.white,
                                                        ),
                                                  )),
                                                  SelectionArea(
                                                      child: Text(
                                                    'Suhu Udara',
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyText1
                                                        .override(
                                                          fontFamily: 'Poppins',
                                                          color: Colors.white,
                                                        ),
                                                  )),
                                                ],
                                              ),
                                            ),
                                          ),
                                          sUdara >= _reqSuhu ||
                                                  sUdara <= _reqSuhu2
                                              ? Positioned(
                                                  right: 0,
                                                  child: Icon(
                                                    Icons.brightness_1,
                                                    color: Colors.orange,
                                                  ))
                                              : Text(""),
                                          InkWell(
                                            onTap: () {
                                              if (sUdara >= _reqSuhu ||
                                                  sUdara <= _reqSuhu2) {
                                                showDialog<String>(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) =>
                                                          AlertDialog(
                                                    title: const Text(
                                                        'Atur Suhu Udara?'),
                                                    content: const Text(
                                                        "Tanaman memerlukan suhu udara yang optimal (18-30°C)"),
                                                    actions: <Widget>[
                                                      TextButton(
                                                        onPressed: () =>
                                                            Navigator.pop(
                                                                context,
                                                                'Tidak'),
                                                        child: const Text(
                                                          'Tidak',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.grey),
                                                        ),
                                                      ),
                                                      TextButton(
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context, 'Ya');
                                                        },
                                                        child: const Text(
                                                          'Ya',
                                                          style: TextStyle(
                                                              color: greenBold),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              }
                                            },
                                            child: Container(
                                              height: 80,
                                              width: 120,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Divider(
                            thickness: 1,
                            indent: 16,
                            endIndent: 16,
                            color: Colors.black,
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(16, 16, 16, 16),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SelectionArea(
                                    child: Text(
                                  'Lokasi',
                                  style: FlutterFlowTheme.of(context)
                                      .title1
                                      .override(
                                        fontFamily: 'Poppins',
                                        color: FlutterFlowTheme.of(context)
                                            .primaryText,
                                      ),
                                )),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      16, 16, 16, 16),
                                  child: InkWell(
                                    onTap: () {
                                      showDialog<String>(
                                        context: context,
                                        builder: (BuildContext context) =>
                                            AlertDialog(
                                          title: const Text('Buka di Maps?'),
                                          actions: <Widget>[
                                            TextButton(
                                              onPressed: () => Navigator.pop(
                                                  context, 'Tidak'),
                                              child: const Text(
                                                'Tidak',
                                                style: TextStyle(
                                                    color: Colors.grey),
                                              ),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                MapUtils.openMap(
                                                    widget.land.lat,
                                                    widget.land.long);
                                                Navigator.pop(context, 'Ya');
                                              },
                                              child: const Text(
                                                'Ya',
                                                style:
                                                    TextStyle(color: greenBold),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                    child: Container(
                                      width: double.infinity,
                                      height: 200,
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryBackground,
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(30),
                                        child: Image.network(
                                          'https://maps.geoapify.com/v1/staticmap?style=osm-bright-smooth&width=250&height=150&center=lonlat:${widget.land.long},${widget.land.lat}&zoom=14.0702&marker=lonlat:${widget.land.long},${widget.land.lat};color:%23ff0000;size:medium&apiKey=9da6877d11d748609165155c91cdb207',
                                          width: 100,
                                          height: 100,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Divider(
                                  thickness: 1,
                                  color: Colors.black,
                                ),
                                SelectionArea(
                                    child: Text(
                                  'Detail Masa Tanam',
                                  style: FlutterFlowTheme.of(context)
                                      .title1
                                      .override(
                                        fontFamily: 'Poppins',
                                        color: FlutterFlowTheme.of(context)
                                            .primaryText,
                                      ),
                                )),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 8, 0, 8),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Container(
                                        width: 150,
                                        height: 60,
                                        child: Stack(
                                          children: [
                                            Align(
                                              alignment:
                                                  AlignmentDirectional(0, 0),
                                              child: Container(
                                                width: double.infinity,
                                                height: double.infinity,
                                                decoration: BoxDecoration(
                                                  color: Color(0xFF00C013),
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                  shape: BoxShape.rectangle,
                                                ),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    SelectionArea(
                                                        child: Text(
                                                      _addedDate(
                                                          widget.land.createdAt
                                                              .toString(),
                                                          0),
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .title1
                                                          .override(
                                                            fontFamily:
                                                                'Poppins',
                                                            color: Colors.white,
                                                            fontSize: 16,
                                                          ),
                                                    )),
                                                    SelectionArea(
                                                        child: Text(
                                                      'Tanggal Tanam',
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .bodyText1
                                                          .override(
                                                            fontFamily:
                                                                'Poppins',
                                                            color: Colors.white,
                                                            fontSize: 12,
                                                          ),
                                                    )),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width: 150,
                                        height: 60,
                                        child: Stack(
                                          children: [
                                            Align(
                                              alignment:
                                                  AlignmentDirectional(0, 0),
                                              child: Container(
                                                width: double.infinity,
                                                height: double.infinity,
                                                decoration: BoxDecoration(
                                                  color: Color(0xFF00C013),
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                  shape: BoxShape.rectangle,
                                                ),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    SelectionArea(
                                                        child: Text(
                                                      _addedDate(
                                                          widget.land.createdAt
                                                              .toString(),
                                                          addedDays),
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .title1
                                                          .override(
                                                            fontFamily:
                                                                'Poppins',
                                                            color: Colors.white,
                                                            fontSize: 16,
                                                          ),
                                                    )),
                                                    SelectionArea(
                                                        child: Text(
                                                      'Estimasi Panen',
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .bodyText1
                                                          .override(
                                                            fontFamily:
                                                                'Poppins',
                                                            color: Colors.white,
                                                            fontSize: 12,
                                                          ),
                                                    )),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Align(
                                  alignment: AlignmentDirectional(0, 0),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 8, 0, 16),
                                    child: Container(
                                      width: 150,
                                      height: 60,
                                      child: Stack(
                                        children: [
                                          Align(
                                            alignment:
                                                AlignmentDirectional(0, 0),
                                            child: Container(
                                              width: double.infinity,
                                              height: double.infinity,
                                              decoration: BoxDecoration(
                                                color: Color(0xFF00C013),
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                                shape: BoxShape.rectangle,
                                              ),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  SelectionArea(
                                                      child: Text(
                                                    '${addedDays} Hari',
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .title1
                                                        .override(
                                                          fontFamily: 'Poppins',
                                                          color: Colors.white,
                                                          fontSize: 16,
                                                        ),
                                                  )),
                                                  SelectionArea(
                                                      child: Text(
                                                    'Menuju Panen',
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyText1
                                                        .override(
                                                          fontFamily: 'Poppins',
                                                          color: Colors.white,
                                                          fontSize: 12,
                                                        ),
                                                  )),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Divider(
                                  thickness: 1,
                                  color: Colors.black,
                                ),
                                SelectionArea(
                                    child: Text(
                                  'Estimasi Hasil Panen',
                                  style: FlutterFlowTheme.of(context)
                                      .title1
                                      .override(
                                        fontFamily: 'Poppins',
                                        color: FlutterFlowTheme.of(context)
                                            .primaryText,
                                      ),
                                )),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 8, 0, 8),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Container(
                                        width: 150,
                                        height: 60,
                                        child: Stack(
                                          children: [
                                            Align(
                                              alignment:
                                                  AlignmentDirectional(0, 0),
                                              child: Container(
                                                width: double.infinity,
                                                height: double.infinity,
                                                decoration: BoxDecoration(
                                                  color: Color(0xFF00C013),
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                  shape: BoxShape.rectangle,
                                                ),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    SelectionArea(
                                                        child: Text(
                                                      '$unitWeight Kg',
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .title1
                                                          .override(
                                                            fontFamily:
                                                                'Poppins',
                                                            color: Colors.white,
                                                            fontSize: 16,
                                                          ),
                                                    )),
                                                    SelectionArea(
                                                        child: Text(
                                                      'Berat Satuan',
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .bodyText1
                                                          .override(
                                                            fontFamily:
                                                                'Poppins',
                                                            color: Colors.white,
                                                            fontSize: 12,
                                                          ),
                                                    )),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width: 150,
                                        height: 60,
                                        child: Stack(
                                          children: [
                                            Align(
                                              alignment:
                                                  AlignmentDirectional(0, 0),
                                              child: Container(
                                                width: double.infinity,
                                                height: double.infinity,
                                                decoration: BoxDecoration(
                                                  color: Color(0xFF00C013),
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                  shape: BoxShape.rectangle,
                                                ),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    SelectionArea(
                                                        child: Text(
                                                      bibit.toString(),
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .title1
                                                          .override(
                                                            fontFamily:
                                                                'Poppins',
                                                            color: Colors.white,
                                                            fontSize: 16,
                                                          ),
                                                    )),
                                                    SelectionArea(
                                                        child: Text(
                                                      'Jumlah Satuan',
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .bodyText1
                                                          .override(
                                                            fontFamily:
                                                                'Poppins',
                                                            color: Colors.white,
                                                            fontSize: 12,
                                                          ),
                                                    )),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Align(
                                  alignment: AlignmentDirectional(0, 0),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 8, 0, 16),
                                    child: Container(
                                      width: 150,
                                      height: 60,
                                      child: Stack(
                                        children: [
                                          Align(
                                            alignment:
                                                AlignmentDirectional(0, 0),
                                            child: Container(
                                              width: double.infinity,
                                              height: double.infinity,
                                              decoration: BoxDecoration(
                                                color: Color(0xFF00C013),
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                                shape: BoxShape.rectangle,
                                              ),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  SelectionArea(
                                                      child: Text(
                                                    '${unitWeight * bibit} Kg',
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .title1
                                                        .override(
                                                          fontFamily: 'Poppins',
                                                          color: Colors.white,
                                                          fontSize: 16,
                                                        ),
                                                  )),
                                                  SelectionArea(
                                                      child: Text(
                                                    'Berat Total',
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyText1
                                                        .override(
                                                          fontFamily: 'Poppins',
                                                          color: Colors.white,
                                                          fontSize: 12,
                                                        ),
                                                  )),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  floatingActionButtonLocation: ExpandableFab.location,
                  floatingActionButton: ExpandableFab(
                    key: fabKey,
                    // duration: const Duration(seconds: 1),
                    // type: ExpandableFabType.up,
                    // fanAngle: 70,
                    // child: const Icon(Icons.account_box),
                    // foregroundColor: Colors.amber,
                    backgroundColor: Colors.green,
                    child: Icon(
                      FontAwesomeIcons.leaf,
                      color: Colors.white,
                    ),
                    //   foregroundColor: Colors.deepOrangeAccent,
                    //   backgroundColor: Colors.lightGreen,
                    // ),
                    overlayStyle: ExpandableFabOverlayStyle(
                      // color: Colors.black.withOpacity(0.5),
                      blur: 5,
                    ),
                    children: [
                      FloatingActionButton(
                        backgroundColor: Colors.lightBlue,
                        child: const Icon(FontAwesomeIcons.droplet),
                        onPressed: () async {
                          bool aktuatorOnKTanah = await _aktuatorService
                              .onAktuatorKelembabanTanah();

                          if (aktuatorOnKTanah == true) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                duration: Duration(seconds: 3),
                                content:
                                    Text('Aktuator berhasil dihidupkan (60s)'),
                              ),
                            );
                          }

                          Timer(Duration(seconds: 3), () async {
                            await _aktuatorService.offAktuatorKelembabanTanah();
                          });
                        },
                      ),
                      FloatingActionButton(
                        heroTag: null,
                        backgroundColor: Colors.lightGreen,
                        child: SizedBox(
                            height: 24,
                            child: Image.asset('assets/icons/fertilizer.png')),
                        onPressed: () async {
                          bool aktuatorOnKTanah = await _aktuatorService
                              .onAktuatorKelembabanTanah();

                          if (aktuatorOnKTanah == true) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                duration: Duration(seconds: 3),
                                content:
                                    Text('Aktuator berhasil dihidupkan (60s)'),
                              ),
                            );
                          }

                          Timer(Duration(seconds: 3), () async {
                            await _aktuatorService.offAktuatorKelembabanTanah();
                          });
                        },
                      ),
                      FloatingActionButton(
                        heroTag: null,
                        backgroundColor: Colors.orangeAccent,
                        child: SizedBox(
                            height: 30,
                            child: Image.asset('assets/icons/harvest.png')),
                        onPressed: () {
                          final state = fabKey.currentState;
                          if (state != null) {
                            debugPrint('isOpen:${state.isOpen}');
                            state.toggle();
                          }
                        },
                      ),
                    ],
                  ),
                );
              }
            }
        }
      },
    );

    return Scaffold(
        body: RefreshIndicator(
            onRefresh: () {
              setState(() {
                _myData = _indicatorServices.getIndicatorList();
              });
              return Future<void>.delayed(const Duration(seconds: 2));
            },
            child: futureBuilder));
  }
}

class MapUtils {
  MapUtils._();

  static Future<void> openMap(double latitude, double longitude) async {
    Uri googleUrl = Uri.parse(
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude');
    if (await canLaunchUrl(googleUrl)) {
      await launchUrl(googleUrl);
    } else {
      throw 'Could not open the map.';
    }
  }
}
