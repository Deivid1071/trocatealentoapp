
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';




class SliderCustomTcoin extends StatefulWidget {
  final String tittle;
  final List<String> listValues;
  final double value;
  final double range;
  final _SliderCustomCallback onChanged;
  final double height;

  const SliderCustomTcoin({Key key, @required this.tittle, @required this.listValues, @required this.value, this.onChanged, this.range, this.height}) : super(key: key);

  @override
  _SliderCustomTcoinState createState() => _SliderCustomTcoinState();
}

class _SliderCustomTcoinState extends State<SliderCustomTcoin> {
  @override
  Widget build(BuildContext context) {
    double height = widget.height ?? 110;

    return Container(
      //color: Colors.red,
      height: height,
      child: Stack(
          children: <Widget> [
            Positioned.fill(
                top: -50,
                child: Container(
                  alignment: Alignment.center,
                  child: Text(
                      widget.tittle,
                      style: TextStyle(fontFamily: 'Nunito', fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF2F9C7F))
                  ),
                )
            ),
            Positioned.fill(
                top: height - (20 * (_paddingText() * 2)) - 20,
                child: Container(
                  child: SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      activeTrackColor: Theme.of(context).primaryColor,
                      inactiveTrackColor: Colors.black,
                      trackShape: RectangularSliderTrackShape(),
                      trackHeight: 4.0,
                      thumbColor: Color(0xFF3CC9A4),
                      thumbShape: RoundSliderThumbShape(enabledThumbRadius: 12.0),
                      overlayColor: Theme.of(context).primaryColor.withAlpha(96),
                      overlayShape: RoundSliderOverlayShape(overlayRadius: 28.0),
                      activeTickMarkColor: Theme.of(context).primaryColor,
                      inactiveTickMarkColor: Colors.black,
                      tickMarkShape: RoundSliderTickMarkShape(tickMarkRadius: 5.0),
                      valueIndicatorShape: PaddleSliderValueIndicatorShape(),
                      valueIndicatorColor: Theme.of(context).primaryColor,
                    ),
                    child: Slider(
                      label: widget.range == null ? widget.listValues[widget.value.round()] : 'T\$ ${widget.value.round()}',
                      min: 1,
                      max: 10,
                      divisions: 9,
                      value: widget.value.toDouble(),
                      onChanged: (value) => widget.onChanged(value),
                    ),
                  ),
                )
            ),
            Positioned.fill(
              top: height - (20 * _paddingText()),
              child: Padding(
                padding: const EdgeInsets.only(left: 15,right: 15),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(
                      widget.listValues.length, (index) => Text(
                    widget.listValues[index],
                    style: TextStyle(fontFamily: 'Nunito', fontStyle: FontStyle.italic,)
                  )
                  ),
                ),
              ),
            ),
          ]
      ),
    );
  }

  int _paddingText() {
    int maxTotal = 0;
    for (String text in widget.listValues) {
      int max = 0;
      int i = 0;
      do {
        i = text.indexOf('\n', i);
        if (i != -1) {
          max++;
          i++;
        }
        maxTotal = max > maxTotal ? max : maxTotal;
      } while (i != -1);
    }
    return maxTotal + 1;
  }
}

typedef _SliderCustomCallback = void Function(double value);