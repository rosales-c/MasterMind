//
//  MasterMindModel.swift
//  MasterMind
//
//  Created by Cinthya Rosales on 3/07/21.
//

import Foundation


struct MasterMindModel {
    
    var gameBoard: [ [Slot] ] = []
    var codeBoard =  [ Slot ] (repeating: Slot(slotType: SlotType.codeSlot), count: 4)
    var colorBoard = [ Slot ] (repeating: ( Slot(slotType: SlotType.codeSlot)), count: 6)
    var numGuesses = 7
    var outOfGuesses = false
    let numberOfRows: Int = 4
    var codeSlotRandom = 0
    
    mutating func createGame() {
        for row in 0..<8 {
            gameBoard.append( [Slot]() )
            for i  in 0..<4 {
                gameBoard[row].append( Slot(slotType: SlotType.gameSlot(representing: i, value: 0)) )
            }
        }
        
        createColorPallet()
        setCode()
    }
    
    
    mutating func setCode() {
        codeBoard[0].color = Int.random(in: 1...6)
        codeBoard[1].color = Int.random(in: 1...6)
        codeBoard[2].color = Int.random(in: 1...6)
        codeBoard[3].color = Int.random(in: 1...6)
    }
    
    mutating func createColorPallet(){
        colorBoard[0].color = 1
        colorBoard[1].color = 2
        colorBoard[2].color = 3
        colorBoard[3].color = 4
        colorBoard[4].color = 5
        colorBoard[5].color = 6
    }
    
    
    mutating func setGuess(row: Int, slotNumber: Int, color: Int) {
        gameBoard[row][slotNumber].slotType = SlotType.gameSlot(representing: slotNumber, value: color)
        gameBoard[row][slotNumber].available = false
        gameBoard[row][slotNumber].color = color
    }
    
    mutating func checkCode(row: Int) -> Bool{
        var colorOneCountCode = 0
        var colorTwoCountCode = 0
        var colorThreeCountCode = 0
        var colorFourCountCode = 0
        var colorFiveCountCode = 0
        var colorSixCountCode = 0
        
        var colorOneCountGuess = 0
        var colorTwoCountGuess = 0
        var colorThreeCountGuess = 0
        var colorFourCountGuess = 0
        var colorFiveCountGuess = 0
        var colorSixCountGuess = 0
        
        var numberGray = 0
        var numberBlack = 0
        var didTheyWin = false
        var count = 0
        
        for i in 0..<4{
            if gameBoard[row][i].color == 1 {
                colorOneCountGuess = colorOneCountGuess + 1
            } else if gameBoard[row][i].color == 2 {
                colorTwoCountGuess = colorTwoCountGuess + 1
            } else if gameBoard[row][i].color == 3 {
                colorThreeCountGuess = colorThreeCountGuess + 1
            } else if gameBoard[row][i].color == 4 {
                colorFourCountGuess = colorFourCountGuess + 1
            } else if gameBoard[row][i].color == 5 {
                colorFiveCountGuess = colorFiveCountGuess + 1
            } else if gameBoard[row][i].color == 6 {
                colorSixCountGuess = colorSixCountGuess + 1
            }
            
            if codeBoard[i].color == 1{
                colorOneCountCode = colorOneCountCode + 1
            } else if codeBoard[i].color == 2 {
                colorTwoCountCode = colorTwoCountCode + 1
            } else if codeBoard[i].color == 3 {
                colorThreeCountCode = colorThreeCountCode + 1
            } else if codeBoard[i].color == 4 {
                colorFourCountCode = colorFourCountCode + 1
            } else if codeBoard[i].color == 5 {
                colorFiveCountCode = colorFiveCountCode + 1
            } else if codeBoard[i].color == 6 {
                colorSixCountCode = colorSixCountCode + 1
            }
        }
        
        if colorOneCountCode > 0 {
            if colorOneCountGuess > colorOneCountCode{
                numberGray = numberGray + colorOneCountCode
            } else if colorOneCountGuess <= colorOneCountCode{
                numberGray = numberGray + colorOneCountGuess
            }
        }
        
        if colorTwoCountCode > 0{
            if colorTwoCountGuess > colorTwoCountCode{
                numberGray = numberGray + colorTwoCountCode
            } else if colorTwoCountGuess <= colorTwoCountCode{
                numberGray = numberGray + colorTwoCountGuess
            }
        }
        
        if colorThreeCountCode > 0{
            if colorThreeCountGuess > colorThreeCountCode{
                numberGray = numberGray + colorThreeCountCode
            } else if colorThreeCountGuess <= colorThreeCountCode{
                numberGray = numberGray + colorThreeCountGuess
            }
        }
        
        if colorFourCountCode > 0{
            if colorFourCountGuess > colorFourCountCode{
                numberGray = numberGray + colorFourCountCode
            } else if colorFourCountGuess <= colorFourCountCode{
                numberGray = numberGray + colorFourCountGuess
            }
        }
        
        if colorFiveCountCode > 0{
            if colorFiveCountGuess > colorFiveCountCode{
                numberGray = numberGray + colorFiveCountCode
            } else if colorFiveCountGuess <= colorFiveCountCode{
                numberGray = numberGray + colorFiveCountGuess
            }
        }
        
        if colorSixCountCode > 0{
            if colorSixCountGuess > colorSixCountCode{
                numberGray = numberGray + colorSixCountCode
            } else if colorSixCountGuess <= colorSixCountCode{
                numberGray = numberGray + colorSixCountGuess
            }
        }
        
        if gameBoard[row][0].color == codeBoard[0].color{
            numberGray = numberGray - 1
            numberBlack = numberBlack + 1
        }
        
        if gameBoard[row][1].color == codeBoard[1].color {
            numberGray = numberGray - 1
            numberBlack = numberBlack + 1
        }
        
        if gameBoard[row][2].color == codeBoard[2].color {
            numberGray = numberGray - 1
            numberBlack = numberBlack + 1
        }
        
        if gameBoard[row][3].color == codeBoard[3].color {
            numberGray = numberGray - 1
            numberBlack = numberBlack + 1
        }
        
        count = numberBlack
        
        for i in 0..<4{
            if numberBlack > 0{
                gameBoard[row][i].correct = 1
                numberBlack = numberBlack - 1
            } else if numberBlack == 0 && numberGray > 0{
                gameBoard[row][i].correct = 2
                numberGray = numberGray - 1
            }
        }
        
        if count == 4{
            didTheyWin = true
        }
        
        numGuesses = numGuesses - 1
        
        if numGuesses == 0{
            outOfGuesses = true
        }
        
        return didTheyWin
    }
        
    func isSlotOpened(row: Int, slotNumber: Int) -> Bool{
        return gameBoard[row][slotNumber].available
    }
        
    func checkIfRowDone(row: Int) -> Bool {
        if gameBoard[row][0].available == false && gameBoard[row][1].available == false && gameBoard[row][2].available == false && gameBoard[row][3].available == false {
            return true;
        }
        return false;
    }
}

enum SlotType: Comparable{
    case gameSlot (representing: Int, value: Int)
    case codeSlot
    case colorSlot
    case checkSlot
}

struct Slot {
    var slotType : SlotType
    var available = true
    var correct = 0
    var color = 0
}

