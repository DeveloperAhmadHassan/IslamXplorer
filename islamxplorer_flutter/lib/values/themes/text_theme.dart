import 'package:flutter/material.dart';

class AppTextTheme{
  static TextTheme lightTextTheme = TextTheme(
    headlineLarge: const TextStyle().copyWith(
        fontFamily: "IBMPlexMono",
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Colors.black87
    ),
    bodyLarge: const TextStyle().copyWith(
        fontFamily: "IBMPlexMono",
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Colors.black87
    ),
    bodyMedium: const TextStyle().copyWith(
        fontFamily: "IBMPlexMono",
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Colors.black87
    ),
    bodySmall: const TextStyle().copyWith(
        fontFamily: "IBMPlexMono",
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Colors.red
    ),
    // titleMedium: const TextStyle().copyWith(
    //     fontFamily: "IBMPlexMono",
    //     fontSize: 16,
    //     fontWeight: FontWeight.bold,
    //     color: Colors.black87
    // ),
    // titleSmall: const TextStyle().copyWith(
    //     fontFamily: "IBMPlexMono",
    //     fontSize: 16,
    //     fontWeight: FontWeight.bold,
    //     color: Colors.black87,
    // ),

    // headline6: const TextStyle().copyWith(
    //   fontFamily: "IBMPlexMono",
    //   fontSize: 16,
    //   fontWeight: FontWeight.normal,
    //   color: Colors.white, // Adjust the color as needed
    // ),
  );
  static TextTheme darkTextTheme = TextTheme(
    headlineLarge: const TextStyle().copyWith(
      fontFamily: "IBMPlexMono",
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: Colors.white70
    ),
    bodyLarge: const TextStyle().copyWith(
        fontFamily: "IBMPlexMono",
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Colors.white70
    ),
    bodyMedium: const TextStyle().copyWith(
        fontFamily: "IBMPlexMono",
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Colors.white70
    ),
    bodySmall: const TextStyle().copyWith(
        fontFamily: "IBMPlexMono",
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Colors.white70
    ),
    // titleMedium: const TextStyle().copyWith(
    //     fontFamily: "IBMPlexMono",
    //     fontSize: 16,
    //     fontWeight: FontWeight.bold,
    //     color: Colors.white70
    // ),
    // titleSmall: const TextStyle().copyWith(
    //     fontFamily: "IBMPlexMono",
    //     fontSize: 16,
    //     fontWeight: FontWeight.bold,
    //     color: Colors.white70
    // ),
    // headline6: const TextStyle().copyWith(
    //   fontFamily: "IBMPlexMono",
    //   fontSize: 16,
    //   fontWeight: FontWeight.normal,
    //   color: Colors.white, // Adjust the color as needed
    // ),
  );
}