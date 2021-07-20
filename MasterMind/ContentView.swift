//
//  ContentView.swift
//  MasterMind
//
//  Created by Cinthya Rosales on 3/07/21.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var viewModel = MasterMindViewModel()
    
    let spacing: CGFloat = 0.0
    let numberOfRows = 8
    let numberOfSlots = 4
    let numberOfColors = 6
    var isVisible = false
    var numberGuesses = 32
        
    
    var body: some View {
        if viewModel.gameInProgress() && !viewModel._gameWinner {
            VStack(spacing: spacing) {
                buildCodeView(slots: numberOfSlots)
                    .padding()
                    .frame(width: 250.0, height: 75.0)
                    .hidden()
                
                buildGameView(rows: numberOfRows)
                
                buildColorPallet(colors: numberOfColors)
                    .padding()
                
                Button("New Game?") {
                    viewModel.reset()
                }
            }
            .background(
                    Image("stainless")
                        .resizable()
                        .edgesIgnoringSafeArea(.all)
                        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                )
        } else if viewModel.gameInProgress() && viewModel._gameWinner {
            winnerCircle()
        } else if  viewModel.gameInProgress() && viewModel._noTurnsLeft{
            loserCircle()
        } else {
            HStack{
                Button("Set Code") {
                    viewModel.setCode()
                }
                .foregroundColor(.black)
                .font(.headline)
                .frame(width: 120.0, height: 75.0)
                .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: 2)
            }
            .background(
                    Image("background")
                        .resizable()
                        .edgesIgnoringSafeArea(.all)
                        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                )
        }
    }
    
    func buildCodeView(slots:Int) -> some View {
        HStack(spacing: spacing) {
            slotView(slot: viewModel.codeAt(slotNumber: 0) )
            slotView(slot: viewModel.codeAt(slotNumber: 1) )
            slotView(slot: viewModel.codeAt(slotNumber: 2) )
            slotView(slot: viewModel.codeAt(slotNumber: 3) )
            
        }
    }
    
    func buildColorPallet(colors: Int) -> some View {
        HStack(spacing: spacing) {
            ForEach(0..<colors) { color in
                slotView(slot: viewModel.colorsAt(colors: color) )
                    .onTapGesture {
                        viewModel.pickedColor(color: color)
                        
                    }
            }
        }
    }
    
    
    func buildGameView(rows: Int) -> some View {
        VStack(spacing: spacing) {
            ForEach(0..<rows) {row in
                buildGameRow(rows: row, slots: numberOfSlots)
            }
        }
    }
    
    func buildGameRow(rows: Int, slots:Int) -> some View {
        HStack{
            HStack(spacing: spacing) {
                ForEach(0..<slots) { slot in
                    slotView(slot: viewModel.slotAt(row: rows, slotNumber: slot) )
                        .onTapGesture {
                            viewModel.didTapSlot(Row: rows, Slot: slot)
                        }
                }
            }
            .frame(width: 250, height: 65)
            if viewModel._rowDone[rows]{
                buildGameCheck(row: rows)
                    .frame(width: 30, height: 50)
            }
        }
        
    }
    
    
    func buildGameCheck(row: Int) -> some View {
        HStack{
            VStack{
                checkView(slot: viewModel.slotAt(row: row, slotNumber: 0))
                checkView(slot: viewModel.slotAt(row: row, slotNumber: 1))
                
            }
            VStack{
                checkView(slot: viewModel.slotAt(row: row, slotNumber: 2))
                checkView(slot: viewModel.slotAt(row: row, slotNumber: 3))
            }
        }
    }
    
    func buildSolvedCode() -> some View {
        HStack(spacing: spacing) {
            slotView(slot: viewModel.codeAt(slotNumber: 0) )
            slotView(slot: viewModel.codeAt(slotNumber: 1) )
            slotView(slot: viewModel.codeAt(slotNumber: 2) )
            slotView(slot: viewModel.codeAt(slotNumber: 3) )
        }
    }
    
    
    func winnerCircle() -> some View {
        VStack {
            Text("THE CODE WAS: ")
                .font(.headline)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .padding()
            buildSolvedCode()
                .frame(width: 250.0, height: 75.0)
            Text("CONGRATULATIONS!")
                .font(.headline)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .padding()
            Text("You broke the code")
                .padding()
            Button("Play Again"){
                viewModel.reset()
            }
            .foregroundColor(.black)
            .font(.headline)
            .frame(width: 120.0, height: 75.0)
            .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: 2)
        }
        .background(
            Image("stainless")
                .resizable()
                .edgesIgnoringSafeArea(.all)
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
    }
    
    func loserCircle() -> some View {
        VStack {
            Text("SORRY!")
                .font(.headline)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .padding()
            Text("YOU FAILED")
                .padding()
            Text("THE CODE WAS: ")
                .font(.headline)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .padding()
            buildSolvedCode()
                .frame(width: 250.0, height: 75.0)
            Button("Play Again"){
                viewModel.reset()
            }
            .foregroundColor(.black)
            .font(.headline)
            .frame(width: 120.0, height: 75.0)
            .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: 2)
        }
        .background(
            Image("stainless")
                .resizable()
                .edgesIgnoringSafeArea(.all)
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
    }
    
}

struct checkView: View {
    let slot: Slot
    
    var body: some View {
        return ZStack {
            if slot.correct == 0{
                Circle()
                    .foregroundColor(.clear)
            } else if slot.correct == 1{
                Circle()
                    .foregroundColor(.black)
            } else if slot.correct == 2{
                Circle()
                    .foregroundColor(.gray)
            }
        }
    }
}




struct slotView: View {
    let slot: Slot
    
    var body: some View {
        return ZStack {
            if slot.color == 0{
                Circle()
                    .foregroundColor(.gray)
            } else if slot.color == 1 {
                Circle()
                    .foregroundColor(.purple)
            } else if slot.color == 2 {
                Circle()
                    .foregroundColor(.blue)
            } else if slot.color == 3 {
                Circle()
                    .foregroundColor(.green)
            } else if slot.color == 4 {
                Circle()
                    .foregroundColor(.red)
            } else if slot.color == 5 {
                Circle()
                    .foregroundColor(.yellow)
            } else if slot.color == 6 {
                Circle()
                    .foregroundColor(.orange)
            }
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
