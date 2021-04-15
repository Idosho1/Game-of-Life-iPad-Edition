//
//  TableView.swift
//  Game of Life iPad Edition
//
//  Created by Ido Shoshani on 4/15/21.
//

import SwiftUI
import Combine
import Foundation

struct TableView: View {
   //@StateObject private var colonyData : ColonyData = ColonyData(colonys:[Colony(size: 60)])
    @EnvironmentObject var colonyData : ColonyData
    
    var colonys: [Colony] {
        return colonyData.colonys
   }

    
    var body: some View {
        NavigationView {
            List {
                ForEach(colonyData.colonys) { colony in
                    NavigationLink("Colony - Generation #\(colony.generationNumber)",destination:ContentView(colony:colony))

                }
                .onDelete(perform: deleteItems)
                .onMove(perform: moveItems)
            }.animation(.easeIn).listStyle(PlainListStyle())
            .navigationBarTitle(Text("Colonys"))
            .navigationBarItems(trailing:Button("Add",action: addColony))

        }
        

}
    

    func addColony() {
        let newColony = Colony(size:60)
        colonyData.colonys.append(newColony)
    }
    
    func deleteItems(at offsets: IndexSet) {
        colonyData.colonys.remove(atOffsets: offsets)
    }
    
    func moveItems(from source: IndexSet, to destination: Int) {
        colonyData.colonys.move(fromOffsets: source, toOffset: destination)
    }


}

 
struct TableView_Previews: PreviewProvider {
    static var previews: some View {
        TableView().environmentObject(ColonyData())
    }

}
