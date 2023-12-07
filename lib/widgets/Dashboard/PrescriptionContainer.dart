import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_doctor_ui/ChangeNotifier/ExtendNavigationRail.dart';

class PrescriptionContainer extends StatelessWidget {
  final double cardWidth;
  final double cardHeight;
  final double containerWidth;
  final Map<String, dynamic> medicationDoctor;
  final Map<String, dynamic> medicationFacility;
  final List<Map<String, String>> medicationRequests;

  PrescriptionContainer({
    required this.cardWidth,
    required this.cardHeight,
    required this.containerWidth,
    required this.medicationDoctor,
    required this.medicationFacility,
    required this.medicationRequests,
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
        top: 15.0,
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
            padding: const EdgeInsets.only(bottom: 5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "My Prescriptions",
                  style: TextStyle(
                    color: Color(0xFF424E79),
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: const Text(
                    "View All",
                    style: TextStyle(
                      color: Color(0xFF4454C3),
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 175,
            child: PageView.builder(
              controller: _pageController,
              itemCount: medicationRequests.length,
              itemBuilder: (context, index) {
                return buildPrescriptionCard(
                    medicationRequests[index], extendNavigationRail);
              },
              onPageChanged: (index) {
                extendNavigationRail.updatePrescriptionPage(index);
              },
            ),
          ),
          buildPageIndicator(medicationRequests.length, extendNavigationRail),
        ],
      ),
    );
  }

  Widget buildPrescriptionCard(Map<String, String> prescription,
      ExtendNavigationRail extendNavigationRail) {
    return Container(
      width: containerWidth,
      child: ListTile(
        title: Padding(
          padding: const EdgeInsets.only(right: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(right: 0),
                padding: const EdgeInsets.only(bottom: 100),
                alignment: Alignment.centerLeft,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.asset(
                    'assets/images/JPG/RX.jpg',
                    height: 75,
                    width: 75,
                  ),
                ),
              ),
              const SizedBox(
                width: 18,
              ),
              Expanded(
                flex: 5,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${medicationDoctor['professional_display_name']}',
                      style: const TextStyle(
                        color: Color(0xFF424E79),
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    Text(
                      '${medicationFacility['name']}',
                      style: const TextStyle(
                        color: Color(0xFF424E79),
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.medication_outlined,
                          color: Color(0xFF424E79),
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Flexible(
                          child: Text(
                            '${(prescription['name'] ?? '').substring(0, 36)}...', // Display the first 20 characters
                            style: const TextStyle(
                              color: Color(0xFF424E79),
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.medical_information_outlined,
                          color: Color(0xFF424E79),
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Flexible(
                          child: Text(
                            prescription['sig'] ?? '',
                            style: const TextStyle(
                              color: Color(0xFF424E79),
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                        ),
                      ],
                    ),
                  ],
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
              backgroundColor: extendNavigationRail.prescriptionPage == index
                  ? const Color(0xFF4454C3)
                  : Color.fromARGB(255, 184, 194, 255),
            ),
          ),
        ),
      ),
    );
  }
}
