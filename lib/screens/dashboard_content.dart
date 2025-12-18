import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portifolio/models/blog_post.dart';
import 'package:portifolio/repositories/blog_repository.dart';
import 'package:portifolio/widgets/glass_card.dart';

class DashboardContent extends StatelessWidget {
  final Function(BlogPost) onPostSelected;

  const DashboardContent({Key? key, required this.onPostSelected})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome Back',
              style: GoogleFonts.outfit(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Here is what\'s happening in your world.',
              style: GoogleFonts.outfit(
                fontSize: 16,
                color: Theme.of(
                  context,
                ).colorScheme.onSurface.withValues(alpha: 0.7),
              ),
            ),
            const SizedBox(height: 32),
            FutureBuilder<List<BlogPost>>(
              future: Provider.of<BlogRepository>(
                context,
                listen: false,
              ).getBlogPosts(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }
                final posts = snapshot.data ?? [];

                // Determine column count based on width
                final width = MediaQuery.of(context).size.width;
                // Use 2 columns on mobile to allow 50% width items (like stats),
                // but extend larger items to full width.
                final crossAxisCount = width < 900 ? 2 : 4;
                final isMobile = width < 600;
                final isTablet = width >= 600 && width < 900;

                // Bento Grid Layout
                return StaggeredGrid.count(
                  crossAxisCount: crossAxisCount,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  children: [
                    // Large Featured Item
                    if (posts.isNotEmpty)
                      StaggeredGridTile.count(
                        crossAxisCellCount: isMobile || isTablet ? 2 : 2,
                        // On mobile/tablet, make it rectangular (1.2) instead of square (2.0)
                        // so it doesn't take up the huge vertical space.
                        mainAxisCellCount: isMobile || isTablet ? 1.2 : 2,
                        child: _buildFeaturedCard(context, posts[0]),
                      ),

                    // Medium Items
                    if (posts.length > 1)
                      StaggeredGridTile.count(
                        // Full width on mobile, half width on tablet/desktop
                        crossAxisCellCount: isMobile ? 2 : (isTablet ? 1 : 2),
                        mainAxisCellCount: 1,
                        child: _buildPostCard(context, posts[1]),
                      ),
                    if (posts.length > 2)
                      StaggeredGridTile.count(
                        crossAxisCellCount: isMobile ? 2 : 1,
                        mainAxisCellCount: 1,
                        child: _buildPostCard(context, posts[2]),
                      ),
                    if (posts.length > 3)
                      StaggeredGridTile.count(
                        crossAxisCellCount: isMobile ? 2 : 1,
                        mainAxisCellCount: 1,
                        child: _buildPostCard(context, posts[3]),
                      ),

                    // Skill/Stat Cards
                    StaggeredGridTile.count(
                      // Always take 1 cell (so on mobile = 50% width)
                      crossAxisCellCount: 1,
                      mainAxisCellCount: 1,
                      child: _buildStatCard(
                        'Blog Posts',
                        posts.length.toString(),
                        Colors.blueAccent,
                        context,
                      ),
                    ),
                    StaggeredGridTile.count(
                      crossAxisCellCount: 1,
                      mainAxisCellCount: 1,
                      child: _buildStatCard(
                        'Experience',
                        '5 Years',
                        Colors.purpleAccent,
                        context,
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeaturedCard(BuildContext context, BlogPost post) {
    return GlassCard(
      onTap: () => onPostSelected(post),
      padding: EdgeInsets.zero,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(post.imageUrl, fit: BoxFit.cover),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.black.withValues(alpha: 0.8),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    'FEATURED',
                    style: GoogleFonts.outfit(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  post.title,
                  style: GoogleFonts.outfit(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  post.summary,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.outfit(
                    fontSize: 14,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPostCard(BuildContext context, BlogPost post) {
    return GlassCard(
      onTap: () => onPostSelected(post),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            post.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.outfit(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            post.summary,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.outfit(
              fontSize: 12,
              color: Theme.of(
                context,
              ).colorScheme.onSurface.withValues(alpha: 0.6),
            ),
          ),
          const Spacer(),
          Row(
            children: [
              CircleAvatar(
                radius: 10,
                backgroundImage: NetworkImage(post.authorAvatarUrl),
              ),
              const SizedBox(width: 8),
              Text(
                post.author,
                style: GoogleFonts.outfit(
                  fontSize: 10,
                  color: Theme.of(
                    context,
                  ).colorScheme.onSurface.withValues(alpha: 0.5),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(
    String title,
    String value,
    Color color,
    BuildContext context,
  ) {
    return GlassCard(
      color: color.withAlpha(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            value,
            style: GoogleFonts.outfit(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: GoogleFonts.outfit(
              fontSize: 14,
              color: Theme.of(
                context,
              ).colorScheme.onSurface.withValues(alpha: 0.9),
            ),
          ),
        ],
      ),
    );
  }
}
