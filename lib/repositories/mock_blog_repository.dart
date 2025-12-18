import 'package:portifolio/models/blog_post.dart';
import 'package:portifolio/repositories/blog_repository.dart';

class MockBlogRepository implements BlogRepository {
  final List<BlogPost> _posts = [
    BlogPost(
      id: '1',
      title: 'Building a Flutter Web Portfolio',
      summary:
          'How I built this portfolio using Flutter Web and a Bento Grid layout.',
      content:
          '<p>This is the detailed content of the first blog post. It discusses the architecture and design choices.</p>',
      date: DateTime.now().subtract(const Duration(days: 2)),
      imageUrl:
          'https://images.unsplash.com/photo-1481487484168-9b930d5b7d9d?ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=80',
      tags: ['Flutter', 'Web', 'Design'],
      author: 'Simen Ostensen',
      authorAvatarUrl: 'https://randomuser.me/api/portraits/men/1.jpg',
    ),
    BlogPost(
      id: '2',
      title: 'The Future of Dart',
      summary:
          'Exploring the new features in Dart 3 and what they mean for Flutter developers.',
      content:
          '<p>Dart 3 introduces records, patterns, and class modifiers. Let\'s dive deep into these features.</p>',
      date: DateTime.now().subtract(const Duration(days: 5)),
      imageUrl:
          'https://images.unsplash.com/photo-1555099962-4199c345e5dd?ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=80',
      tags: ['Dart', 'Programming'],
      author: 'Simen Ostensen',
      authorAvatarUrl: 'https://randomuser.me/api/portraits/men/1.jpg',
    ),
    BlogPost(
      id: '3',
      title: 'Glassmorphism in UI Design',
      summary:
          'Why glassmorphism is trending and how to implement it effectively.',
      content:
          '<p>Glassmorphism creates a sense of depth and hierarchy. It works best with colorful backgrounds.</p>',
      date: DateTime.now().subtract(const Duration(days: 10)),
      imageUrl:
          'https://images.unsplash.com/photo-1550684848-fac1c5b4e853?ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=80',
      tags: ['Design', 'UI/UX'],
      author: 'Simen Ostensen',
      authorAvatarUrl: 'https://randomuser.me/api/portraits/men/1.jpg',
    ),
    BlogPost(
      id: '4',
      title: 'State Management Battles',
      summary: 'Provider vs Riverpod vs Bloc. Which one should you choose?',
      content:
          '<p>Choosing a state management solution depends on the complexity of your app and your team\'s preference.</p>',
      date: DateTime.now().subtract(const Duration(days: 15)),
      imageUrl:
          'https://images.unsplash.com/photo-1551288049-bebda4e38f71?ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=80',
      tags: ['Flutter', 'State Management'],
      author: 'Simen Ostensen',
      authorAvatarUrl: 'https://randomuser.me/api/portraits/men/1.jpg',
    ),
  ];

  @override
  Future<List<BlogPost>> getBlogPosts() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 800));
    return _posts;
  }

  @override
  Future<BlogPost?> getBlogPost(String id) async {
    await Future.delayed(const Duration(milliseconds: 500));
    try {
      return _posts.firstWhere((post) => post.id == id);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<List<BlogPost>> getFeaturedPosts() async {
    await Future.delayed(const Duration(milliseconds: 600));
    return _posts.take(2).toList();
  }
}
