//
//  main.swift
//  SudokuSwiftAssingment
//
//  Created by Steven Zhao on 28/08/18.
//  Copyright © 2018 Steven Cao. All rights reserved.
//

import Foundation

let ROW : Int = 9;
let COL : Int = 9;
var Board = Array(repeating: Array(repeating: 0, count: ROW), count: COL);
var IsReturned: Bool = false;
var NumbersStored = Array(repeating: 0 , count: 9);
var fullBoard = Array(repeating: 9 , count: 2);
var Val = 0;

   var storeRnC = Array(repeating: 0, count: 2) ;
func DrawBoard()
{
        print();
    print("Sudoku-Steven");

    print("-----------");
    for Col in 0...8
    {
   
        for Row in 0...8
        {
            print(Board[Col][Row],terminator:"");
            if(Row == 8)
            {
                print();
            }
            if(Row == 2 || Row == 5 )
            {
                print("|",terminator:"");
            }
        }
        if(Col == 2 || Col == 5 || Col == 8)
        {
            print("-----------");
        }
    }
}
func InsertToBoard()
{
    var Readline:String?;
    var Array:[Int]?;
    for Col in 0...8
    {
        Readline =  readLine();
        Array = Readline?.compactMap({ Int (String($0))});
        Board[Col] = Array!;
    }
    
}
//row
func ValidateRowSum() -> Bool
{
    var Temp : Int = 0;
    //Check for horizontal and vertical
    for i in 0...8
    {
        for j in 0...8
        {
            Temp = Temp + Board[i][j];
            
        }
        if(Temp == 45)
        {
            return true;
        }
        else if(Temp != 45)
        {
            return false;
        }
        Temp = 0;
    }
    return false;
}
func Check() -> Bool
{
   
    //check rows and columns
    for i in 0...8
    {
        //NumbersStored = []; // empties the array each time
        for j in 0...8
        {
            for k in 1...8
            {
                
                if(Board[i][j] != 0 && Board[i][j] == Board[i][k])
                {
                    Val = 1;
                    print(Val)
                    return false;}
                if(Board[j][i] != 0 && Board[j][i] == Board[k][i])
                {
                    Val = 2;
                    print(Val)
                    return false;}
               if(
                  Board[j % 3 + (i % 3) * 3][j % 3 + (i / 3) * 3] ==
                    Board[k % 3 + (i % 3) * 3][k % 3 + (i / 3) * 3] )
                {
                    Val = 3;
                    print(Val)
                return false;
                    
                }
            }
        }
    }
    return true;

}
func CheckRow(Value ToCheck: Int, Row j: Int) -> Bool{
    for i in 0..<9
    {
        if(Board[i][j] == ToCheck)
        {return true;}
        
    }
    return false;
}

func CheckCol(Value ToCheck: Int, Col i: Int) -> Bool{
    for j in 0..<9
    {
        if(Board[i][j] == ToCheck)
        {return true;}
    }
    return false;
}
func CheckSubBoard(Value ToCheck: Int, Row j: Int, Col i: Int) -> Bool{
    for subCol in 0...3
    {
        for subRow in 0...3
        {
            if(Board[subCol + i][subRow + j] == ToCheck)
            {return true;}
    
        }
    }
            return false;
}
func Placeable(Value ToCheck: Int, Row j: Int, Col i: Int) -> Bool
{
 return (!CheckRow(Value: ToCheck, Row: j)  &&
              !CheckCol(Value: ToCheck, Col: i)  &&
    !CheckSubBoard(Value: ToCheck, Row: j - (j % 3), Col: i - (i % 3)));
}
func FindEmpty() -> Array<Int>
{
    for i in 0..<9
    {
        for j in 0..<9
        {
            if(Board[i][j] == 0)
            {
             
                storeRnC.append(i);
                storeRnC.append(j);
                return storeRnC;
            }
        }
    }
    return fullBoard;
}
func Solve() -> Bool
{
    //Find empty slots where the val on it is zero
    if(fullBoard == FindEmpty())
    { return true;}
    let temp = FindEmpty();
    let Row = temp.endIndex;
    let Col = temp.startIndex;
    for i in 1...9
    {
        if (Placeable(Value: i, Row: Row, Col: Col))
        {
            Board[Col][Row] = i;
            if(Solve())
            {
                return true;
            }
            Board[Col][Row] = 0;
        }
    }
    return false;
}
//DrawBoard();
InsertToBoard();
//ValidateRowSum();
if(Solve() == true)
{
    DrawBoard();
}
else
{
    print ("Cannot be solved")
}
