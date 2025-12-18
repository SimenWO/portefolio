import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portifolio/models/blog_post.dart';

class BlogPostContent extends StatelessWidget {
  final BlogPost post;
  final VoidCallback onBack;

  const BlogPostContent({Key? key, required this.post, required this.onBack})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: CustomScrollView(
            slivers: [
              // Custom app bar with image
              SliverAppBar(
                expandedHeight: 400,
                pinned: true,
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                surfaceTintColor:
                    Colors.transparent, // Disable purple tint on scroll
                leading: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.3),
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: onBack,
                    ),
                  ),
                ),
                flexibleSpace: FlexibleSpaceBar(
                  background: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.network(post.imageUrl, fit: BoxFit.cover),
                      // Gradient overlay for better text contrast if needed (though title is below)
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.black.withValues(alpha: 0.3),
                              Colors.transparent,
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Tags
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: post.tags.map((tag) {
                          return Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: Theme.of(
                                context,
                              ).colorScheme.primary.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: Theme.of(
                                  context,
                                ).colorScheme.primary.withValues(alpha: 0.2),
                              ),
                            ),
                            child: Text(
                              tag,
                              style: GoogleFonts.outfit(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 24),

                      // Title
                      Text(
                        post.title,
                        style: GoogleFonts.outfit(
                          fontSize: 42,
                          fontWeight: FontWeight.bold,
                          height: 1.1,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Author Row
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 20,
                            backgroundImage: NetworkImage(post.authorAvatarUrl),
                          ),
                          const SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                post.author,
                                style: GoogleFonts.outfit(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onSurface,
                                ),
                              ),
                              Text(
                                '${post.date.day} ${monthName(post.date.month)} ${post.date.year}',
                                style: GoogleFonts.outfit(
                                  fontSize: 12,
                                  color: Theme.of(context).colorScheme.onSurface
                                      .withValues(alpha: 0.6),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 40),
                      Divider(
                        color: Theme.of(
                          context,
                        ).colorScheme.onSurface.withValues(alpha: 0.1),
                      ),
                      const SizedBox(height: 40),

                      // HTML Content with Typography
                      HtmlWidget(
                        post.content,
                        textStyle: GoogleFonts.merriweather(
                          // Using a serif font for reading body
                          fontSize: 18,
                          height: 1.8,
                          color: Theme.of(
                            context,
                          ).colorScheme.onSurface.withValues(alpha: 0.9),
                        ),
                        customStylesBuilder: (element) {
                          if (element.localName == 'h1') {
                            return {
                              'font-family': 'Outfit',
                              'font-weight': 'bold',
                              'margin-top': '40px',
                              'margin-bottom': '16px',
                            };
                          }
                          if (element.localName == 'h2') {
                            return {
                              'font-family': 'Outfit',
                              'font-weight': 'bold',
                              'margin-top': '32px',
                              'margin-bottom': '12px',
                            };
                          }
                          if (element.localName == 'code') {
                            return {
                              'font-family': 'Fira Code, monospace',
                              'background-color': '#ffffff10',
                              'padding': '2px 4px',
                              'border-radius': '4px',
                            };
                          }
                          if (element.localName == 'blockquote') {
                            return {
                              'border-left': '4px solid #ffffff40',
                              'padding-left': '16px',
                              'font-style': 'italic',
                              'color': '#ffffff90',
                            };
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 100),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String monthName(int month) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return months[month - 1];
  }
}
