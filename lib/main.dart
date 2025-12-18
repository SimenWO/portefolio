import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:portifolio/repositories/blog_repository.dart';
import 'package:portifolio/repositories/file_blog_repository.dart';
import 'package:portifolio/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<BlogRepository>(create: (_) => FileBlogRepository()),
      ],
      child: MaterialApp(
        title: 'Simen Ostensen Portfolio',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          brightness: Brightness.light,
          scaffoldBackgroundColor: const Color(
            0xFFF5F5F7,
          ), // Soft light background
          primaryColor: const Color(0xFF6C63FF), // Example accent
          colorScheme: const ColorScheme.light(
            primary: Color(0xFF6C63FF),
            secondary: Color(0xFF03DAC6),
            surface: Colors.white,
            background: Color(0xFFF5F5F7),
          ),
          textTheme: GoogleFonts.outfitTextTheme(ThemeData.light().textTheme),
          useMaterial3: true,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
