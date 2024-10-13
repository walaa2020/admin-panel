import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/admin_cubit/layout_cubit.dart';
import '../../cubit/admin_cubit/layout_state.dart';

Widget statisticGroupAge(BuildContext context) {
  return BlocProvider(
    create: (context) => LayoutCubit()
      ..fetchStatistics()
      ..onFetchAgeGroupStatistics(),
    child: BlocConsumer<LayoutCubit, LayoutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return BlocBuilder<LayoutCubit, LayoutStates>(
          builder: (context, state) {
            if (state is AgeGroupStatisticsLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is AgeGroupStatisticsLoaded) {
              return BarChart(
                BarChartData(
                  backgroundColor: Colors.grey[50],
                  borderData: FlBorderData(
                    border: const Border(
                      top: BorderSide.none,
                      right: BorderSide.none,
                      left: BorderSide(width: 1),
                      bottom: BorderSide(width: 1, style: BorderStyle.solid),
                    ),
                  ),
                  groupsSpace: 10,
                  titlesData: FlTitlesData(
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (double value, TitleMeta meta) {
                          final index = value.toInt();
                          if (index >= 0 && index < state.data.length) {
                            return SideTitleWidget(
                              axisSide: meta.axisSide,
                              child: Text(state.data[index]['age_group']),
                            );
                          }
                          return SideTitleWidget(
                            axisSide: meta.axisSide,
                            child: const Text(''),
                          );
                        },
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 40,
                        interval: 20,
                        getTitlesWidget: (double value, TitleMeta meta) {
                          return Text(value.toInt().toString());
                        },
                      ),
                    ),
                  ),
                  barGroups: state.data.asMap().entries.map((entry) {
                    final index = entry.key;
                    final data = entry.value;
                    return BarChartGroupData(
                      x: index,
                      barRods: [
                        BarChartRodData(
                          toY: data['percentage'],
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.zero,
                            bottomRight: Radius.zero,
                            topLeft: Radius.circular(24),
                            topRight: Radius.circular(24),
                          ),
                          fromY: 0,
                          width: 15,
                          color: Colors.blue,
                        ),
                      ],
                    );
                  }).toList(),
                ),
              );
            } else if (state is AgeGroupStatisticsError) {
              return Center(child: Text(state.message));
            } else {
              return const Center(child: Text('Unknown state'));
            }
          },
        );
      },
    ),
  );
}
