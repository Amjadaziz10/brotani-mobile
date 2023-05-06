import 'package:brotani/home/home_page.dart';
import 'package:brotani/shared/colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../interfaces/login/login_interfaces.dart';
import '../../models/login/login_model.dart';
import '../../services/login/login_service.dart';
import '../../shared/flutter_flow_icon_button.dart';
import '../../shared/flutter_flow_theme.dart';

class SignInTab extends StatefulWidget {
  const SignInTab({Key? key}) : super(key: key);

  @override
  _SignInTabState createState() => _SignInTabState();
}

class _SignInTabState extends State<SignInTab> {
  final ILogin _loginService = LoginService();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  late bool passwordVisibility = false;
  bool _isButtonActive = false;
  bool showProgress = false;

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(24, 4, 24, 0),
            child: Container(
              width: double.infinity,
              height: 60,
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).secondaryBackground,
                boxShadow: const [
                  BoxShadow(
                    blurRadius: 5,
                    color: Colors.grey,
                    offset: Offset(0, 2),
                  )
                ],
                borderRadius: BorderRadius.circular(28),
              ),
              child: TextFormField(
                keyboardType: TextInputType.emailAddress,
                controller: usernameController,
                obscureText: false,
                decoration: InputDecoration(
                  labelStyle: FlutterFlowTheme.of(context).bodyText2.override(
                        fontFamily: 'Poppins',
                        color: Colors.green,
                      ),
                  hintText: 'Email',
                  hintStyle: FlutterFlowTheme.of(context).bodyText1.override(
                        fontFamily: 'Lexend Deca',
                        color: FlutterFlowTheme.of(context).secondaryText,
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                      ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Color(0x00000000),
                      width: 0,
                    ),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Color(0x00000000),
                      width: 0,
                    ),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  filled: true,
                  fillColor: FlutterFlowTheme.of(context).secondaryBackground,
                  contentPadding:
                      const EdgeInsetsDirectional.fromSTEB(24, 24, 20, 24),
                ),
                style: FlutterFlowTheme.of(context).bodyText1,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(24, 12, 24, 0),
            child: Container(
              width: double.infinity,
              height: 60,
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).secondaryBackground,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 5,
                    color: Colors.grey,
                    offset: const Offset(0, 2),
                  )
                ],
                borderRadius: BorderRadius.circular(28),
              ),
              child: TextFormField(
                controller: passwordController,
                obscureText: !passwordVisibility,
                decoration: InputDecoration(
                  labelStyle: FlutterFlowTheme.of(context).bodyText2,
                  hintText: 'Kata Sandi',
                  hintStyle: FlutterFlowTheme.of(context).bodyText1.override(
                        fontFamily: 'Lexend Deca',
                        color: FlutterFlowTheme.of(context).secondaryText,
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                      ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Color(0x00000000),
                      width: 0,
                    ),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Color(0x00000000),
                      width: 0,
                    ),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  filled: true,
                  fillColor: FlutterFlowTheme.of(context).secondaryBackground,
                  contentPadding:
                      const EdgeInsetsDirectional.fromSTEB(24, 24, 20, 24),
                  suffixIcon: InkWell(
                    onTap: () => setState(
                      () => passwordVisibility = !passwordVisibility,
                    ),
                    focusNode: FocusNode(skipTraversal: true),
                    child: Icon(
                      passwordVisibility
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                      color: FlutterFlowTheme.of(context).secondaryText,
                      size: 22,
                    ),
                  ),
                ),
                style: FlutterFlowTheme.of(context).bodyText1,
              ),
            ),
          ),
          Align(
              alignment: AlignmentDirectional(1, 0),
              child: InkWell(
                onTap: () {},
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 12, 48, 12),
                  child: Text(
                    'Lupa kata sandi?',
                    textAlign: TextAlign.center,
                    style: FlutterFlowTheme.of(context).subtitle1.override(
                          fontFamily: 'Poppins',
                          color: Colors.black,
                          fontSize: 14,
                        ),
                  ),
                ),
              )),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(24, 12, 24, 36),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      elevation: 3,
                      backgroundColor: greenBold,
                      disabledBackgroundColor: green,
                      shape: StadiumBorder()),
                  onPressed: !showProgress
                      ? () async {
                          setState(() => showProgress = true);
                          if (usernameController.text.isNotEmpty &&
                              passwordController.text.isNotEmpty) {
                            LoginModel? user = await _loginService.login(
                                usernameController.text,
                                passwordController.text);
                            if (user != null) {
                              setState(() => showProgress = false);
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (_) => HomePage(),
                                ),
                              );
                            } else {
                              setState(() => showProgress = false);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  duration: Duration(seconds: 3),
                                  content: Text('Email atau kata sandi salah'),
                                ),
                              );
                              return null;
                            }
                          } else {
                            setState(() => showProgress = false);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                duration: Duration(seconds: 3),
                                content: Text(
                                    "Kolom email atau password tidak boleh kosong"),
                              ),
                            );
                          }
                        }
                      : null,
                  child: showProgress
                      ? Center(
                          child: CircularProgressIndicator(
                          color: Colors.white,
                        ))
                      : Text(
                          'Login',
                          style:
                              FlutterFlowTheme.of(context).subtitle2.override(
                                    fontFamily: 'Poppins',
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryBackground,
                                    fontSize: 16,
                                  ),
                        )),
            ),
          ),
          // const OrDivider(),
          // Padding(
          //   padding: const EdgeInsetsDirectional.fromSTEB(0, 24, 0, 0),
          //   child: Row(
          //     mainAxisSize: MainAxisSize.min,
          //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //     children: [
          //       Padding(
          //         padding: EdgeInsetsDirectional.fromSTEB(0, 24, 24, 24),
          //         child: FlutterFlowIconButton(
          //           borderColor: Colors.transparent,
          //           borderRadius: 30,
          //           borderWidth: 1,
          //           buttonSize: 60,
          //           fillColor: Color(0xFFFF4031),
          //           icon: FaIcon(
          //             FontAwesomeIcons.google,
          //             color: Color(0xFFF9F9F9),
          //             size: 30,
          //           ),
          //           onPressed: () {},
          //         ),
          //       ),
          //       Padding(
          //         padding: EdgeInsetsDirectional.fromSTEB(0, 24, 0, 24),
          //         child: FlutterFlowIconButton(
          //           borderColor: Colors.transparent,
          //           borderRadius: 30,
          //           borderWidth: 1,
          //           buttonSize: 60,
          //           fillColor: Color(0xFF3C5A98),
          //           icon: FaIcon(
          //             FontAwesomeIcons.facebookF,
          //             color: Color(0xFFF9F9F9),
          //             size: 30,
          //           ),
          //           onPressed: () {
          //             print('IconButton pressed ...');
          //           },
          //         ),
          //       ),
          //     ],
          //   ),
          // )
        ],
      ),
    ]);
  }
}

class OrDivider extends StatelessWidget {
  const OrDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.8,
      child: Row(
        children: <Widget>[
          buildDivider(),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              "or continue with",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          buildDivider(),
        ],
      ),
    );
  }

  Expanded buildDivider() {
    return const Expanded(
      child: Divider(
        color: Colors.black,
        height: 1.5,
      ),
    );
  }
}
