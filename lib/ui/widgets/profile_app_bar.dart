import 'package:flutter/material.dart';
import 'package:task_manager_new/ui/controllers/auth_controller.dart';
import 'package:task_manager_new/ui/screens/auths/sign_in_screen.dart';
import 'package:task_manager_new/ui/screens/update_profile_screen.dart';

import '../utility/app_colors.dart';



AppBar profileAppBar(context,[ bool fromUpdateProfile = false]) {
  return AppBar(
    backgroundColor: AppColors.themeColor,
    leading:  GestureDetector(
      onTap: () {
        if(fromUpdateProfile){
          return;
        }
        Navigator.push(context, MaterialPageRoute(builder: (context) => const UpdateProfileScreen()));
      },
      child: const Padding(
        padding: EdgeInsets.all(8.0),
        child: CircleAvatar(),
      ),
    ),
    title: GestureDetector(
      onTap: () {
        if(fromUpdateProfile){
          return;

}
        Navigator.push(context, MaterialPageRoute(builder: (context) => const UpdateProfileScreen()));
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text( AuthController.userData?.fullName ?? '', style: const TextStyle(
            fontSize: 14,
            color: Colors.white,
          ),),
          Text(AuthController.userData?.email ?? '', style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),),
        ],
      ),
    ),
    actions: [
      IconButton(onPressed: () async{
        await AuthController.clearAllData();
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const SignInScreen()), (route) => false);
      }, icon: const Icon(Icons.logout))
    ],
  );
}