import 'package:flutter/material.dart';
import 'package:stack_app/model/user.dart';
import 'package:stacked/stacked.dart';

import 'users_viewmodel.dart';

class UsersView extends StackedView<UsersViewModel> {
  const UsersView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    UsersViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder<List<User>>(
          future: viewModel.users,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 20),
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  User user = snapshot.data![index];
                  return Padding(
                    padding: const EdgeInsets.all(5),
                    child: Container(
                      height: 140,
                      decoration: BoxDecoration(border: Border.all()),
                      child: ListTile(
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(user.id.toString()),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(user.name),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(viewModel.getAddressAll(user)),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  user.email,
                                  style: TextStyle(fontSize: 14),
                                ),
                                Text(
                                  user.phone,
                                  style: TextStyle(fontSize: 14),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Center(child: Text(snapshot.error.toString()));
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }

  @override
  UsersViewModel viewModelBuilder(BuildContext context) => UsersViewModel();
}
