import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_doctor_ui/ChangeNotifier/ExtendNavigationRail.dart';
import 'package:flutter_doctor_ui/widgets/General/CustomPrimaryButton.dart';

class MyCareTeamCard extends StatelessWidget {
  final double cardWidth;
  final double cardHeight;
  final double containerWidth;
  final List<Map<String, dynamic>> careTeam;
  final List<Map<String, dynamic>> careTeamDoctor;
  final List<Map<String, dynamic>> careTeamSpecialty;
  final List<Map<String, dynamic>> careTeamFacility;

  MyCareTeamCard({
    required this.cardWidth,
    required this.cardHeight,
    required this.containerWidth,
    required this.careTeam,
    required this.careTeamDoctor,
    required this.careTeamSpecialty,
    required this.careTeamFacility,
  });

  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    ExtendNavigationRail extendNavigationRail =
        Provider.of<ExtendNavigationRail>(context);

    return Container(
      width: cardWidth,
      height: cardHeight,
      padding: const EdgeInsets.only(
        top: 15.0,
        left: 0.0,
        bottom: 15.0,
        right: 0.0,
      ),
      margin: const EdgeInsets.only(
        top: 30.0,
        bottom: 10.0,
        right: 20.0,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF4454C3).withOpacity(0.25),
            blurRadius: 4, // Spread radius
            offset: const Offset(2, 2),
          ),
        ],
        border: Border.all(
          color: const Color(0xFF4454C3).withOpacity(0.15),
          width: .5,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.only(
              left: 18,
            ),
            child: const Text(
              "My Care Team",
              style: TextStyle(
                color: Color(0xFF424E79),
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          SizedBox(
            height: 165,
            child: PageView.builder(
              controller: _pageController,
              itemCount: careTeam.length,
              itemBuilder: (context, index) {
                return buildCareTeamCard(
                    careTeamDoctor[index],
                    careTeamSpecialty[index],
                    careTeamFacility[index],
                    extendNavigationRail);
              },
              onPageChanged: (index) {
                extendNavigationRail.updateCareTeamPage(index);
              },
            ),
          ),
          buildPageIndicator(careTeam.length, extendNavigationRail),
        ],
      ),
    );
  }

  Widget buildCareTeamCard(
      Map<String, dynamic> careTeamDoctor,
      Map<String, dynamic> careTeamSpecialty,
      Map<String, dynamic> careTeamFacility,
      ExtendNavigationRail extendNavigationRail) {
    return Container(
      width: containerWidth,
      child: ListTile(
        title: Padding(
          padding: const EdgeInsets.only(left: 2.0, bottom: 5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    '${careTeamDoctor['professional_display_name']}',
                    style: const TextStyle(
                      color: Color(0xFF424E79),
                      fontSize: 21,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 7.0),
                  Row(
                    children: [
                      const Icon(
                        Icons.medical_services_outlined,
                        color: Color(0xFF424E79),
                        size: 26,
                      ),
                      const SizedBox(width: 8.0),
                      Text(
                        '${careTeamSpecialty['display_name']}',
                        style: const TextStyle(
                          color: Color(0xFF424E79),
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 3.0),
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on_outlined,
                        color: Color(0xFF424E79),
                        size: 26,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '${careTeamFacility['name']}',
                        style: const TextStyle(
                          color: Color(0xFF424E79),
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15.0),
                  Row(
                    children: [
                      CustomPrimaryButton(
                        text: 'Book',
                        onPress: () {},
                        inputHeight: 35,
                        inputWidth: 110,
                        fontSize: 17,
                        fontColor: Colors.white,
                        buttonColor: const Color(0xFF4454C3),
                        buttonOutline: const Color(0xFF4454C3),
                        outlineWidth: 0,
                      ),
                      const SizedBox(width: 8),
                      CustomPrimaryButton(
                        text: 'Profile',
                        onPress: () {},
                        inputHeight: 35,
                        inputWidth: 110,
                        fontSize: 17,
                        fontColor: const Color(0xFF4454C3),
                        buttonColor: Colors.white,
                        buttonOutline: const Color(0xFF4454C3),
                        outlineWidth: 3,
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                width: 15,
              ),
              Container(
                width: 125,
                height: 125,
                alignment: Alignment.centerRight,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(100),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF4454C3).withOpacity(0.25),
                      blurRadius: 4,
                      offset: const Offset(0, 3),
                    ),
                  ],
                  border: Border.all(
                    color: const Color(0xFF4454C3).withOpacity(0.50),
                    width: 0.5,
                  ),
                ),
                child: Container(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: (careTeamDoctor['img_url'] != null)
                        ? Image.network(
                            'http://10.0.2.2:8080/sugbodoc-multi-tenant/${careTeamDoctor['img_url']}', // Dynamic Variable
                            height: 125,
                            width: 125,
                            errorBuilder: (context, error, stackTrace) {
                              // Use the default image if loading the image fails
                              return Image.asset(
                                'assets/images/JPG/default_profile.jpg',
                                height: 125,
                                width: 125,
                              );
                            },
                          )
                        : Image.asset(
                            'assets/images/JPG/default_profile.jpg', // Dynamic Variable
                            height: 125,
                            width: 125,
                          ),
                  ),
                ),
              ),
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
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: InkWell(
            onTap: () {
              _pageController.animateToPage(
                index,
                duration: Duration(milliseconds: 500),
                curve: Curves.easeIn,
              );
            },
            child: CircleAvatar(
              radius: 6,
              backgroundColor: extendNavigationRail.careTeamPage == index
                  ? const Color(0xFF4454C3)
                  : Color.fromARGB(255, 184, 194, 255),
            ),
          ),
        ),
      ),
    );
  }
}
