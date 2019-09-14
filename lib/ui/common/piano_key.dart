import 'package:flutter/material.dart';
import 'package:flutter_midi/flutter_midi.dart';
import 'package:tonic/tonic.dart';
import 'package:vibrate/vibrate.dart';

class PianoKey extends StatefulWidget {
  const PianoKey({
    @required this.keyWidth,
    this.midi,
    this.accidental,
    @required this.showLabels,
    @required this.labelsOnlyOctaves,
    this.feedback,
  });

  final bool accidental;
  final double keyWidth;
  final int midi;
  final bool showLabels;
  final bool labelsOnlyOctaves;
  final bool feedback;

  @override
  _PianoKeyState createState() => _PianoKeyState();
}

class _PianoKeyState extends State<PianoKey> {
  @override
  Widget build(BuildContext context) {
    final pitchName = Pitch.fromMidiNumber(widget.midi).toString();
    final pianoKey = Stack(
      children: <Widget>[
        Semantics(
            button: true,
            hint: pitchName,
            child: Material(
                borderRadius: _borderRadius,
                color: widget.accidental ? Colors.black : Colors.white,
                child: InkWell(
                  borderRadius: _borderRadius,
                  highlightColor: Colors.grey,
                  onTap: () {} ,
                  onTapDown: (_) {

                    FlutterMidi.playMidiNote(midi: widget.midi);
                      if (widget.feedback) {
                      Vibrate.feedback(FeedbackType.light);
                    }
                  },
                  onTapCancel: () {
                    FlutterMidi.stopMidiNote(midi: widget.midi);
                  },
                ))),
        Positioned(
            left: 0.0,
            right: 0.0,
            bottom: 20.0,
            child: buildShowLabels(pitchName)
                ? Text(pitchName,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: !widget.accidental ? Colors.black : Colors.white))
                : Container()),
      ],
    );
    if (widget.accidental) {
      return Container(
          width: widget.keyWidth,
          margin: EdgeInsets.symmetric(horizontal: 2.0),
          padding: EdgeInsets.symmetric(horizontal: widget.keyWidth * .1),
          child: Material(
              elevation: 6.0,
              borderRadius: _borderRadius,
              shadowColor: Color(0x802196F3),
              child: pianoKey));
    }
    return Container(
        width: widget.keyWidth,
        child: pianoKey,
        margin: EdgeInsets.symmetric(horizontal: 2.0));
  }

  bool buildShowLabels(String pitchName) {
    if (widget.showLabels) {
      if (widget.labelsOnlyOctaves) {
        if (pitchName.replaceAll(RegExp("[0-9]"), "") == "C") return true;
        return false;
      }
      return true;
    }
    return false;
  }
}

const BorderRadiusGeometry _borderRadius = BorderRadius.only(
  bottomLeft: Radius.circular(10.0),
  bottomRight: Radius.circular(10.0),
);
