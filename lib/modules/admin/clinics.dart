
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/admin_cubit/layout_cubit.dart';
import '../../cubit/admin_cubit/layout_state.dart';
import '../../shared/components/components.dart';

class Clinics extends StatelessWidget {
  const Clinics({super.key});




  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=>LayoutCubit()..getClinic(),
      child: BlocConsumer<LayoutCubit,LayoutStates>(
        listener: (context,state){

        },
        builder:  (context,state){
          return Scaffold(

            body: BlocBuilder<LayoutCubit, LayoutStates>(
              builder: (context, state) {
       return Clincs(context);
              },
            ),
          );

        },

      ),
    );

  }
}