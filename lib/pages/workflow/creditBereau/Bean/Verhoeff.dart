class Verhoeff {
  // The multiplication table
  List d = [
    [0, 1, 2, 3, 4, 5, 6, 7, 8, 9],
    [1, 2, 3, 4, 0, 6, 7, 8, 9, 5],
    [2, 3, 4, 0, 1, 7, 8, 9, 5, 6],
    [3, 4, 0, 1, 2, 8, 9, 5, 6, 7],
    [4, 0, 1, 2, 3, 9, 5, 6, 7, 8],
    [5, 9, 8, 7, 6, 0, 4, 3, 2, 1],
    [6, 5, 9, 8, 7, 1, 0, 4, 3, 2],
    [7, 6, 5, 9, 8, 2, 1, 0, 4, 3],
    [8, 7, 6, 5, 9, 3, 2, 1, 0, 4],
    [9, 8, 7, 6, 5, 4, 3, 2, 1, 0]
  ];

  List p = [
    [0, 1, 2, 3, 4, 5, 6, 7, 8, 9],
    [1, 5, 7, 6, 2, 8, 3, 0, 9, 4],
    [5, 8, 0, 3, 7, 9, 6, 1, 4, 2],
    [8, 9, 1, 6, 0, 4, 3, 5, 2, 7],
    [9, 4, 5, 3, 1, 2, 6, 8, 7, 0],
    [4, 2, 8, 6, 5, 7, 3, 9, 0, 1],
    [2, 7, 9, 3, 8, 0, 6, 4, 1, 5],
    [7, 0, 4, 6, 9, 1, 3, 2, 5, 8]
  ];

  List inv = [0, 4, 3, 2, 1, 5, 6, 7, 8, 9];

  bool validateVerhoeff(String num) {
    print(num + "is the num");
    var c = 0;
    List myArray = stringToReversedIntArray(num);

    for (int i = 0; i < myArray.length; i++) {
      print("inside for of validate" + i.toString());
      c = d[c][p[(i % 8)][myArray[i]]];
    }
    print(c);
    return (c == 0);
  }

  List stringToReversedIntArray(String num) {
    List myArray = new List();
    for (var i = 0; i < num.length; i++) {
      print(i.toString() + "Ye hai i");
      myArray.add(int.parse(num.substring(i, i + 1)));
      print("exiting string to rev " + i.toString());
    }

    myArray = reverse(myArray);

    return myArray;
  }

  /*
     * Reverses an int array
     */
  List reverse(List myArray) {
    List reversed = new List();

    for (int i = 0; i < myArray.length; i++) {
      reversed.add(myArray[myArray.length - (i + 1)]);
    }

    return reversed;
  }
}
