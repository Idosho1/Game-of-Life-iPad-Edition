//
//  ContentView.swift
//  Shared
//
//  Created by Ido Shoshani on 3/31/21.
//

import SwiftUI

struct ContentView: View {
    var horizontalSpacing: CGFloat = 15
    var verticalSpacing: CGFloat = 15
    
    @State var colony = Colony(size: 60)
    
    @State var setState = false
    
    @State var setAlive: Bool? = nil
    
    var body: some View {
        
        let dragGesture = DragGesture(minimumDistance: 0, coordinateSpace: .local)
            .onChanged { value in
                let xPos = value.location.x - 16.5
                let yPos = value.location.y - 17.5
                if xPos > 0 && xPos < 900 && yPos > 0 && yPos < 900 {
                    if setAlive == nil {
                        if colony.isCellAlive(Int(Double(xPos)/15), Int(Double(yPos)/15)) {
                            setAlive = false
                            colony.setCellDead(Int(Double(xPos)/15), Int(Double(yPos)/15))
                        } else {
                            setAlive = true
                            colony.setCellAlive(Int(Double(xPos)/15), Int(Double(yPos)/15))
                        }
                    } else {
                        if setAlive! {
                            colony.setCellAlive(Int(Double(xPos)/15), Int(Double(yPos)/15))
                        } else {
                            colony.setCellDead(Int(Double(xPos)/15), Int(Double(yPos)/15))
                        }
                    }
                }
            }.onEnded { _ in
                setAlive = nil
            }

        return HStack {
            GeometryReader { geometry in
                Path { path in
                    let numberOfHorizontalGridLines = Int(geometry.size.height / self.verticalSpacing)
                    let numberOfVerticalGridLines = Int(geometry.size.width / self.horizontalSpacing)
                    for index in 0...numberOfVerticalGridLines {
                        let vOffset: CGFloat = CGFloat(index) * self.horizontalSpacing
                        path.move(to: CGPoint(x: vOffset, y: 0))
                        path.addLine(to: CGPoint(x: vOffset, y: geometry.size.height))
                    }
                    for index in 0...numberOfHorizontalGridLines {
                        let hOffset: CGFloat = CGFloat(index) * self.verticalSpacing
                        path.move(to: CGPoint(x: 0, y: hOffset))
                        path.addLine(to: CGPoint(x: geometry.size.width, y: hOffset))
                    }
                }
                .stroke()
                
                ForEach(Array(colony.cellSet)) { cell in
                    Rectangle().path(in: CGRect(x: horizontalSpacing*CGFloat(cell.row),
                                                y: verticalSpacing*CGFloat(cell.col),
                                                width: horizontalSpacing,
                                                height: verticalSpacing))
                }
                
            }.frame(width: 900, height: 900)
            .padding()
            .gesture(dragGesture)
/*
            .gesture(DragGesture()
                .onChanged { value in
                    let xPos = value.location.x - 16.5
                    let yPos = value.location.y - 17.5
                    //print("\(value.location.x - 16.5),\(value.location.y - 17.5)")
                    if xPos > 0 && xPos < 900 && yPos > 0 && yPos < 900 {
                        cells.append(Coordinate(Int(Double(xPos)/15),Int(Double(yPos)/15)))
                    }
                }
            )*/
            Spacer()
            
            Button(action: {print(colony.cellSet); colony.evolve(); print(colony.cellSet)}) {
                Text("Evolve")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            
    }
}
