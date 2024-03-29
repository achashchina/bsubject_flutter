import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:subject_app/widgets/update_user.dart';
import '../service.dart';

import '../models/user_model.dart';

class UserCard extends StatefulWidget {
  @override
  _UserCardState createState() => _UserCardState();
}

class _UserCardState extends State<UserCard> {
  GetIt getIt = GetIt.I;
  User _user;

  @override
  void initState() {
    getIt<UserModel>().userObservable.listen((user) {
      if (this.mounted) {
        setState(() {
          _user = user;
        });
      }
    });
    super.initState();
  }

  update() => setState(() => {});

  @override
  void dispose() {
    getIt<UserModel>().removeListener(update);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return (_user != null) ? buildUserCard() : Text('loading...');
  }

  Widget buildUserCard() {
    handlePopUpChanged() {
      showModalBottomSheet(
        context: context,
        builder: (_) {
          return GestureDetector(
            onTap: () {},
            child: UpdateUser(),
            behavior: HitTestBehavior.opaque,
          );
        },
      );
    }

    return Container(
        child: Card(
      margin: EdgeInsets.all(15),
      elevation: 6,
      child: ListTile(
          leading: CircleAvatar(
            backgroundImage: AssetImage('assets/ava.png'),
            radius: 30,
          ),
          title: Container(
            child: Text(
              '${_user.name}',
              style: Theme.of(context).textTheme.title,
            ),
          ),
          subtitle: Text('Email: ${_user.email}'),
          trailing: GestureDetector(
            child: Icon(Icons.edit),
            onTap: handlePopUpChanged,
          )),
    ));
  }
}
