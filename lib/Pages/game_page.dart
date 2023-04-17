import 'package:flutter/material.dart';

Offset _offsetFirst = Offset(-1, 20);
Offset _offsetSecond = Offset(-1, 20);
late double rightPosFirst;
late double rightPosSecond;

class GamePageScreen extends StatelessWidget {
  const GamePageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    rightPosFirst = MediaQuery.of(context).size.width * 0.1;
    rightPosSecond = MediaQuery.of(context).size.width * 0.9 - 100;
    return SafeArea(
        child: Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0),
        child: AppBar(
          backgroundColor: Colors.black87,
          title: Text('My App'),
        ),
      ),
      body: Container(
        color: Colors.white,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Center(child: DraggableWidget()),
      ),
    ));
  }
}

class DraggableWidget extends StatelessWidget {
  const DraggableWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        FirstStaticContainer(),
        SecondStaticContainer(),
        FirstDynamicContainer(),
        SecondDynamicContainer(),
      ],
    );
  }
}

class FirstStaticContainer extends StatelessWidget {
  const FirstStaticContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
        left: MediaQuery.of(context).size.width * 0.1,
        top: 350,
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.amber.withOpacity(0.75),
          ),
          width: 100,
          height: 100,
          child: Text(
            '1',
            style: TextStyle(
              color: Colors.blue,
              fontSize: 36,
              fontWeight: FontWeight.bold,
            ),
          ),
        ));
  }
}

class SecondStaticContainer extends StatelessWidget {
  const SecondStaticContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
        left: MediaQuery.of(context).size.width * 0.9 - 100,
        top: 350,
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.black.withOpacity(0.9),
          ),
          width: 100,
          height: 100,
          child: Text(
            '2',
            style: TextStyle(
              color: Colors.blue,
              fontSize: 36,
              fontWeight: FontWeight.bold,
            ),
          ),
        ));
  }
}

class FirstDynamicContainer extends StatefulWidget {
  const FirstDynamicContainer({Key? key}) : super(key: key);

  @override
  State<FirstDynamicContainer> createState() => _FirstDynamicContainerState();
}

class _FirstDynamicContainerState extends State<FirstDynamicContainer> {
  @override
  Widget build(BuildContext context) {
    double rightPos = MediaQuery.of(context).size.width * 0.1;
    double dxMin = MediaQuery.of(context).size.width * 0.1 - 40;
    double dxMax = MediaQuery.of(context).size.width * 0.1 + 40;
    return Positioned(
      left: _offsetFirst.dx == -1
          ? MediaQuery.of(context).size.width * 0.1
          : _offsetFirst.dx,
      top: _offsetFirst.dy,
      child: Draggable(
        child: Container(
          alignment: Alignment.center,
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.black,
          ),
          child: Text(
            '1',
            style: TextStyle(
              color: Colors.blue,
              fontSize: 36,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        feedback: Material(
            color: Colors.transparent,
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.black.withOpacity(0.75),
              ),
              alignment: Alignment.center,
              child: Text(
                '1',
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )),
        childWhenDragging: Container(),
        onDraggableCanceled: (Velocity velocity, Offset offset) {
          if (IsInPosition(offset, dxMin, dxMax, 360, 440)) {
            setState(() {
              _offsetFirst = Offset(rightPos, 350);
            });
            if (AreInPosition()) {
              Future.delayed(Duration(milliseconds: 200), () {
                ShowDialogFunction(context);
                setState(() {
                  _offsetFirst = Offset(-1, 20);
                  _offsetSecond = Offset(-1, 20);
                });
              });
            }
            ;
          } else
            setState(() {
              _offsetFirst = Offset(offset.dx, offset.dy - 50);
            });
        },
      ),
    );
  }
}

class SecondDynamicContainer extends StatefulWidget {
  const SecondDynamicContainer({Key? key}) : super(key: key);

  @override
  State<SecondDynamicContainer> createState() => _SecondDynamicContainerState();
}

class _SecondDynamicContainerState extends State<SecondDynamicContainer> {
  @override
  Widget build(BuildContext context) {
    double rightPos = MediaQuery.of(context).size.width * 0.9 - 100;
    double dxMin = MediaQuery.of(context).size.width * 0.9 - 140;
    double dxMax = MediaQuery.of(context).size.width * 0.9 - 60;
    return Positioned(
      left: _offsetSecond.dx == -1
          ? MediaQuery.of(context).size.width * 0.9 - 100
          : _offsetSecond.dx,
      top: _offsetSecond.dy,
      child: Draggable(
        child: Container(
          alignment: Alignment.center,
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.amber,
          ),
          child: Text(
            '2',
            style: TextStyle(
              color: Colors.blue,
              fontSize: 36,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        feedback: Material(
            color: Colors.transparent,
            child: Container(
              alignment: Alignment.center,
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.amber.withOpacity(0.75),
              ),
              child: Text(
                '2',
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )),
        childWhenDragging: Container(),
        onDraggableCanceled: (Velocity velocity, Offset offset) {
          if (IsInPosition(offset, dxMin, dxMax, 360, 440)) {
            setState(() {
              _offsetSecond = Offset(rightPos, 350);
            });
            if (AreInPosition()) {
              Future.delayed(Duration(milliseconds: 200), () {
                ShowDialogFunction(context);
                setState(() {
                  _offsetFirst = Offset(-1, 20);
                  _offsetSecond = Offset(-1, 20);
                });
              });
            }
            ;
          } else
            setState(() {
              _offsetSecond = Offset(offset.dx, offset.dy - 50);
            });
        },
      ),
    );
  }
}

bool IsInPosition(Offset offset, double dxMin, double dxMax, double dyMin, double dyMax) {
  if (offset.dx >= dxMin &&
      offset.dx <= dxMax &&
      offset.dy >= dyMin &&
      offset.dy <= dyMax) return true;
  return false;
}

bool AreInPosition() {
  if (_offsetFirst.dx == rightPosFirst &&
      _offsetFirst.dy == 350 &&
      _offsetSecond.dx == rightPosSecond &&
      _offsetSecond.dy == 350) return true;
  return false;
}

ShowDialogFunction(BuildContext context) {
  showDialog(
    barrierDismissible: false,
    context: context,
    barrierColor: Colors.blue,
    builder: (_) => Center(
      child: AlertDialog(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          'Congratulations!',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pushReplacementNamed('first_page');
            },
            child: Text(
              'OK',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    ),
  );
}
