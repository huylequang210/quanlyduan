import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quanlydetai/utils/custom_colors.dart';
import 'package:quanlydetai/screens/editScreen.dart';
import 'package:quanlydetai/utils/database.dart';

class DbItemList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Database.readItems(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        } else if (snapshot.hasData || snapshot.data != null) {
          return ListView.separated(
            separatorBuilder: (context, index) => SizedBox(height: 16.0),
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var deTai =
                  snapshot.data!.docs[index].data() as Map<String, dynamic>;
              String docID = snapshot.data!.docs[index].id;
              String title = deTai['title'];
              String description = deTai['description'];
              String student = deTai['student'];

              return Ink(
                decoration: BoxDecoration(
                  color: MyColor.myWhite.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: ListTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => DbEditScreen(
                        currentTitle: title,
                        currentDescription: description,
                        currentStudent: student,
                        documentId: docID,
                      ),
                    ),
                  ),
                  title: Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(student, maxLines: 1, overflow: TextOverflow.ellipsis),
                      Text(description, maxLines: 1, overflow: TextOverflow.ellipsis)
                    ],
                  ),
                ),
              );
            },
          );
        }

        return Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(
              MyColor.myBlue,
            ),
          ),
        );
      },
    );
  }
}
