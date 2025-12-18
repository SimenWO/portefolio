import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:portifolio/widgets/glass_card.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Bio Section
            Text(
              'About Me',
              style: GoogleFonts.outfit(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'I am a Cloud and DevOps Engineer with extensive experience in the Azure ecosystem. I specialize in building scalable cloud infrastructures, automating deployment pipelines, and securing cloud environments.',
              style: GoogleFonts.outfit(
                fontSize: 16,
                height: 1.6,
                color: Theme.of(
                  context,
                ).colorScheme.onSurface.withValues(alpha: 0.8),
              ),
            ),
            const SizedBox(height: 60),

            // Certifications Section
            Text(
              'Certifications',
              style: GoogleFonts.outfit(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 24),
            _buildCertificationsGrid(context),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildHeroSection(BuildContext context) {
    return Container(); // Unused
  }

  Widget _buildCertificationsGrid(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final crossAxisCount = width < 700 ? 1 : 2;

    final certifications = [
      {
        'title': 'AI Engineer Associate [AI-102]',
        'date': 'Issued 08 Oct 2025',
        'icon': FontAwesomeIcons.microsoft,
      },
      {
        'title': 'Azure Developer Associate [AZ-204]',
        'date': 'Issued 29 Aug 2025',
        'icon': FontAwesomeIcons.microsoft,
      },
      {
        'title': 'NME-200',
        'date': 'Issued 22 Nov 2024',
        'icon': FontAwesomeIcons.cloud,
      },
      {
        'title': 'Azure Virtual Desktop Specialty [AZ-140]',
        'date': 'Issued 07 Jul 2023',
        'icon': FontAwesomeIcons.microsoft,
      },
      {
        'title': 'Azure Network Engineer Associate [AZ-700]',
        'date': 'Issued 26 Oct 2022',
        'icon': FontAwesomeIcons.microsoft,
      },
      {
        'title': 'DevOps Engineer Expert [AZ-400]',
        'date': 'Issued 24 Mar 2022',
        'icon': FontAwesomeIcons.microsoft,
      },
      {
        'title': 'Azure Security Engineer Associate [AZ-500]',
        'date': 'Issued 03 Feb 2022',
        'icon': FontAwesomeIcons.microsoft,
      },
      {
        'title': 'Azure Administrator Associate [AZ-104]',
        'date': 'Issued 15 Jul 2021',
        'icon': FontAwesomeIcons.microsoft,
      },
      {
        'title': 'Azure Fundamentals [AZ-900]',
        'date': 'Issued 10 Sep 2020',
        'icon': FontAwesomeIcons.microsoft,
      },
    ];

    return StaggeredGrid.count(
      crossAxisCount: crossAxisCount,
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      children: certifications.map((cert) {
        return StaggeredGridTile.fit(
          crossAxisCellCount: 1,
          child: _buildCertificationCard(
            context,
            cert['title'] as String,
            cert['date'] as String,
            cert['icon'] as IconData,
          ),
        );
      }).toList(),
    );
  }

  Widget _buildCertificationCard(
    BuildContext context,
    String title,
    String date,
    IconData icon,
  ) {
    return GlassCard(
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Theme.of(
                context,
              ).colorScheme.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: FaIcon(
              icon,
              size: 24,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.outfit(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  date,
                  style: GoogleFonts.outfit(
                    fontSize: 12,
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withValues(alpha: 0.6),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
