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
    
    @EnvironmentObject var colonyData: ColonyData
    
    @State var colony = Colony(size: 60)
    
    @State var setState = false
    
    @State var setAlive: Bool? = nil
    
    @State var timeMultiplier = 1.0
    
    @State var play = false
    
    var body: some View {
        
        let timer = Timer.publish(every: TimeInterval(1.0/timeMultiplier), on: .main, in: .common).autoconnect()
        
        let dragGesture = DragGesture(minimumDistance: 0, coordinateSpace: .local)
            .onChanged { value in
                let xPos = value.location.x - 16.5 - 50
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
            .offset(x: 50)
            .padding()
            .gesture(dragGesture)
            
            
            
            VStack {
                
                VStack {
                    Text("Colony Name").font(.largeTitle)
                    Text("Generation #\(colony.generationNumber)").font(.title2)
                    
                    Picker(selection: $play, label: EmptyView()) {
                        Image(systemName: "pause.fill").tag(false)
                        Image(systemName: "play.fill").tag(true)
                    }
                    .pickerStyle(SegmentedPickerStyle()).padding(.horizontal,60).padding(.top)
                    
                    
                }.offset(x: -70).padding(.top,35)
                
                
                
                
                Spacer()
                HStack {
                    Text("0x").fontWeight(.bold).rotationEffect(.degrees(90.0), anchor: .center)
                    Slider(
                        value: $timeMultiplier,
                        in: 0...10,
                        step: 0.5
                    )
                    Text("10x").fontWeight(.bold).rotationEffect(.degrees(90.0), anchor: .center)
                }
                .rotationEffect(.degrees(-90.0), anchor: .topLeading)
                .frame(width: 500)
                .offset(y: 250)
                Spacer()
            }.offset(x: 70)
            
            
            
        }.onReceive(timer) { _ in
            if play {
                colony.evolve()
            }
        }
        .onDisappear {
            colonyData.colonys[colonyData.colonys.firstIndex(where: {$0.id == colony.id})!] = colony
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            
    }
}
