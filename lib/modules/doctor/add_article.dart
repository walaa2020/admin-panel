
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reda3/shared/components/components.dart';

import '../../cubit/admin_cubit/layout_cubit.dart';
import '../../cubit/admin_cubit/layout_state.dart';
import '../../models/article_model.dart';
import '../../shared/network/cach_network.dart';

class AddArticle extends StatelessWidget {
  const AddArticle({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {

    double height= MediaQuery.of(context).size.height;
    double width= MediaQuery.of(context).size.width;
    var headerController=TextEditingController();
    var contentController=TextEditingController();
return

  BlocProvider(
    create: (context)=>LayoutCubit(),
    child: BlocConsumer<LayoutCubit,LayoutStates>(
      listener: (context,state){
        if(state is InsertArticleLoadState){
          showAlert(context,"loading...",Colors.teal);
        }
        else if (state is InsertArticleSuccessState){
          Navigator.of(context).pop();
          showAlert(context,"success!",Colors.teal);

        }
        else if(state is FailedToInsertArticleState){
          Navigator.of(context).pop();
          showAlert(context,"error",Colors.red);
        }
      },
      builder:  (context,state){
        var cubit =LayoutCubit.get(context);
        return Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: height/20,),
                  Padding(
                    padding: const EdgeInsets.all(13.0),
                    child: Text("insert Article",style: TextStyle(color: Colors.teal.shade300,
                        fontSize: 18,fontWeight: FontWeight.bold),),
                  ),
                  SizedBox(height: height/9,),
                  Padding(
                    padding:  EdgeInsets.only(right: width/4),
                    child: defaultTextFromField(controller: headerController,
                        type:TextInputType.text , prefixIcon: Icon(Icons.title,color: Colors.teal.shade300,), label: "title"),
                  ),
                  SizedBox(height: height/30,),
                  defaultTextFromField(controller: contentController,
                      type:TextInputType.text , prefixIcon:Container(height: height/height,width: width/width,), label: "content",
                      line: 8),
                  SizedBox(height: height/10,),
                  Center(
                    child: Container(
                      width: width/6,
                      height: height/18,
                      decoration: BoxDecoration(

                        color: Colors.teal.shade300,
                        borderRadius: BorderRadius.all(Radius.circular(34),
                        ),),
                      child: MaterialButton(onPressed: () async {

 cubit.insertArticle(headerController.text, contentController.text);
                      },


                        child: Text("insert",   style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 18,
                        ),),),
                    ),
                  )

                ],
              ),
            ),
          ),
        );

      },

    ),
  );
  }
}
