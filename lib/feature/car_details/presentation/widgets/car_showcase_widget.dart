 
 

import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CarShowcaseWidget extends StatefulWidget {
  final String? carImageUrl;
  final double? width;
  final double? height;
  final Color? backgroundColor;
  final Color? platformColor;
  final Color? glowColor;

  const CarShowcaseWidget({
    super.key,
    this.carImageUrl,
    this.width,
    this.height,
    this.backgroundColor,
    this.platformColor,
    this.glowColor,
  });

  @override
  State<CarShowcaseWidget> createState() => _CarShowcaseWidgetState();
}

class _CarShowcaseWidgetState extends State<CarShowcaseWidget>
    with TickerProviderStateMixin {
  late AnimationController _rotationController;
  late AnimationController _pulseController;
  late AnimationController _floatController;
  late Animation<double> _rotationAnimation;
  late Animation<double> _pulseAnimation;
  late Animation<double> _floatAnimation;

  @override
  void initState() {
    super.initState();

    _rotationController = AnimationController(
      duration: const Duration(seconds: 25),
      vsync: this,
    )..repeat();

    _pulseController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat(reverse: true);

    _floatController = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    )..repeat(reverse: true);

    _rotationAnimation = Tween<double>(begin: 0, end: 2 * math.pi).animate(
      CurvedAnimation(parent: _rotationController, curve: Curves.linear),
    );

    _pulseAnimation = Tween<double>(begin: 0.4, end: 1.0).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    _floatAnimation = Tween<double>(begin: -5, end: 5).animate(
      CurvedAnimation(parent: _floatController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _rotationController.dispose();
    _pulseController.dispose();
    _floatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width ?? 350.w,
      height: widget.height ?? 250.h,
      decoration: BoxDecoration(
        gradient: RadialGradient(
          center: Alignment.center,
          radius: 1.5,
          colors: [
            widget.backgroundColor?.withOpacity(0.8) ?? const Color(0xFF2a2a2a),
            widget.backgroundColor?.withOpacity(0.6) ?? const Color(0xFF1a1a1a),
            widget.backgroundColor ?? const Color(0xFF0a0a0a),
          ],
        ),
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 20,
            spreadRadius: 5,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.r),
        child: Stack(
          alignment: Alignment.center,
          children: [
             
            ...List.generate(15, (index) => _buildParticle(index)),

             
            Positioned(bottom: 30.h, child: _buildPlatform()),

             
            AnimatedBuilder(
              animation: _floatAnimation,
              builder: (context, child) {
                return Positioned(
                  bottom: 80.h + _floatAnimation.value,
                  child: _buildCarWithShadow(),
                );
              },
            ),

             
            _buildLightEffects(),

             
            Positioned(bottom: 20.h, child: _buildReflection()),
          ],
        ),
      ),
    );
  }

  Widget _buildParticle(int index) {
    return AnimatedBuilder(
      animation: _rotationAnimation,
      builder: (context, child) {
        final angle = (_rotationAnimation.value + index * 0.4) % (2 * math.pi);
        final radius = 80.w + (index % 4) * 25.w;
        final x = math.cos(angle) * radius;
        final y = math.sin(angle) * radius * 0.4;

        return Positioned(
          left: (widget.width ?? 350.w) / 2 + x,
          top: (widget.height ?? 250.h) / 2 + y,
          child: Container(
            width: (2 + (index % 3)).w,
            height: (2 + (index % 3)).h,
            decoration: BoxDecoration(
              color: (widget.glowColor ?? Colors.cyan).withOpacity(
                0.1 + (index % 3) * 0.1,
              ),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: (widget.glowColor ?? Colors.cyan).withOpacity(0.4),
                  blurRadius: 8,
                  spreadRadius: 2,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildPlatform() {
    return AnimatedBuilder(
      animation: _pulseAnimation,
      builder: (context, child) {
        return Transform(
          alignment: Alignment.center,
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.001)
            ..rotateX(math.pi / 3.5),
          child: Container(
            width: 280.w,
            height: 180.h,
            decoration: BoxDecoration(
              gradient: RadialGradient(
                center: Alignment.center,
                radius: 1.0,
                colors: [
                  (widget.platformColor ?? Colors.white).withOpacity(
                    0.15 * _pulseAnimation.value,
                  ),
                  (widget.glowColor ?? Colors.cyan).withOpacity(
                    0.08 * _pulseAnimation.value,
                  ),
                  Colors.transparent,
                ],
              ),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: (widget.glowColor ?? Colors.cyan).withOpacity(
                    0.3 * _pulseAnimation.value,
                  ),
                  blurRadius: 40,
                  spreadRadius: 15,
                ),
              ],
            ),
            child: Container(
              margin: EdgeInsets.all(25.w),
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  colors: [
                    (widget.glowColor ?? Colors.cyan).withOpacity(
                      0.15 * _pulseAnimation.value,
                    ),
                    Colors.transparent,
                  ],
                ),
                shape: BoxShape.circle,
                border: Border.all(
                  color: (widget.glowColor ?? Colors.cyan).withOpacity(
                    0.2 * _pulseAnimation.value,
                  ),
                  width: 1,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildCarWithShadow() {
    return Stack(
      alignment: Alignment.center,
      children: [
         
        Transform(
          alignment: Alignment.center,
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.001)
            ..rotateX(math.pi / 2)
            ..scale(1.0, 0.4, 1.0),
          child: Container(
            width: 200.w,
            height: 100.h,
            decoration: BoxDecoration(
              gradient: RadialGradient(
                colors: [
                  Colors.black.withOpacity(0.7),
                  Colors.black.withOpacity(0.4),
                  Colors.transparent,
                ],
              ),
              borderRadius: BorderRadius.circular(100.r),
            ),
          ),
        ),

         
        AnimatedBuilder(
          animation: _rotationAnimation,
          builder: (context, child) {
            return Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()
                ..rotateY(math.sin(_rotationAnimation.value * 0.5) * 0.15),
              child: Container(
                width: 220.w,
                height: 130.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.6),
                      blurRadius: 25,
                      offset: Offset(0, 15.h),
                    ),
                    BoxShadow(
                      color: (widget.glowColor ?? Colors.cyan).withOpacity(0.4),
                      blurRadius: 30,
                      spreadRadius: 8,
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15.r),
                  child: widget.carImageUrl != null
                      ? Image.asset(
                          widget.carImageUrl!,
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) {
                            return _buildCarPlaceholder();
                          },
                        )
                      : _buildCarPlaceholder(),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildCarPlaceholder() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.grey[700]!, Colors.grey[900]!],
        ),
      ),
      child: Icon(
        Icons.directions_car_rounded,
        size: 70.sp,
        color: Colors.white.withOpacity(0.7),
      ),
    );
  }

  Widget _buildLightEffects() {
    return AnimatedBuilder(
      animation: _pulseAnimation,
      builder: (context, child) {
        return Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                center: Alignment.center,
                radius: 1.8,
                colors: [
                  (widget.glowColor ?? Colors.cyan).withOpacity(
                    0.08 * _pulseAnimation.value,
                  ),
                  Colors.transparent,
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildReflection() {
    return AnimatedBuilder(
      animation: _pulseAnimation,
      builder: (context, child) {
        return Transform(
          alignment: Alignment.center,
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.001)
            ..rotateX(math.pi)
            ..scale(1.0, 0.3, 1.0),
          child: Container(
            width: 220.w,
            height: 60.h,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.white.withOpacity(0.05 * _pulseAnimation.value),
                  Colors.transparent,
                ],
              ),
              borderRadius: BorderRadius.circular(15.r),
            ),
            child: widget.carImageUrl != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(15.r),
                    child: Image.asset(
                      widget.carImageUrl!,
                      fit: BoxFit.contain,
                      color: Colors.white.withOpacity(0.08),
                      colorBlendMode: BlendMode.modulate,
                      errorBuilder: (context, error, stackTrace) {
                        return Icon(
                          Icons.directions_car_rounded,
                          size: 35.sp,
                          color: Colors.white.withOpacity(0.05),
                        );
                      },
                    ),
                  )
                : Icon(
                    Icons.directions_car_rounded,
                    size: 35.sp,
                    color: Colors.white.withOpacity(0.05),
                  ),
          ),
        );
      },
    );
  }
}
