import 'package:flutter/cupertino.dart';


class TRoundedContainer extends StatelessWidget {
  const TRoundedContainer(
      {super.key,
        this.height,
        this.width,
        this.radius = 16,
        this.child,
        this.showBorder = false,
        this.borderColor = const Color(0xFFD9D9D9),
        this.backgroundColor = const Color(0xFFB71C1C),
        this.padding,
        this.margin,
      });

  final double? height;
  final double? width;
  final double radius;
  final Widget? child;
  final bool showBorder;
  final Color borderColor;
  final Color backgroundColor;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: padding,
      margin: margin,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(radius),
        border: showBorder ? Border.all(color: borderColor) : null,
      ),
      child: child,
    );
  }
}
