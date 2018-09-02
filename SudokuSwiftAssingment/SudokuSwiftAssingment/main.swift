//
//  main.swift
//  SudokuSwiftAssingment
//
//  Created by Steven Cao on 28/08/18.
//  Copyright © 2018 Steven Cao. All rights reserved.
//

import Foundation
//2D Array, The main Sudoku Board
var Board = Array(repeating: Array(repeating: 0, count: 9), count: 9);
//full board
var fullBoard = Array(repeating: 9 , count: 2);
//Stored Position fo Empty
var storeRnC = Array(repeating: 0, count: 2) ;

func RNGBoard() ->[[Int]]
{
    var RandRows = Array(repeating: Array(repeating: 0, count: 9), count: 9);
    //Possible Outcomes for the randoming
    var Outcomes = [0,1,2,3,4,5,6,7,8,9];
    let RowOut = [0,1,2,3,4,5,6,7,8];
    let ColOut = [0,1,2,3,4,5,6,7,8];
    var count = 0;
    //Gets through and applies randomed number to a board location
    while(count != 50)
    {
        for _ in 0...9
        {
            for _ in 0...9
            {
                //Randoms a number between 1-9
                let AddRand = Int(arc4random_uniform(UInt32(Outcomes.count)));
                if(AddRand == 0)
                {
                    continue;
                }
                //Randoms the board locaiton row then column
                let RandRow = Int(arc4random_uniform(UInt32(RowOut.count)) );
                let RandCol = Int(arc4random_uniform(UInt32(ColOut.count)) );
                //Checks whether it be possible to allow for placement
                 if(Placeable(Value: AddRand, Row: RandRow, Col: RandCol))
                 {
                    //places the randomed number in the randomed location
                    RandRows[RandRow][RandCol] = Outcomes[AddRand];
                    Outcomes.remove(at: AddRand); // removes the number randomed from the list
                }
               
            }
            if(Outcomes.isEmpty)
            {
                Outcomes = [1,2,3,4,5,6,7,8,9];
            }
        }
        count += 1;
    }
    
    return RandRows;
}
func DrawBoard()
{
    print();
    print("Sudoku-Steven");

    print("-----------");
    //Goes through and draws out the board
    for Row in 0...8
    {
   
        for Col in 0...8
        {
           
            print(Board[Row][Col],terminator:"");
             //will end line after 8 entries
            if(Col == 8)
            {
                print();
            }
            //addes a  | every time after 3 entires
            if(Col == 2 || Col == 5 )
            {
                print("|",terminator:"");
            }
        }
        //adds after every 3 rows of entires
        if(Row == 2 || Row == 5 || Row == 8)
        {
            print("-----------");
        }
    }
}
func InsertToBoard() -> Bool
{
    var Row = 0;

    print("Enter your intended board")
    //Repeats while all 9 rows are not filled out
    while( Row < 9)
    {
        //gets input
       let Readline =  readLine();
        var ReadlineArray = Readline?.compactMap{Int(String($0))};
        //checks to see if the input is 9 digits long
        if(ReadlineArray!.count != 9)
        {
            print("It must be no more then 9 digits long");
            return false;
        }
        for index in 0...8
            {
                //Checks if the input is between the numbers 0 - 9
                if(ReadlineArray![index] < 0 || ReadlineArray![index] > 9)
                {
                    print("There is a number that you have entered which is invalid");
                    return false;
                }
                //checking row if there are any duplicates
                for BeingChecked in 0...8
                {
                    //Checks if the current number checking is itself
                    if(index == BeingChecked)
                    {
                        continue;
                    }
                    else if (ReadlineArray![BeingChecked] == ReadlineArray![index] &&
                        ReadlineArray![BeingChecked] != 0)
                    {
                        print("dafuq is happening")
                        return false;
                    }
                }
                //check col for any duplicates
                for Row in 0...8
                {
                    for  Col in 0...8
                    {
                        if(Row == Col)
                        {
                            continue;
                        }
                        else if(Board[Row][Col] == ReadlineArray![Col] && ReadlineArray![Col] != 0)
                        {
                            return false;
                        }
                    }
                }
            }
        //if all check passes then enter the input in to the board
        Board[Row] = ReadlineArray!;
        
        Row += 1;
    }
    return true;
}
func CheckRow(Value ToCheck: Int, Row i: Int) -> Bool{
    //Goes through the row and checks if the value already exists
    for j in 0...8
    {
        if(Board[i][j] == ToCheck)
        {return true;}
        
    }
    return false;
}
func CheckCol(Value ToCheck: Int, Col j: Int) -> Bool{
    //Checks the current column to see if the value already exists
    for i in 0...8
    {
        if(Board[i][j] == ToCheck)
        {return true;}
    }
    return false;
}
func CheckSubBoard(Value ToCheck: Int, Row i: Int, Col j: Int) -> Bool{
    //Check each 3x3 to see if there is any duplicate numbers
    for subRow in 0...2
    {
        for subCol in 0...2
        {
            if(Board[subRow + i][subCol + j] == ToCheck)
            {return true;}
    
        }
    }
            return false;
}
func Placeable(Value ToCheck: Int, Row i: Int, Col j: Int) -> Bool
{
    //returns all 3 privous checks
    return(!CheckRow(Value: ToCheck, Row: i)  &&
        !CheckCol(Value: ToCheck, Col: j)  &&
        !CheckSubBoard(Value: ToCheck, Row: i - (i % 3), Col: j - (j % 3)));
}
func FindEmpty() -> Array<Int>
{
    //Looks for any empty slots within the board and then returns it in a stored array
    for i in 0...8
    {
        for j in 0...8
        {
            if(Board[i][j] == 0)
            {
             
                storeRnC[0] = i;
                storeRnC[1] = j;
                return storeRnC;
            }
        }
    }
    return fullBoard;
}

func Solve() -> Bool
{
    //Find empty slots where the val on it is zero
    if(fullBoard == FindEmpty() )
    { return true;}

    var temp = FindEmpty();
    let Col = temp[1];
    let Row = temp[0];
    for NumToCheck in 1...9
    {
        //check
        if (Placeable(Value: NumToCheck, Row: Row, Col: Col))
        {
            //places number at location
            Board[Row][Col] = NumToCheck;
            //DrawBoard();
            //if the board is solved return true
            if(Solve())
            {
                return true;
            }
            //not solvable, reset current to empty
            Board[Row][Col] = 0;
            
        }
        
    }
  //recursivly calls solve till true is returned
    return false;
}

func MainLoop()
{
    //menu
    print ("<---Sudoku--->");
    print ("1) Randomly Generate Sudoku?")
    print ("2) Insert Board Youself")
    print ("3) Exit Application")
    //takes user input
    let Line = readLine();
    //Randoms the board
    if (Line == "1" )
    {
        print ("Do somethinbg")
  
            for _ in 0...8
            {
                Board = RNGBoard();
            }
        
        DrawBoard()
        if(Solve())
        {
            DrawBoard()
        }
        else
        {
            print("Cannot be solved")
        }
        
    }
    //Insert your own board
    else if(Line == "2")
    {
        if(InsertToBoard())
        {
           print("Input allowed")
            if(Solve())
            {
                DrawBoard()
            }
            else
            {
                print("Cannot be solved")
            }
        }
        else
        {
            print ("Invalid Input")
            MainLoop();
        }
    }
    //exit program
    else if(Line == "3")
    {
        exit(0);
    }
    else
    {
        print ("Please enter a valid option")
        MainLoop();
    }
}

MainLoop()


