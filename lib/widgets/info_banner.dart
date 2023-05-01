import "package:flutter/material.dart";

import "../common/colors.dart";

class InfoBanner extends StatelessWidget {
  final String text;
  final IconData icon;
  const InfoBanner(this.text, this.icon, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 16),
            
            decoration: BoxDecoration(
              color: AppColor.lightPrimary,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  size: 30,
                  color: AppColor.accent,
                ),
                Text(
                  text,
                  overflow: TextOverflow.clip,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
