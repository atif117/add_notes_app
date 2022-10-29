import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_app/core/color.dart';
import 'package:notes_app/core/style.dart';
import 'package:notes_app/ui/custom_widgets/custom_button.dart';
import 'package:notes_app/ui/custom_widgets/custom_textfield.dart';
import 'package:notes_app/ui/screens/add_note/add_notes_view_model.dart';
import 'package:provider/provider.dart';

class AddNoteScreen extends StatelessWidget {
  AddNoteScreen({super.key});
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AddNotesViewModel(),
      child: Consumer<AddNotesViewModel>(
        builder: (context, model, child) {
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Add your Notes", style: headingTextStyle),
                  const SizedBox(
                    height: 15,
                  ),
                  Form(
                      key: formKey,
                      child: Column(
                        children: [
                          CustomTextField(
                            labelText: 'Tital',
                            onChanged: (value) {
                              model.note.tital = value;
                            },
                            validate: (val) {
                              if (val.isEmpty) {
                                return "Enter Tital";
                              }
                            },
                          ),
                          CustomTextField(
                            labelText: 'Description',
                            onChanged: (value) {
                              model.note.description = value;
                            },
                            validate: (val) {
                              if (val.isEmpty) {
                                return 'Enter discription';
                              }
                            },
                          ),
                        ],
                      )),
                  CustomButton(
                    labelText: "Save",
                    buttonColor: kPrimaryColor,
                    onTap: () {
                      if (formKey.currentState!.validate()) {
                        model.addNotes();

                        Get.back();
                      }
                    },
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
