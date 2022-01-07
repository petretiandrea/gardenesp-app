import 'package:flutter/material.dart';

class RefreshButton extends StatefulWidget {
  final bool isLoading;
  final double? size;
  final Color color;
  final void Function() onClick;

  const RefreshButton({
    Key? key,
    required this.onClick,
    this.isLoading = false,
    this.size = 15,
    this.color = Colors.white,
  }) : super(key: key);

  @override
  State<RefreshButton> createState() => _RefreshButtonState();
}

class _RefreshButtonState extends State<RefreshButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1))
          ..repeat(reverse: false);
    _animation =
        CurvedAnimation(parent: _animationController, curve: Curves.linear);
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (this.widget.isLoading) {
      return Padding(
        padding: const EdgeInsets.all(8),
        child: RotationTransition(
          turns: _animation,
          child: Icon(
            Icons.sync,
            size: widget.size,
            color: widget.color,
          ),
        ),
      );
    } else {
      return InkWell(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Icon(
            Icons.sync,
            size: widget.size,
            color: widget.color,
          ),
        ),
        customBorder: const CircleBorder(),
        onTap: widget.onClick,
      );
    }
  }
}
