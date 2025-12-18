import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class Sidebar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;

  const Sidebar({
    super.key,
    required this.selectedIndex,
    required this.onDestinationSelected,
  });

  @override
  Widget build(BuildContext context) {
    // Glassmorphism Sidebar Container
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20.0, sigmaY: 20.0),
        child: Container(
          width:
              280, // Ensure width content matches existing layout expectations
          decoration: BoxDecoration(
            color: Theme.of(
              context,
            ).scaffoldBackgroundColor.withValues(alpha: 0.7),
            border: Border(
              right: BorderSide(
                color: Colors.white.withValues(alpha: 0.1),
                width: 1,
              ),
            ),
          ),
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: IntrinsicHeight(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 60),

                        // Profile Section
                        _buildProfileSection(context),

                        const SizedBox(height: 50),

                        // Navigation Items
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Column(
                            children: [
                              _buildNavItem(
                                context,
                                index: 0,
                                icon: FontAwesomeIcons.house,
                                label: 'Home',
                              ),
                              const SizedBox(height: 8),
                              _buildNavItem(
                                context,
                                index: 1,
                                icon: FontAwesomeIcons.penNib,
                                label: 'Blog',
                              ),
                              const SizedBox(height: 8),
                              _buildNavItem(
                                context,
                                index: 2,
                                icon: FontAwesomeIcons.user,
                                label: 'About',
                              ),
                            ],
                          ),
                        ),

                        const Spacer(),

                        // Social Links with Glass Effect
                        _buildSocialSection(context),
                        const SizedBox(height: 40),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildProfileSection(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [
                Theme.of(context).primaryColor.withValues(alpha: 0.8),
                Theme.of(context).colorScheme.secondary.withValues(alpha: 0.8),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).primaryColor.withValues(alpha: 0.3),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Container(
            width: 100,
            height: 100,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: AssetImage('images/profile.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        Text(
          'Simen Ostensen',
          style: GoogleFonts.outfit(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.onSurface,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Cloud & DevOps Engineer',
          style: GoogleFonts.outfit(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Theme.of(context).colorScheme.primary,
            letterSpacing: 1.5,
          ),
        ),
      ],
    );
  }

  Widget _buildNavItem(
    BuildContext context, {
    required int index,
    required IconData icon,
    required String label,
  }) {
    final isSelected = selectedIndex == index;

    return RepaintBoundary(
      // Optimize animations
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        decoration: BoxDecoration(
          color: isSelected
              ? Theme.of(context).primaryColor.withValues(alpha: 0.15)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Material(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(16),
          child: InkWell(
            onTap: () => onDestinationSelected(index),
            borderRadius: BorderRadius.circular(16),
            hoverColor: Theme.of(
              context,
            ).colorScheme.onSurface.withValues(alpha: 0.05),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Row(
                children: [
                  FaIcon(
                    icon,
                    size: 20,
                    color: isSelected
                        ? Theme.of(context).primaryColor
                        : Theme.of(
                            context,
                          ).colorScheme.onSurface.withValues(alpha: 0.6),
                  ),
                  const SizedBox(width: 16),
                  Text(
                    label,
                    style: GoogleFonts.outfit(
                      fontSize: 16,
                      fontWeight: isSelected
                          ? FontWeight.w600
                          : FontWeight.w500,
                      color: isSelected
                          ? Theme.of(context).colorScheme.onSurface
                          : Theme.of(
                              context,
                            ).colorScheme.onSurface.withValues(alpha: 0.7),
                    ),
                  ),
                  const Spacer(),
                  if (isSelected)
                    Container(
                      width: 6,
                      height: 6,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.secondary,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Theme.of(
                              context,
                            ).colorScheme.secondary.withValues(alpha: 0.5),
                            blurRadius: 6,
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSocialSection(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildSocialIcon(
          context,
          FontAwesomeIcons.github,
          'https://github.com/SimenWO',
        ),
        // const SizedBox(width: 12),
        // _buildSocialIcon(
        //   context,
        //   FontAwesomeIcons.twitter,
        //   'https://twitter.com',
        // ),
        const SizedBox(width: 12),
        _buildSocialIcon(
          context,
          FontAwesomeIcons.linkedin,
          'https://linkedin.com/in/simen-østensen-577117122/',
        ),
      ],
    );
  }

  Widget _buildSocialIcon(BuildContext context, IconData icon, String url) {
    return IconButton(
      onPressed: () async {
        final uri = Uri.parse(url);
        if (await canLaunchUrl(uri)) {
          await launchUrl(uri);
        }
      },
      icon: FaIcon(
        icon,
        size: 20,
        color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.5),
      ),
      style: IconButton.styleFrom(
        hoverColor: Theme.of(context).primaryColor.withValues(alpha: 0.1),
        highlightColor: Theme.of(context).primaryColor.withValues(alpha: 0.2),
      ),
    );
  }
}
