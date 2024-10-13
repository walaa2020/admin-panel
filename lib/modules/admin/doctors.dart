import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubit/admin_cubit/layout_cubit.dart';
import '../../cubit/admin_cubit/layout_state.dart';
import '../../shared/components/components.dart';

class Doctors extends StatelessWidget {
  const Doctors({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LayoutCubit(),
      child: BlocConsumer<LayoutCubit, LayoutStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            body: Container(child: DoctorDashboard(context, 1)),
          );
        },
      ),
    );
  }
}
