import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/task_model.dart';

class MyServiceFirestore{
String collection;
MyServiceFirestore({required this.collection});

late final CollectionReference _collectionReference=FirebaseFirestore.instance.collection(collection);

//add
Future<String> addtask(TaskModel model) async{
 DocumentReference documentReference= await _collectionReference.add(model.toJson());
 String id=documentReference.id;
 return id;
}

Future<void> finishTask(String taskId)async{
  await _collectionReference.doc(taskId)
  .update({
    "status":false,
  });
}

//delete

//update

}