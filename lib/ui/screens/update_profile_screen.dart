import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task_manager_new/ui/controllers/auth_controller.dart';
import 'package:task_manager_new/ui/widgets/background_widgets.dart';
import 'package:task_manager_new/ui/widgets/profile_app_bar.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _firstNameTEController = TextEditingController();
  final TextEditingController _lastNameTEController = TextEditingController();
  final TextEditingController _mobileTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
   XFile ? _selectedImage;

  @override
  void initState() {
    super.initState();
    final userData = AuthController.userData!;
    _emailTEController.text = userData.email ?? '';
    _firstNameTEController.text = userData.firstName ?? '';
    _lastNameTEController.text = userData.lastName ?? '';
    _mobileTEController.text = userData.mobile ?? '';
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: profileAppBar(context, true),
      body: BackgroundWidgets(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(height: 48,),
                  Text('Update Profile', style: Theme.of(context).textTheme.titleLarge,),
                  const SizedBox(height: 24,),
                  buildPhotoPickerWidget(),
                  const SizedBox(height: 8,),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: _emailTEController,
                    decoration: const InputDecoration(
                      hintText: 'Email'
                    ),
                  ),
                  const SizedBox(height: 8,),
                  TextFormField(
                    controller: _firstNameTEController,
                    decoration: const InputDecoration(
                        hintText: 'First Name'
                    ),
                  ),
                  const SizedBox(height: 8,),
                  TextFormField(
                    controller: _lastNameTEController,
                    decoration: const InputDecoration(
                        hintText: 'Last Name'
                    ),
                  ),
                  const SizedBox(height: 8,),
                  TextFormField(
                    keyboardType: TextInputType.phone,
                    controller: _mobileTEController,
                    decoration: const InputDecoration(
                        hintText: 'Mobile Number'
                    ),
                  ),
                  const SizedBox(height: 8,),
                  TextFormField(
                    controller: _passwordTEController,
                    decoration: const InputDecoration(
                        hintText: 'Password'
                    ),
                  ),
                  const SizedBox(height: 16,),
                  ElevatedButton(onPressed: () {}, child: const Icon(Icons.arrow_circle_right_outlined)),
                  const SizedBox(height: 16,)
                ],

              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildPhotoPickerWidget() {
    return GestureDetector(
      onTap: _pickProfileImage,
      child: Container(
                width: double.maxFinite,
                height: 48,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                ),
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    Container(
                      height: 48,
                      width: 100,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8),
                          bottomLeft: Radius.circular(8)
                        ),
                        color: Colors.grey,
                      ),
                      alignment: Alignment.center,
                      child: const Text('Photo', style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),),
                    ),
                    Expanded(child: Text(_selectedImage?.name ?? 'No image selected.', maxLines: 1, style: const TextStyle(
                      overflow: TextOverflow.ellipsis
                    ),))
                  ],
                ),
              ),
    );
  }
  @override
  void dispose() {
    _emailTEController.dispose();
    _firstNameTEController.dispose();
    _lastNameTEController.dispose();
    _mobileTEController.dispose();
    _passwordTEController.dispose();
    super.dispose();
  }
  Future<void> _pickProfileImage() async{
    final imagePicker = ImagePicker();
    final XFile ? result = await imagePicker.pickImage(source: ImageSource.camera);
    if(result != null){
      _selectedImage = result;
      if(mounted){
        setState(() {});
      }

    }

  }
}
