import 'package:flutter/material.dart';

class OnboradingViewModel {
  final Color color;
  final String heroAssetPath;
  final String title;
  final String body;
  final String iconAssetPath;
  final bool isFinal;

  OnboradingViewModel(
    this.color,
    this.heroAssetPath,
    this.title,
    this.body,
    this.iconAssetPath,
    this.isFinal
  );
}