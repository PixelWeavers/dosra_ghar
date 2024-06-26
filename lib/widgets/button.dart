import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class CustomButton extends StatelessWidget {
  final String msg;
  final VoidCallback onTap;
  final bool loading;

  const CustomButton({
    super.key,
    required this.msg,
    required this.onTap,
    this.loading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          // Decoration for the button
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                offset: const Offset(2, 2),
                blurRadius: 4,
              ),
            ],
            color: const Color(0xFF26282F),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(14),
                child: loading
                    ? const CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white,
                )
                    : Text( msg,
                    style: GoogleFonts.lato(color: Colors.white,),
                  
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
