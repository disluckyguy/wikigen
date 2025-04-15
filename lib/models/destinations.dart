import 'package:flutter/material.dart';


enum Destination{
  home(label: 'Home', icon: Icons.home_outlined, selectedIcon: Icons.home),
  settings(label: 'Settings', icon: Icons.settings_outlined, selectedIcon: Icons.settings);

  const Destination({required this.label, required this.icon, required this.selectedIcon});

  final String label;
  final IconData icon;
  final IconData selectedIcon;
  
}