import 'package:flutter/material.dart';
import 'package:portifolio/layout/responsive_layout.dart';
import 'package:portifolio/models/blog_post.dart';
import 'package:portifolio/screens/blog_list_screen.dart';
import 'package:portifolio/screens/blog_post_screen.dart';
import 'package:portifolio/screens/about_screen.dart';
import 'package:portifolio/screens/dashboard_content.dart';

import 'package:portifolio/widgets/sidebar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  BlogPost? _selectedPost;

  void _handleDestinationSelected(int index) {
    setState(() {
      _selectedIndex = index;
      _selectedPost = null; // Clear selected post when changing sections
    });

    // Close drawer on mobile
    if (!ResponsiveLayout.isDesktop(context)) {
      Navigator.maybePop(context);
    }
  }

  void _handlePostSelected(BlogPost post) {
    setState(() {
      _selectedPost = post;
    });
  }

  void _handleBack() {
    setState(() {
      _selectedPost = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: _selectedPost == null,
      onPopInvoked: (didPop) {
        if (didPop) return;
        _handleBack();
      },
      child: ResponsiveLayout(
        sidebar: Sidebar(
          selectedIndex: _selectedIndex,
          onDestinationSelected: _handleDestinationSelected,
        ),
        content: AnimatedSwitcher(
          duration: const Duration(milliseconds: 600),
          switchInCurve: Curves.easeOutQuart,
          switchOutCurve: Curves.easeInQuad,
          transitionBuilder: (Widget child, Animation<double> animation) {
            return FadeTransition(
              opacity: animation,
              child: ScaleTransition(
                scale: Tween<double>(begin: 0.95, end: 1.0).animate(animation),
                child: child,
              ),
            );
          },
          child: _buildContent(),
        ),
      ),
    );
  }

  Widget _buildContent() {
    if (_selectedPost != null) {
      return BlogPostContent(
        key: ValueKey('post_${_selectedPost!.title}'),
        post: _selectedPost!,
        onBack: _handleBack,
      );
    }

    switch (_selectedIndex) {
      case 0:
        return DashboardContent(
          key: const ValueKey('dashboard'),
          onPostSelected: _handlePostSelected,
        );
      case 1:
        return BlogListScreen(
          key: const ValueKey('blog_list'),
          onPostSelected: _handlePostSelected,
        );
      case 2:
        return AboutScreen(key: const ValueKey('about'));
      default:
        return DashboardContent(
          key: const ValueKey('dashboard'),
          onPostSelected: _handlePostSelected,
        );
    }
  }
}
