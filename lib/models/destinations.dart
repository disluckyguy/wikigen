import 'package:flutter/material.dart';

class Destination {
  const Destination(this.label, this.icon, this.selectedIcon);

  final String label;
  final Widget icon;
  final Widget selectedIcon;
}

const List<Destination> destinations = <Destination>[
  Destination(
      'Home', Icon(Icons.home_outlined), Icon(Icons.home)),
  Destination(
      'Trash', Icon(Icons.delete_outlined), Icon(Icons.delete)),
  Destination(
      'Settings', Icon(Icons.settings_outlined), Icon(Icons.settings)),
];
