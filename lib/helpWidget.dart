import 'package:flutter/material.dart';

class helpaWem
{

  getTestFieldVa(TextEditingController controller,Function chagesMethod)
  {
    return  TextField(
    controller: controller,
    onChanged: (values)
  {
    chagesMethod(values);
  print("call onChanged");
  },

  );
}
}
