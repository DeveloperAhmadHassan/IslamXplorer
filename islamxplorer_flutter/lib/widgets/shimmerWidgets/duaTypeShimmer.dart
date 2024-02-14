import 'package:flutter/material.dart';
import 'package:islamxplorer_flutter/widgets/shimmerWidgets/shimmerEffect.dart';

class DuaTypeShimmer extends StatelessWidget{
  const DuaTypeShimmer({super.key, this.itemCount = 6});

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: ListView.separated(
        shrinkWrap: true,
        itemCount: itemCount,
        scrollDirection: Axis.vertical,
        separatorBuilder: (_,__) => const SizedBox(width: 20,),
        itemBuilder: (_,__) {
          return const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ShimmerEffect(height: 55, width: 55, radius: 55,),
              SizedBox(height: 15,),
              ShimmerEffect(height: 8, width: 55)
            ],
          );
        },


      ),
    );
  }

}