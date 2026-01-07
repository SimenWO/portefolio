import 'package:flutter/services.dart';
import 'package:markdown/markdown.dart';
import 'package:yaml/yaml.dart';
import 'package:portifolio/models/blog_post.dart';
import 'package:portifolio/repositories/blog_repository.dart';

class FileBlogRepository implements BlogRepository {
  @override
  Future<List<BlogPost>> getBlogPosts() async {
    final AssetManifest assetManifest = await AssetManifest.loadFromAssetBundle(
      rootBundle,
    );
    final List<String> assets = assetManifest.listAssets();

    final postPaths = assets
        .where(
          (String key) =>
              key.startsWith('assets/posts/') && key.endsWith('.md'),
        )
        .toList();

    List<BlogPost> posts = [];

    for (final path in postPaths) {
      final String content = await rootBundle.loadString(path);
      final BlogPost? post = _parseBlogPost(content);
      if (post != null) {
        posts.add(post);
      }
    }

    // Sort by date descending
    posts.sort((a, b) => b.date.compareTo(a.date));
    return posts;
  }

  @override
  Future<BlogPost?> getBlogPost(String id) async {
    final posts = await getBlogPosts();
    try {
      return posts.firstWhere((post) => post.id == id);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<List<BlogPost>> getFeaturedPosts() async {
    final posts = await getBlogPosts();
    return posts.take(2).toList();
  }

  BlogPost? _parseBlogPost(String fileContent) {
    try {
      // Split frontmatter and content
      // Frontmatter is between first two --- lines
      final RegExp frontmatterRegex = RegExp(
        r'^---\n(.*?)\n---',
        multiLine: true,
        dotAll: true,
      );
      final Match? match = frontmatterRegex.firstMatch(fileContent);

      if (match == null) return null;

      final String frontmatterString = match.group(1)!;
      final String markdownBody = fileContent.substring(match.end).trim();

      // Parse YAML
      final YamlMap yaml = loadYaml(frontmatterString);

      // Convert Markdown to HTML for the content
      final String htmlContent = markdownToHtml(markdownBody);

      return BlogPost(
        id: yaml['id'].toString(),
        title: yaml['title'] as String,
        date: DateTime.parse(yaml['date'].toString()),
        summary: yaml['summary'] as String,
        content: htmlContent,
        imageUrl: yaml['imageUrl'] as String,
        tags: List<String>.from(yaml['tags'] as List),
        author: yaml['author'] as String,
        authorAvatarUrl: yaml['authorAvatarUrl'] as String,
      );
    } catch (e) {
      // ignore: avoid_print
      print('Error parsing blog post: $e');
      return null;
    }
  }
}
