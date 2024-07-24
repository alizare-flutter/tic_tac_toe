import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isTurnO = true;
  List xOrIList = ['', '', '', '', '', '', '', '', ''];
  int filledBoxes = 0;
  bool gameHasResult = false;
  int scoreX = 0;
  int scoreO = 0;
  String winnerTitle = '';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "دوز",
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            IconButton(
              onPressed: () {
                clearGame();
              },
              icon: Icon(Icons.refresh),
              color: Colors.white,
            ),
          ],
          backgroundColor: Colors.transparent,
        ),
        body: Column(
          children: [
            GetScoreBord(),
            SizedBox(height: 20),
            getResultButton(),
            SizedBox(height: 20),
            GetGridView(),
            getTurn(),
          ],
        ),
      ),
    );
  }

  Widget getResultButton() {
    return Visibility(
      visible: gameHasResult,
      child: OutlinedButton(
        onPressed: () {
          setState(() {
            gameHasResult = false;
            clearGame();
          });
        },
        style: OutlinedButton.styleFrom(
            side: BorderSide(color: Colors.white, width: 2)),
        child: Text(
          '$winnerTitle, play again!',
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget getTurn() {
    return Text(
      isTurnO ? 'O نوبت' : 'X نوبت',
      style: TextStyle(
          color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
    );
  }

  Widget GetGridView() {
    return Expanded(
      child: GridView.builder(
        itemCount: 9,
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        itemBuilder: (BuildContext, int index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                tapped(index);
              });
            },
            child: Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
              ),
              child: Center(
                child: Text(
                  xOrIList[index],
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: xOrIList[index] == 'X' ? Colors.white : Colors.red,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void tapped(int index) {
    if (gameHasResult) {
      return;
    }
    setState(() {
      if (xOrIList[index] != '') {
        return;
      }

      if (isTurnO) {
        xOrIList[index] = 'O';
        filledBoxes++;
      } else {
        xOrIList[index] = 'X';
        filledBoxes++;
      }
      isTurnO = !isTurnO;

      checkWineer();
    });
  }

  void checkWineer() {
    if (xOrIList[0] == xOrIList[1] &&
        xOrIList[0] == xOrIList[2] &&
        xOrIList[0] != '') {
      setResult(xOrIList[0], "winner is: " + xOrIList[0]);
      return;
    }
    if (xOrIList[3] == xOrIList[4] &&
        xOrIList[3] == xOrIList[5] &&
        xOrIList[3] != '') {
      setResult(xOrIList[3], "winner is: " + xOrIList[3]);
      return;
    }
    if (xOrIList[6] == xOrIList[7] &&
        xOrIList[6] == xOrIList[8] &&
        xOrIList[6] != '') {
      setResult(xOrIList[6], "winner is: " + xOrIList[6]);
      return;
    }
    if (xOrIList[0] == xOrIList[3] &&
        xOrIList[0] == xOrIList[6] &&
        xOrIList[0] != '') {
      setResult(xOrIList[0], "winner is: " + xOrIList[0]);
      return;
    }
    if (xOrIList[1] == xOrIList[4] &&
        xOrIList[1] == xOrIList[7] &&
        xOrIList[1] != '') {
      setResult(xOrIList[1], "winner is: " + xOrIList[1]);
      return;
    }
    if (xOrIList[2] == xOrIList[5] &&
        xOrIList[2] == xOrIList[8] &&
        xOrIList[2] != '') {
      setResult(xOrIList[2], "winner is: " + xOrIList[2]);
      return;
    }
    if (xOrIList[0] == xOrIList[4] &&
        xOrIList[0] == xOrIList[8] &&
        xOrIList[0] != '') {
      setResult(xOrIList[0], "winner is: " + xOrIList[0]);
      return;
    }
    if (xOrIList[2] == xOrIList[4] &&
        xOrIList[2] == xOrIList[6] &&
        xOrIList[2] != '') {
      setResult(xOrIList[2], "winner is: " + xOrIList[2]);
      return;
    }

    if (filledBoxes == 9) {
      setResult('', "Draw");
    }
  }

  Widget GetScoreBord() {
    return Row(
      children: [
        Expanded(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(8),
                child: Text(
                  "O بازیکن",
                  style: TextStyle(color: Colors.white, fontSize: 25.0),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8),
                child: Text(
                  scoreO.toString(),
                  style: TextStyle(color: Colors.white, fontSize: 25.0),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(8),
                child: Text(
                  "X بازیکن",
                  style: TextStyle(color: Colors.white, fontSize: 25.0),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8),
                child: Text(
                  scoreX.toString(),
                  style: TextStyle(color: Colors.white, fontSize: 25.0),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  void setResult(String winner, String title) {
    setState(() {
      gameHasResult = true;
      winnerTitle = title;
      if (winner == "X") {
        scoreX++;
      } else if (winner == "O") {
        scoreO++;
      } else {
        scoreO++;
        scoreX++;
      }
    });
  }

  void clearGame() {
    setState(() {
      for (int i = 0; i < xOrIList.length; i++) {
        xOrIList[i] = '';
      }
    });
    filledBoxes = 0;
  }
}
