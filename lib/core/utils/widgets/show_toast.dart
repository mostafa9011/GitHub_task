import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum ToastType { success, error, warning }

OverlayEntry? _currentToast;

void showToast({
  required BuildContext context,
  required ToastType type,
  required String message,
}) {
  final overlayState = Overlay.of(context, rootOverlay: true);

  // Remove previous toast if present
  _currentToast?.remove();
  _currentToast = null;

  final overlayEntry = OverlayEntry(
    builder: (context) => _ToastWidget(
      message: message,
      type: type,
    ),
  );

  _currentToast = overlayEntry;
  overlayState.insert(overlayEntry);

  // Auto dismiss
  Future.delayed(const Duration(seconds: 2), () {
    _currentToast?.remove();
    _currentToast = null;
  });
}

class _ToastWidget extends StatefulWidget {
  final String message;
  final ToastType type;

  const _ToastWidget({
    required this.message,
    required this.type,
  });

  @override
  State<_ToastWidget> createState() => _ToastWidgetState();
}

class _ToastWidgetState extends State<_ToastWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;
  late Color _bgColor;

  @override
  void initState() {
    super.initState();

    // Slide animation
    _controller = AnimationController(
      duration: const Duration(milliseconds: 550),
      vsync: this,
    );

    _animation = Tween<Offset>(
      begin: widget.type == ToastType.error || widget.type == ToastType.warning
          ? const Offset(0, -2.5)
          : const Offset(1.5, 0),
      end: const Offset(0, 0),
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOutBack,
      ),
    );

    // Set background color clearly visible
    switch (widget.type) {
      case ToastType.success:
        _bgColor = Colors.green;
        break;
      case ToastType.error:
        _bgColor = Colors.red;
        break;
      case ToastType.warning:
        _bgColor = Colors.amber;
        break;
    }

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: (MediaQuery.of(context).padding.top + 100).h,
      left: 16.w,
      right: 16.w,
      child: SlideTransition(
        position: _animation,
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 18.w),
            decoration: BoxDecoration(
              color: _bgColor,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              children: [
                Icon(
                  widget.type == ToastType.success
                      ? Icons.check_circle
                      : widget.type == ToastType.error
                          ? Icons.error
                          : Icons.warning,
                  color: Colors.white, // Always visible
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: Text(
                    widget.message,
                    style: TextStyle(
                      fontSize: 15.sp,
                      color: Colors.white, // Always visible
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
