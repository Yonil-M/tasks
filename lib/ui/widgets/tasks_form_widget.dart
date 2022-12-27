
import 'package:firetasks/models/task_model.dart';
import 'package:firetasks/services/my_service_firestore.dart';
import 'package:firetasks/ui/widgets/texField_normalWidget.dart';
import 'package:flutter/material.dart';

import '../general/colors.dart';
import 'bottom_page.dart';
import 'general_widget.dart';

class TaskFormWidget extends StatefulWidget {
  const TaskFormWidget({super.key});

  @override
  State<TaskFormWidget> createState() => _TaskFormWidgetState();
}

class _TaskFormWidgetState extends State<TaskFormWidget> {
  final forKey=GlobalKey<FormState>();
  MyServiceFirestore taskService=MyServiceFirestore(collection: "tasks");

final TextEditingController _titleController=TextEditingController();
final TextEditingController _descriptionController=TextEditingController();
final TextEditingController _dateController=TextEditingController();

String categorySelect="Personal";

showSelectDate()async{
  DateTime? datetime=await showDatePicker(
    context: context, 
    initialDate: DateTime.now(), 
    firstDate: DateTime(2022), 
    lastDate: DateTime(2030),
    cancelText:"Cancelar",
    confirmText: "Aceptar",
    helpText: "Seleccionar fecha",
    builder: (BuildContext context,Widget? widget) {
      return Theme(
        data: ThemeData.light().copyWith(
          dialogBackgroundColor: Colors.white,
          dialogTheme: DialogTheme(
            elevation: 0,
            backgroundColor: kBrandSegundaryColor ,
            shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(18.0)),
          ),
        colorScheme: ColorScheme.light(
          primary: kBrandPrimaryColor,
        ),
        ), 
        child: widget!);
    },
    );
    if(datetime!=null){
      _dateController.text=datetime.toString().substring(0,10);
      setState(() {
        
      });
    }
}


regiterTask(){
  if(forKey.currentState!.validate()){
      //
      TaskModel taskModel=TaskModel(
        title: _titleController.text, 
        description: _descriptionController.text, 
        date: _dateController.text, 
        category: categorySelect, 
        status: true);
      taskService.addtask(taskModel).then((value) {
        if(value.isNotEmpty){
          Navigator.pop(context);
          showSnackBarSuccess(context, "La tarea se registro con exito");
        }
      }).catchError((error){
        showSnackbarError(context, "Hubo un problema, intentalo nuevamente");
        Navigator.pop(context);
      }) ;
                }
}

  @override
  Widget build(BuildContext context) {
    return Container(
          padding:const EdgeInsets.all(14.0),
          decoration:const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(22.0)),
          ),
        child: Form(
          key:forKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text("Agregar tarea",style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.w600,
              ),),
              divider10(),
              TextFieldNormalWidget(hintText:"Titulo" ,icon:Icons.text_fields,controller:_titleController , ),
              divider10(),
              TextFieldNormalWidget(hintText:"Description" ,icon: Icons.description,controller: _descriptionController),
              divider10(),
              const Text("Categoria:"),
        
              Wrap(
                spacing: 10.0,
                crossAxisAlignment: WrapCrossAlignment.start,
                runAlignment: WrapAlignment.start,
                children: [
        
                FilterChip(
                selected: categorySelect=="Personal",
                backgroundColor: kBrandSegundaryColor,
                padding:const EdgeInsets.symmetric(horizontal: 8.0),
                selectedColor: categoryColor[categorySelect],
                checkmarkColor: Colors.white,
                labelStyle: TextStyle(
                  color: categorySelect=="Personal"?Colors.white:kBrandPrimaryColor,
                ),
                label: Text("Personal"), 
                onSelected: (bool value){
                    categorySelect="Personal";
                    setState(() { });
                }),
        
                FilterChip(
                selected: categorySelect=="Trabajo",
                backgroundColor: kBrandSegundaryColor,
                padding:const EdgeInsets.symmetric(horizontal: 8.0),
                selectedColor: categoryColor[categorySelect],
                checkmarkColor: Colors.white,
                labelStyle: TextStyle(
                  color: categorySelect=="Trabajo"?Colors.white:kBrandPrimaryColor,
                ),
                label: Text("Trabajo"), 
                onSelected: (bool value){
                  categorySelect="Trabajo";
                    setState(() { });
                }),
        
                FilterChip(
                selected: categorySelect=="Otro",
                backgroundColor: kBrandSegundaryColor,
                padding:const EdgeInsets.symmetric(horizontal: 8.0),
                selectedColor: categoryColor[categorySelect],
                checkmarkColor: Colors.white,
                labelStyle: TextStyle(
                  color: categorySelect=="Otro"?Colors.white:kBrandPrimaryColor,
                ),
                label: Text("Otro"), 
                onSelected: (bool value){
                  categorySelect="Otro";
                    setState(() { });
                }),
           
              ],),
              
              divider10(),
              TextFieldNormalWidget(hintText: "Fecha", icon: Icons.date_range,
              onTap:(){
                showSelectDate();
              } ,
              controller: _dateController,
              ),
              divider20(),

              ButtomNormalWidget(onPressed: (){
                regiterTask();
              }),
              
            ],
          ),
        ),
        );
  }
}