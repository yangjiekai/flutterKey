import 'package:flutter/material.dart';

import 'piano_octave.dart';
import 'piano_slider.dart';
import '../home/screen.dart';



class PianoView extends StatefulWidget {
  const PianoView({
    this.showLabels,
    this.keyWidth,
    @required this.labelsOnlyOctaves,
    this.disableScroll,
    this.feedback,
    detectTapedItem,
    selectedIndexes
  });

  final double keyWidth;
  final bool showLabels;
  final bool labelsOnlyOctaves;
  final bool disableScroll;
  final bool feedback;



  @override
  _PianoViewState createState() => _PianoViewState();
}

class _PianoViewState extends State<PianoView> {
  int _currentOctave = 3;
  ScrollController _controller;

  @override
  void initState() {
    _controller = ScrollController(initialScrollOffset: currentOffset);
    super.initState();
  }

  int _clearSelection(PointerUpEvent event) {
     HomeScreenState().trackTaped.clear();
      setState(() {
      GlobalObject().selectedIndexes.clear();
    }
   
    );
     return 0;
  }

   int  _selectIndex(int index) {
   setState(() {
      GlobalObject().selectedIndexes.add(index);
    });

    return 0;
  }

  

 

  

  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.vertical,
      children: <Widget>[
        Flexible(
          flex: 1,
          child: Container(
            child: PianoSlider(
              keyWidth: widget.keyWidth,
              currentOctave: _currentOctave,
              octaveTapped: (int octave) {
                setState(() {
                  _currentOctave = octave;
                });
                _controller.jumpTo(currentOffset);
              },
            ),
          ),
        ),
        Flexible(
          flex: 8,
          child: ListView.builder(
            itemCount: 7,
            physics:
                widget.disableScroll ? NeverScrollableScrollPhysics() : null,
            controller: _controller,
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) {
              return PianoOctave(
                octave: index * 12,
                keyWidth: widget.keyWidth,
                showLabels: widget.showLabels,
                labelsOnlyOctaves: widget.labelsOnlyOctaves,
                feedback: widget.feedback,
                clearSelection : _clearSelection,
               selectIndex : _selectIndex
              );
            },
          ),
        ),
      ],
    );
  }

  double get currentOffset => widget.keyWidth * (7 * _currentOctave);
}
