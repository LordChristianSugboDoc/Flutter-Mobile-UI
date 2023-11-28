import 'package:flutter/material.dart';
import 'package:flutter_doctor_ui/ChangeNotifier/ExtendNavigationRail.dart';
import 'package:flutter_doctor_ui/screens/Login/login.dart';
import 'package:provider/provider.dart';

class CustomNavigationRail extends StatelessWidget {
  final ValueChanged<int> onDestinationSelected;
  final Future<void> Function() logout;

  CustomNavigationRail({
    required this.onDestinationSelected,
    required this.logout,
  });

  @override
  Widget build(BuildContext context) {
    ExtendNavigationRail extendNavigationRail =
        Provider.of<ExtendNavigationRail>(context);
    bool isLeading = extendNavigationRail.isLeading;
    bool isTrailing = extendNavigationRail.isTrailing;
    bool isImageVisible = extendNavigationRail.isImageVisible;
    bool isTextVisible = extendNavigationRail.isTextVisible;
    bool changeIcon = extendNavigationRail.isImageVisible;
    int index = extendNavigationRail.index;
    double height = MediaQuery.of(context).size.height;
    EdgeInsetsGeometry padding = EdgeInsets.only(top: height * 0.20);
    return AnimatedContainer(
      duration: Duration(milliseconds: 100),
      color: const Color(0xFF4454C3),
      padding: const EdgeInsets.only(top: 20),
      child: Theme(
        data: ThemeData(
          highlightColor: Colors.transparent,
          splashFactory: NoSplash.splashFactory,
          indicatorColor: Colors.transparent,
        ),
        child: NavigationRail(
          backgroundColor: const Color(0xFF4454C3),
          selectedIndex: index,
          extended: extendNavigationRail.isExtended,
          selectedLabelTextStyle: const TextStyle(
            color: Colors.white,
            fontSize: 19,
            fontWeight: FontWeight.w900,
          ),
          unselectedLabelTextStyle: const TextStyle(
            color: Colors.white,
            fontSize: 19,
            fontWeight: FontWeight.w500,
          ),
          selectedIconTheme:
              const IconThemeData(color: Color(0xFF4454C3), size: 30),
          unselectedIconTheme:
              const IconThemeData(color: Colors.white, size: 30),
          onDestinationSelected: (index) {
            extendNavigationRail.setPage(index);
          },
          leading: isLeading
              ? Row(
                  children: [
                    Container(
                      child: isImageVisible
                          ? Image.asset(
                              'assets/images/PNG/sugbodoc_white_logo.png',
                              height: 50,
                              width: 180,
                            )
                          : Container(),
                    ),
                    FloatingActionButton(
                      backgroundColor: const Color(0xFF4454C3),
                      elevation: 0,
                      onPressed: () {
                        extendNavigationRail.isCondition();
                        extendNavigationRail.changeWidth();
                      },
                      child: changeIcon
                          ? const Icon(
                              Icons.arrow_circle_left_outlined,
                              size: 35,
                              color: Colors.white,
                            )
                          : const Icon(
                              Icons.arrow_circle_right_outlined,
                              size: 35,
                              color: Colors.white,
                            ),
                    ),
                  ],
                )
              : const SizedBox(),
          trailing: isTrailing
              ? Padding(
                  padding: padding,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(
                        onPressed: () {
                          logout;
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              Login.routeName, (Route<dynamic> route) => false);
                        },
                        icon: Row(
                          children: [
                            const Icon(Icons.logout_rounded,
                                size: 30, color: Colors.white),
                            Container(
                              child: isTextVisible
                                  ? const Row(
                                      children: [
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          'Logout',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 19,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        )
                                      ],
                                    )
                                  : const Text(''),
                            )
                          ],
                        ),
                      ),
                    ],
                  ))
              : const SizedBox(),
          destinations: const [
            NavigationRailDestination(
              icon: Icon(Icons.dashboard),
              selectedIcon: Icon(Icons.dashboard_outlined),
              label: Text(
                'Dashboard',
              ),
            ),
            NavigationRailDestination(
              icon: Icon(Icons.co_present),
              selectedIcon: Icon(Icons.co_present_outlined),
              label: Text(
                'My Procedures',
              ),
            ),
            NavigationRailDestination(
              icon: Icon(Icons.person_search),
              selectedIcon: Icon(Icons.person_search_outlined),
              label: Text(
                'Find Doctors',
              ),
            ),
            NavigationRailDestination(
              icon: Icon(Icons.event_available),
              selectedIcon: Icon(Icons.event_available_outlined),
              label: Text(
                'Appointments',
              ),
            ),
            NavigationRailDestination(
              icon: Icon(Icons.medical_information),
              selectedIcon: Icon(Icons.medical_information_outlined),
              label: Text(
                'Find Facilities',
              ),
            ),
            NavigationRailDestination(
              icon: Icon(Icons.medical_services),
              selectedIcon: Icon(Icons.medical_services_outlined),
              label: Text(
                'Health Services',
              ),
            ),
            NavigationRailDestination(
              icon: Icon(Icons.analytics),
              selectedIcon: Icon(Icons.analytics_outlined),
              label: Text(
                'Lab Results',
              ),
            ),
            NavigationRailDestination(
              icon: Icon(Icons.insert_chart),
              selectedIcon: Icon(Icons.insert_chart_outlined_outlined),
              label: Text(
                'Clinical Notes',
              ),
            ),
            NavigationRailDestination(
              icon: Icon(Icons.medication),
              selectedIcon: Icon(Icons.medication_outlined),
              label: Text(
                'Prescriptions',
              ),
            ),
            NavigationRailDestination(
              icon: Icon(Icons.create_new_folder),
              selectedIcon: Icon(Icons.create_new_folder_outlined),
              label: Text(
                'Files',
              ),
            ),
            NavigationRailDestination(
              icon: Icon(Icons.payments),
              selectedIcon: Icon(Icons.payments_outlined),
              label: Text(
                'Payments',
              ),
            ),
            NavigationRailDestination(
              icon: Icon(Icons.settings),
              selectedIcon: Icon(Icons.settings_outlined),
              label: Text(
                'Settings',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
