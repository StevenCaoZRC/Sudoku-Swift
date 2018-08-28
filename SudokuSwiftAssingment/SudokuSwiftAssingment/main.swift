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
func CheckValidPlacement()
{
    for i in 0...8
    {
        		
        
    }
}
   
DrawBoard();
InsertToBoard();
DrawBoard();
