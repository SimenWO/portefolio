import 'dart:ui';
import 'package:flutter/material.dart';

class GlassCard extends StatefulWidget {
  final Widget child;
  final double blur;
  final double opacity;
  final Color color;
  final BorderRadius? borderRadius;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final VoidCallback? onTap;

  const GlassCard({
    Key? key,
    required this.child,
    this.blur = 10.0,
    this.opacity = 0.7,
    this.color = Colors.white,
    this.borderRadius,
    this.padding,
    this.margin,
    this.onTap,
  }) : super(key: key);

  @override
  State<GlassCard> createState() => _GlassCardState();
}

class _GlassCardState extends State<GlassCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final BorderRadius effectiveBorderRadius =
        widget.borderRadius ?? BorderRadius.circular(16.0);
    final bool isClickable = widget.onTap != null;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: isClickable ? SystemMouseCursors.click : SystemMouseCursors.basic,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedScale(
          scale: _isHovered && isClickable ? 1.02 : 1.0,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOutCubic,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            margin: widget.margin,
            decoration: BoxDecoration(
              borderRadius: effectiveBorderRadius,
              border: Border.all(
                color: Colors.white.withValues(
                  alpha: _isHovered && isClickable ? 0.9 : 0.6,
                ),
                width: 1.5,
              ),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  widget.color.withValues(alpha: widget.opacity),
                  widget.color.withValues(alpha: widget.opacity * 0.5),
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(
                    alpha: _isHovered && isClickable ? 0.2 : 0.1,
                  ),
                  blurRadius: _isHovered && isClickable ? 25 : 16,
                  spreadRadius: _isHovered && isClickable ? 4 : 2,
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: effectiveBorderRadius,
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: widget.blur,
                  sigmaY: widget.blur,
                ),
                child: Padding(
                  padding: widget.padding ?? const EdgeInsets.all(16.0),
                  child: widget.child,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
