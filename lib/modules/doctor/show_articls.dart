

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/admin_cubit/layout_cubit.dart';
import '../../cubit/admin_cubit/layout_state.dart';
import '../../shared/components/constants/constant.dart';

class ShowArticle extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return BlocProvider<LayoutCubit>(
      create: (context) => LayoutCubit()..getArticles(),
      child: BlocConsumer<LayoutCubit, LayoutStates>(
        listener: (context, state) {

        },
        builder: (context, state) {
          var cubit=LayoutCubit.get(context);


          if(state is GetArticlesLoadState) {
            return Center(child: CircularProgressIndicator(),);
          }
          else if(state is GetArticlesSuccessState){
            // String originalString ;
            // String modifiedString = originalString.replaceFirst("000000Z", "");
            // print(modifiedString); // ستطبع: 2024-06-26T06:06:37.
            return Scaffold(
              body: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                        child: Text(
                          "ARTICLE",
                          style: TextStyle(
                              color: Colors.teal.shade300,
                              fontWeight: FontWeight.bold,
                              fontSize: 24),
                        )),

                    Expanded(
                        flex: 7,
                        child: ListView.separated(
                            itemBuilder: (context, index) => Container(
                              width:
                              MediaQuery.of(context).size.width / 0.2,

                              // height: MediaQuery.of(context).size.height/2,

                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(24),
                                  border: Border.all(
                                      color: Colors.teal, width: 2)),

                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${state.art[index].title}",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 20),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      "${state.art[index].content}",
                                      style: TextStyle(
                                          color: Colors.black54,
                                          fontSize: 18),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Align(
                                      // originalString.replaceFirst("000000Z", "");
                                      alignment: Alignment.bottomRight,
                                      child: Text(
                                        "${state.art[index].createdAt?.replaceFirst(".000000Z", "").replaceFirst("T", "   ")}",
                                        style: TextStyle(
                                            color: Colors.black54,
                                            fontSize: 15),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            separatorBuilder: (context, index) => SizedBox(
                              height: 20,
                            ),
                            itemCount: state.art.length))
                  ],
                ),
              ),
            );

          }
          else{
            return Center(child: CircularProgressIndicator(),);
          }
        },

      ),
    );
  }
}

//
// ListView.separated(itemBuilder: (context,index)=>Container(
//
// width: MediaQuery.of(context).size.width/0.2,
//
// // height: MediaQuery.of(context).size.height/2,
//
// decoration: BoxDecoration(borderRadius: BorderRadius.circular(24),
//
// border: Border.all(color: Colors.teal,width: 2)),
//
// child: Padding(
//
// padding: const EdgeInsets.all(20.0),
//
// child: Column(
// mainAxisSize: MainAxisSize.max,
// crossAxisAlignment: CrossAxisAlignment.start,
// children: [
// Text("llllll",style: TextStyle(color: Colors.black,
//
// fontSize: 20),),
// SizedBox(height: 20,),
// Text("bbbbbbbbb",style: TextStyle(color: Colors.black54,
//
// fontSize: 18),),
// SizedBox(height: 20,),
// Align(alignment: Alignment.bottomRight,
// child: Text(
// "bbbbbbbbb",style: TextStyle(color: Colors.black54,
//
// fontSize: 15),),
// ),
// ],
// ),
//
// ),),
// separatorBuilder:  (context,index)=>SizedBox(height: 20,),
// itemCount: 10)),