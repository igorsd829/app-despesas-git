import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double value;
  final double percentage;

  const ChartBar({
    required this.label,
    required this.value,
    required this.percentage,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (cxt, Constraints) {
        return Column(
          children: [
            Container(
              height: Constraints.maxHeight * 0.15,
              child: FittedBox(
                child: Text(
                  '${value.toStringAsFixed(2)}',
                ),
              ),
            ),
            SizedBox(
              height: Constraints.maxHeight * 0.05,
            ),
            Container(
              height: Constraints.maxHeight * 0.6,
              width: 10,
              child: Stack(
                alignment: AlignmentDirectional.bottomCenter,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        width: 1.0,
                      ),
                      color: const Color.fromRGBO(220, 220, 220, 1),
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  FractionallySizedBox(
                    heightFactor: percentage,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: Constraints.maxHeight * 0.05,
            ),
            Container(
              height: Constraints.maxHeight * 0.15,
              child: FittedBox(child: Text(label)),
            ),
          ],
        );
      },
    );
  }
}
