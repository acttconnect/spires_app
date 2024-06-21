import '../Constants/exports.dart';

class MyContainer extends StatelessWidget {
  final Widget? child;
  final Color? color;
  final double? height;
  final double? width;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  const MyContainer(
      {super.key,
      this.child,
      this.color,
      this.height,
      this.width,
      this.margin,
      this.padding});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      padding: padding,
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        color: color ?? whiteColor,
      ),
      child: child,
    );
  }
}
