import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(1.0),
            child: Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: Colors.grey[100],
              ),
              child: Center(
                child: SvgPicture.asset(
                  "assets/img/jobkar.svg",
                  color: const Color(0xFF0071FF),
                  height: 30,
                  width: 30,
                ),
              ),
            ),
          ),
          const Positioned(
            top: 0,
            bottom: 0,
            left: 0,
            right: 0,
            child: CircularProgressIndicator(
              color: Color(0xFF0071FF),
              strokeWidth: 2.5,
            ),
          ),
        ],
      ),
    );
  }
}
