class BlogPost {
  final String id;
  final String title;
  final String summary;
  final String content; // Can be HTML or Rich Text representation
  final DateTime date;
  final String imageUrl;
  final List<String> tags;
  final String author;
  final String authorAvatarUrl;

  BlogPost({
    required this.id,
    required this.title,
    required this.summary,
    required this.content,
    required this.date,
    required this.imageUrl,
    required this.tags,
    required this.author,
    required this.authorAvatarUrl,
  });

  // Factory for JSON deserialization (prepared for API)
  factory BlogPost.fromJson(Map<String, dynamic> json) {
    return BlogPost(
      id: json['id'] as String,
      title: json['title'] as String,
      summary: json['summary'] as String,
      content: json['content'] as String,
      date: DateTime.parse(json['date'] as String),
      imageUrl: json['imageUrl'] as String,
      tags: List<String>.from(json['tags'] as List),
      author: json['author'] as String,
      authorAvatarUrl: json['authorAvatarUrl'] as String,
    );
  }
}
