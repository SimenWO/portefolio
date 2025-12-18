import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProjectsScreen extends StatelessWidget {
  const ProjectsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Projects Content Coming Soon',
        style: GoogleFonts.outfit(
          fontSize: 24,
          color: Theme.of(context).colorScheme.onSurface,
        ),
      ),
    );
  }
}
