import 'package:flutter/material.dart';

import '../theme/color.dart';

class CustomIconButton extends StatelessWidget {
  CustomIconButton({
    Key? key,
    this.alignment,
    this.height,
    this.width,
    this.padding,
    this.decoration,
    this.child,
    this.onTap,
  }) : super(
          key: key,
        );

  final Alignment? alignment;

  final double? height;

  final double? width;

  final EdgeInsetsGeometry? padding;

  final BoxDecoration? decoration;

  final Widget? child;

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
            alignment: alignment ?? Alignment.center,
            child: iconButtonWidget,
          )
        : iconButtonWidget;
  }

  Widget get iconButtonWidget => SizedBox(
        height: height ?? 0,
        width: width ?? 0,
        child: IconButton(
          padding: EdgeInsets.zero,
          icon: Container(
            height: height ?? 0,
            width: width ?? 0,
            padding: padding ?? EdgeInsets.zero,
            decoration: decoration ??
                BoxDecoration(
                  color: gray50,
                  borderRadius: BorderRadius.circular(200),
                ),
            child: child,
          ),
          onPressed: onTap,
        ),
      );
}

/// Extension on [CustomIconButton] to facilitate inclusion of all types of border style etc
extension IconButtonStyleHelper on CustomIconButton {
  static BoxDecoration get outlineIndigoAD => BoxDecoration(
        color: gray10001,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: indigoA7003d.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 2,
            offset: const Offset(
              0,
              6,
            ),
          ),
        ],
      );

  static BoxDecoration get fillGrayTL12 => BoxDecoration(
        color: gray50,
        borderRadius: BorderRadius.circular(12),
      );
}
