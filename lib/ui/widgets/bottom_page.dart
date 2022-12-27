import 'package:flutter/material.dart';

import '../general/colors.dart';

class ButtomNormalWidget extends StatelessWidget {
  Function onPressed;

  ButtomNormalWidget({
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
              height: 52.0,
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  onPressed();
                }, 
                style: ElevatedButton.styleFrom(
                  primary: kBrandPrimaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14.0),
                  )
                ),
                icon: Icon(Icons.save), 
                label: Text("Guardar",style: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
                ),),
            );
  }
}