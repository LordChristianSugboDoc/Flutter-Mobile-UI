import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_doctor_ui/ChangeNotifier/ExtendNavigationRail.dart';

class MyPastEncountersCard extends StatelessWidget {
  final double cardWidth;
  final double cardHeight;
  final double containerWidth;
  final Map<String, dynamic> encounterDoctor;
  final Map<String, dynamic> encounterFacility;
  final List<Map<String, String>> patientEncounters;
  final List<Map<String, String>> pastVisits;

  MyPastEncountersCard({
    required this.cardWidth,
    required this.cardHeight,
    required this.containerWidth,
    required this.encounterDoctor,
    required this.encounterFacility,
    required this.patientEncounters,
    required this.pastVisits,
  });

  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    ExtendNavigationRail extendNavigationRail =
        Provider.of<ExtendNavigationRail>(context);
    return Container(
      height: cardHeight,
      width: cardWidth,
      padding: const EdgeInsets.only(
        top: 15.0,
        left: 18.0,
        bottom: 15.0,
        right: 18.0,
      ),
      margin: const EdgeInsets.only(
        top: 10.0,
        bottom: 10.0,
        right: 20.0,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF4454C3).withOpacity(0.25),
            blurRadius: 4,
            offset: const Offset(2, 2),
          ),
        ],
        border: Border.all(
          color: const Color(0xFF4454C3).withOpacity(0.15),
          width: .5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "My Past Visits",
                  style: TextStyle(
                    color: Color(0xFF424E79),
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: const Text(
                    "View All",
                    style: TextStyle(
                      color: Color(0xFF4454C3),
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 145,
            child: PageView.builder(
              controller: _pageController,
              itemCount: pastVisits.length,
              itemBuilder: (context, index) {
                return buildPastEncountersCard(patientEncounters[index],
                    pastVisits[index], extendNavigationRail);
              },
              onPageChanged: (index) {
                extendNavigationRail.updatePastVisitsPage(index);
              },
            ),
          ),
          buildPageIndicator(pastVisits.length, extendNavigationRail),
        ],
      ),
    );
  }

  Widget buildPastEncountersCard(
      Map<String, String> patientEncounter,
      Map<String, String> pastVisit,
      ExtendNavigationRail extendNavigationRail) {
    return Container(
      width: containerWidth,
      child: ListTile(
        title: Padding(
          padding: const EdgeInsets.only(bottom: 5.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 80,
                width: 80,
                margin: EdgeInsets.only(bottom: 10),
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(
                    color: const Color(0xFF4454C3),
                    width: 3.0,
                  ),
                ),
                child: Container(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(200),
                    child: (encounterDoctor['img_url'] != null)
                        ? Image.network(
                            'http://10.0.2.2:8080/sugbodoc-multi-tenant/${encounterDoctor['img_url']}', // Dynamic Variable
                            height: 80,
                            width: 80,
                            errorBuilder: (context, error, stackTrace) {
                              // Use the default image if loading the image fails
                              return Image.asset(
                                'assets/images/JPG/default_profile.jpg',
                                height: 80,
                                width: 80,
                              );
                            },
                          )
                        : Image.asset(
                            'assets/images/JPG/default_profile.jpg', // Dynamic Variable
                            height: 80,
                            width: 80,
                          ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${encounterFacility['name']}',
                      style: const TextStyle(
                        color: Color(0xFF424E79),
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    Text(
                      '${encounterDoctor['professional_display_name']}',
                      style: const TextStyle(
                        color: Color(0xFF424E79),
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    Text(
                      '"${pastVisit['appointment_reason_text']}"',
                      style: const TextStyle(
                        color: Color(0xFF424E79),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 2.0),
                    Text(
                      '${calculateTimeAgo(patientEncounter['ended_at'] ?? '')}',
                      style: const TextStyle(
                        color: Color.fromARGB(255, 152, 152, 152),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 10.0),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildPageIndicator(
      int pageCount, ExtendNavigationRail extendNavigationRail) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List<Widget>.generate(
        pageCount,
        (index) => Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 4,
          ),
          child: InkWell(
            onTap: () {
              _pageController.animateToPage(
                index,
                duration: Duration(milliseconds: 500),
                curve: Curves.easeIn,
              );
            },
            child: CircleAvatar(
              radius: 4,
              backgroundColor: extendNavigationRail.pastVisitPage == index
                  ? const Color(0xFF4454C3)
                  : Color.fromARGB(255, 184, 194, 255),
            ),
          ),
        ),
      ),
    );
  }

  String calculateTimeAgo(String dateTimeString) {
    DateTime encounterDate = DateTime.parse(dateTimeString);
    DateTime now = DateTime.now();
    Duration difference = now.difference(encounterDate);

    if (difference.inDays > 6) {
      int weeks = difference.inDays ~/ 7;
      int remainingDays = difference.inDays % 7;

      if (difference.inHours > 0) {
        if (remainingDays > 0) {
          return '$weeks ${weeks == 1 ? 'week' : 'weeks'} and $remainingDays ${remainingDays == 1 ? 'day' : 'days'} ago';
        } else {
          return '$weeks ${weeks == 1 ? 'week' : 'weeks'} ago';
        }
      }
    } else if (difference.inDays > 0) {
      if (difference.inDays == 1) {
        return '1 day ago';
      } else {
        return '${difference.inDays} days ago';
      }
    } else if (difference.inHours > 0) {
      if (difference.inHours == 1) {
        return '1 hour ago';
      } else {
        return '${difference.inHours} hours ago';
      }
    } else if (difference.inMinutes > 0) {
      if (difference.inMinutes == 1) {
        return '1 minute ago';
      } else {
        return '${difference.inMinutes} minutes ago';
      }
    } else {
      return 'Just now';
    }
    // Add a default return statement to handle all cases
    return 'Just now';
  }
}
