import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class CustomBottomNav extends StatelessWidget {
  String patient_one_image = "assets/images/JPG/patient_one.jpg";
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      child: GNav(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        backgroundColor: const Color(0xFF4454C3).withOpacity(0.00),
        hoverColor: const Color(0xFF4454C3).withOpacity(0.55),
        tabBackgroundColor: const Color(0xFF4454C3).withOpacity(1.00),
        tabBorderRadius: 15,
        haptic: true, // haptic feedback
        curve: Curves.easeInOutExpo,
        iconSize: 24,
        activeColor: Colors.white,
        duration: const Duration(milliseconds: 500),
        gap: 10,
        tabs: const [
          GButton(
            icon: Icons.dashboard,
            iconColor: Color(0xFF4454C3),
            text: 'Dashboard',
          ),
          GButton(
            icon: Icons.person_search_rounded,
            iconColor: Color(0xFF4454C3),
            text: 'Doctor',
          ),
          GButton(
            icon: Icons.domain_add_rounded,
            iconColor: Color(0xFF4454C3),
            text: 'Facilities',
          ),
          GButton(
            icon: Icons.medical_services_rounded,
            iconColor: Color(0xFF4454C3),
            text: 'Services',
          ),
          GButton(
            icon: Icons.payments,
            iconColor: Color(0xFF4454C3),
            text: 'Payments',
          ),
        ],
        selectedIndex: 0,
        onTabChange: (index) {},
      ),
    );
  }
}
