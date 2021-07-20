//
//  MasterMindViewModel.swift
//  MasterMind
//
//  Created by Cinthya Rosales on 3/07/21.
//

import Foundation

class MasterMindViewModel: ObservableObject {
    
    @Published var gameModel = MasterMindModel()
    
    var _gameInProgress = false
    var _gameWinner = false
    var _color = 0
    var _colorPicked = false
    var _rowDone = [Bool](repeating: false, count: 8)
    var _noTurnsLeft = false
    
    func gameInProgress() -> Bool {
        return _gameInProgress
    }
    
    func setCode() {
        gameModel.createGame()
        _gameInProgress = true
    }
    
    func reset() {
        gameModel = MasterMindModel()
        _gameInProgress = false
        _gameWinner = false
    }
    
    func didTapSlot(Row:Int, Slot: Int){
        if gameModel.isSlotOpened(row: Row, slotNumber: Slot){
            if _colorPicked == true{
                gameModel.setGuess(row: Row, slotNumber: Slot, color: _color)
                _rowDone[Row] = gameModel.checkIfRowDone(row: Row)
            }
            _color = 0
            _colorPicked = false
        }
        
        _noTurnsLeft = gameModel.outOfGuesses
        
        if winner(rowNumber: Row) {
            _gameWinner = true
        }
    }
    
    func pickedColor(color: Int){
        _color = color + 1
        _colorPicked = true
    }
    
    func winner(rowNumber:Int) ->Bool {
        return gameModel.checkCode(row: rowNumber)
    }
    
    func colorsAt(colors: Int) -> Slot {
        gameModel.colorBoard[colors]
    }
    
    func codeAt(slotNumber: Int) -> Slot {
        gameModel.codeBoard[slotNumber]
    }
    
    func slotAt (row: Int, slotNumber: Int)-> Slot{
        gameModel.gameBoard[row][slotNumber]

    }
    
}
