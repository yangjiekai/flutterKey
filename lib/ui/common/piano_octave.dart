import 'package:flutter/material.dart';

import 'piano_key.dart';
import '../home/screen.dart';
class PianoOctave extends StatefulWidget {
  const PianoOctave({
    this.keyWidth,
    this.octave,
    @required this.showLabels,
    @required this.labelsOnlyOctaves,
    this.feedback,
  });

  final double keyWidth;
  final int octave;
  final bool showLabels;
  final bool labelsOnlyOctaves;
  final bool feedback;

  @override
  _PianoOctaveState createState() => _PianoOctaveState(this.keyWidth);
}

class _PianoOctaveState extends State<PianoOctave> {
  _PianoOctaveState( this.keyWidth);
  final double keyWidth;




  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(children: <Widget>[
        Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
          _buildKey(24, false),
          _buildKey(26, false),
          _buildKey(28, false),
          _buildKey(29, false),
          _buildKey(31, false),
          _buildKey(33, false),
          _buildKey(35, false),
        ]),
        Positioned(
            left: 0.0,
            right: 0.0,
            bottom: 115,
            top: 0.0,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(width: widget.keyWidth * .5,
                    color: GlobalObject.selectedIndexes.contains(this.keyWidth) ? Colors.red : Colors.blue,
                  ),
                  _buildKey(25, true),
                  _buildKey(27, true),
                  Container(width: widget.keyWidth,
                    color: GlobalObject.selectedIndexes.contains(this.keyWidth) ? Colors.red : Colors.blue,
                  ),
                  _buildKey(30, true),
                  _buildKey(32, true),
                  _buildKey(34, true),
                  Container(width: widget.keyWidth * .5,

                    color: GlobalObject.selectedIndexes.contains(this.keyWidth) ? Colors.red : Colors.blue,
                  ),
                ])),
      ]),
    );
  }

  Widget _buildKey(int midi, bool accidental) {
    return PianoKey(
      midi: midi + widget.octave,
      accidental: accidental,
      keyWidth: widget.keyWidth,
      showLabels: widget.showLabels,
      labelsOnlyOctaves: widget.labelsOnlyOctaves,
      feedback: widget.feedback,
    );
  }
}
