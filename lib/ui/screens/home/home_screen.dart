import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:notes_app/ui/screens/add_note/add_note_screen.dart';
import 'package:notes_app/ui/screens/home/home_view_model.dart';
import 'package:provider/provider.dart';

import '../../../core/color.dart';
import '../../../core/style.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => HomeViewModel(),
        child: Consumer<HomeViewModel>(
          builder: (context, model, child) {
            return Scaffold(
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  Get.to(AddNoteScreen());
                  model.getNotes();
                },
                elevation: 5,
                child: const Icon(Icons.add),
              ),
              appBar: AppBar(
                  centerTitle: true,
                  title: RichText(
                      text: TextSpan(children: [
                    TextSpan(
                        text: "Hi ",
                        style: bodyTextStyle.copyWith(fontSize: 18)),
                    TextSpan(
                        text: '${model.appUser.name}',
                        style: bodyTextStyle.copyWith(
                            color: kWhiteColor, fontSize: 18)),
                    TextSpan(
                        text: model.hours <= 9
                            ? "Good Morrning"
                            : model.hours > 9 && model.hours <= 17
                                ? " Good Evening"
                                : model.hours > 17 && model.hours <= 24
                                    ? "Good Night"
                                    : "",
                        style: bodyTextStyle.copyWith(fontSize: 18)),
                  ])),
                  actions: [
                    DropdownButton(
                        underline: Container(),
                        icon: const Icon(Icons.more_vert, color: Colors.white),
                        items: const [
                          DropdownMenuItem(
                            value: "logout",
                            child: Text("Log out"),
                          ),
                          DropdownMenuItem(
                              value: "clearall", child: Text("Clear all")),
                        ],
                        onChanged: (value) {
                          model.changeValue(value);
                        })
                  ]),
              body: model.notes.isEmpty
                  ? GestureDetector(
                      onTap: () {
                        model.getNotes();
                      },
                      child: Center(
                        child: RichText(
                            text: TextSpan(children: [
                          TextSpan(
                              text: '${model.appUser.name}!',
                              style: bodyTextStyle.copyWith(
                                  fontSize: 18, fontWeight: FontWeight.w600)),
                          TextSpan(
                              text: " You Don't have any Notes",
                              style: bodyTextStyle.copyWith(fontSize: 18)),
                        ])),
                      ),
                    )
                  : Column(
                      children: [
                        // upperBodySection(model),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: SizedBox(
                              child: RefreshIndicator(
                                  onRefresh: () => model.getNotes(),
                                  child: gridView(context, model))),
                        ),
                      ],
                    ),
            );
          },
        ));
  }
}

Widget gridView(BuildContext context, HomeViewModel model) {
  return MasonryGridView.count(
      shrinkWrap: true,
      crossAxisCount: 2,
      itemCount: model.notes.length,
      itemBuilder: (context, index) {
        return ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Card(
              color: Colors.purple.shade200,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 12),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          model.notes[index].tital!,
                          style: headingTextStyle,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          model.notes[index].description!,
                          style: bodyTextStyle,
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 10, bottom: 5),
                      child: Text(
                        model.notes[index].regDateTime!.toString(),
                        style: bodyTextStyle.copyWith(
                            fontSize: 10, color: kWhiteColor),
                      ),
                    ),
                  ),
                ],
              ),
            ));
      });
}
