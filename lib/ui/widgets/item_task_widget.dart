import 'package:firetasks/models/task_model.dart';
import 'package:firetasks/services/my_service_firestore.dart';
import 'package:firetasks/ui/widgets/item_category_widget.dart';
import 'package:flutter/material.dart';
import '../general/colors.dart';
import 'general_widget.dart';

class ItemTaskWidget extends StatelessWidget {
  TaskModel taskModel;

  ItemTaskWidget({required this.taskModel});

  final MyServiceFirestore _myServiceFirestore=MyServiceFirestore(collection: "tasks");

  ShowFinishDialog(BuildContext context){
    showDialog(
      context: context, 
      builder: (BuildContext context) {
        return AlertDialog(
          shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)) ,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Finalizar tarea",style: TextStyle(
                color: kBrandPrimaryColor.withOpacity(0.87),
                fontWeight: FontWeight.w600,
              ),),
            divider6(),
              Text("¿Estas seguro de finalizar la tarea?",style: TextStyle(
                color: kBrandPrimaryColor.withOpacity(0.87),
                fontWeight: FontWeight.w400,
                fontSize: 13.0,
              ),),
            divider10(),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                TextButton(
                  onPressed:() {
                    Navigator.pop(context);
                  }, 
                  child:Text("Cancelar",style: TextStyle(
                color: kBrandPrimaryColor.withOpacity(0.5),
                fontWeight: FontWeight.w400,
                fontSize: 14.0,
              ),),),
            divider10W(),
              ElevatedButton(
                onPressed: () {
                  _myServiceFirestore.finishTask(taskModel.id!);
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  primary: kBrandPrimaryColor,
                  shape:  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14.0),
                  )
                ),
                child: Text("Finalizar"),),
              ],)
            ],
          ),
        );
      });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
            padding:const EdgeInsets.symmetric(horizontal: 14.0,vertical: 16.0),
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                offset: const Offset(4, 4),
                blurRadius: 12.0,
              ),
            ]

            ),
          child: Stack(
            children: [
                Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ItemCategoriaWidget(
                    text:taskModel.category),
                  divider3(),
                  Text(taskModel.title,style: TextStyle(
                    decoration: taskModel.status? TextDecoration.none:TextDecoration.lineThrough ,
                    fontSize: 15.0,
                    fontWeight: FontWeight.w600,
                    color: kBrandPrimaryColor.withOpacity(0.85),
                  ),),
                  Text(taskModel.description,style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w400,
                    color: kBrandPrimaryColor.withOpacity(0.7),
                  ),),
                  divider6(),
                  Text(taskModel.date,style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w400,
                    color: kBrandPrimaryColor.withOpacity(0.7),
                  ),),
          
                ],
              ),
              Positioned(
                top: -10,
                right: -12,
                child: PopupMenuButton(
                  onSelected: (value) {
                    if(value==2){
                      //
                    ShowFinishDialog(context);
                    }
                  },
                  elevation: 2,
                  color: Colors.white,
                  icon: Icon(Icons.more_vert, color: kBrandPrimaryColor.withOpacity(0.85),),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14.0)
                  ),
                  itemBuilder: (BuildContext context){
                  return [
                    PopupMenuItem(
                      value: 1,
                      child: Text("Editar",style: TextStyle(
                      fontSize: 13.0,
                      color: kBrandPrimaryColor.withOpacity(0.85),
                    ),),),
                    PopupMenuItem(
                      value: 2,
                      child: Text("Finalizar",style: TextStyle(
                      fontSize: 13.0,
                      color: kBrandPrimaryColor.withOpacity(0.85),
                    ),),),
                    ];
                  }),
              ),

            ],
          ),
          );
  }
}