import 'package:brotani/onboarding/components/sign_in_tab.dart';
import 'package:brotani/onboarding/components/sign_up_tab.dart';
import 'package:brotani/shared/colors.dart';
import 'package:flutter/material.dart';

import '../../shared/flutter_flow_theme.dart';

class Tabs extends StatelessWidget {
  const Tabs({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: DefaultTabController(
              length: 2,
              initialIndex: 0,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(24),
                    child: TabBar(
                      labelColor: greenBold,
                      unselectedLabelColor: Color(0xFFB9B6B6),
                      labelStyle: FlutterFlowTheme.of(context).subtitle1,
                      indicatorColor: greenBold,
                      tabs: const [
                        Tab(
                          text: 'Sign In',
                        ),
                        Tab(
                          text: 'Sign Up',
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    0, 16, 0, 4),
                                child: SignInTab(),
                              ),
                            ],
                          ),
                        ),
                        SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 16, 0, 4),
                                  child: SignUpTab()),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
