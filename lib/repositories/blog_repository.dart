import 'package:portifolio/models/blog_post.dart';

abstract class BlogRepository {
  Future<List<BlogPost>> getBlogPosts();
  Future<BlogPost?> getBlogPost(String id);
  Future<List<BlogPost>> getFeaturedPosts();
}
