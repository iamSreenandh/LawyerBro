import 'package:flutter/material.dart';

/// ─────────────────────────────────────────────────────────────────────────────
/// LawyerBro Color Palette
/// Inspired by the Fineed high-fidelity design:
///   • Lime-green accent on dark splash
///   • White card surfaces on a light sage background
///   • Near-black text for strong contrast
/// ─────────────────────────────────────────────────────────────────────────────
class AppColors {
  AppColors._();

  // ── Brand / Accent ──────────────────────────────────────────────────────────
  /// Neon lime-green — primary CTA, splash screen, active states
  static const Color primary = Color(0xFFC5F135);

  /// Slightly deeper lime — pressed / ripple variant
  static const Color primaryDark = Color(0xFFAAD620);

  /// Very light tint used for chips and secondary highlights
  static const Color primarySurface = Color(0xFFF0FAD8);

  // ── Backgrounds ─────────────────────────────────────────────────────────────
  /// App-wide scaffold background (light sage)
  static const Color background = Color(0xFFEFF5EC);

  /// Card / sheet surface (pure white)
  static const Color surface = Color(0xFFFFFFFF);

  /// Splash / dark-hero surface (near-black)
  static const Color darkSurface = Color(0xFF111111);

  /// Slightly elevated surface inside cards
  static const Color cardBackground = Color(0xFFF8FAF6);

  // ── Text ────────────────────────────────────────────────────────────────────
  /// Headings & primary labels (near-black, warm)
  static const Color textPrimary = Color(0xFF121212);

  /// Body / sub-labels
  static const Color textSecondary = Color(0xFF6B7280);

  /// Placeholder / hints
  static const Color textHint = Color(0xFFB0B8C1);

  /// Text on dark backgrounds (e.g. splash heading)
  static const Color textOnDark = Color(0xFFFFFFFF);

  /// Text on lime-green buttons
  static const Color textOnPrimary = Color(0xFF111111);

  // ── Borders & Dividers ───────────────────────────────────────────────────────
  static const Color border = Color(0xFFE5E9E2);
  static const Color divider = Color(0xFFEEF1EB);

  // ── Status ──────────────────────────────────────────────────────────────────
  static const Color success = Color(0xFF4CAF50);
  static const Color warning = Color(0xFFFFC107);
  static const Color error = Color(0xFFEF4444);
  static const Color info = Color(0xFF3B82F6);

  // ── Misc ────────────────────────────────────────────────────────────────────
  static const Color overlay = Color(0x80000000);
  static const Color shimmer = Color(0xFFE8EDE5);
  static const Color shimmerHighlight = Color(0xFFF4F8F1);
}
