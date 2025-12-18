---
id: 1
title: Building a Flutter Web Portfolio
date: 2024-01-15
summary: How I built this portfolio using Flutter Web and a Bento Grid layout.
tags: [Flutter, Web, Design]
imageUrl: https://images.unsplash.com/photo-1481487484168-9b930d5b7d9d?ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=80
author: Simen Ostensen
authorAvatarUrl: https://randomuser.me/api/portraits/men/1.jpg
---

# Building a Flutter Web Portfolio

Building a portfolio in Flutter Web allows for a highly interactive and unique experience that stands out from standard HTML/CSS sites.

## The Design

I chose a **Bento Grid** layout because it offers a flexible way to showcase different types of content—from projects to blog posts—in a cohesive grid.

### Key Components

- **Glassmorphism**: Using `BackdropFilter` to create depth.
- **ResponsiveLayout**: A custom widget that adapts between desktop and mobile.
- **Animated Sidebar**: A persistent navigation rail that feels premium.

## Code Snippet

Here is how I implemented the glass effect:

```dart
ClipRect(
  child: BackdropFilter(
    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
    child: Container(
      color: Colors.white.withOpacity(0.1),
      child: child,
    ),
  ),
)
```
