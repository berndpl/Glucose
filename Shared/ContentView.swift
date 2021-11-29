//
//  ContentView.swift
//  Shared
//
//  Created by Bernd Plontsch on 28.06.20.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var model: Model
    
    @State var fileContent = ""
    
    @State private var showDocumentPicker = false
    @State private var showPhotoPicker = false
    
    @State private var selectedSegement = 0
    
    var columns: [GridItem] = [
        GridItem(.adaptive(minimum: 120.0))
        ]
        
    var body: some View {
        NavigationView {
        ScrollView {
//            Picker("What is your favorite color?", selection: $selectedSegement) {
//                            Text("Best").tag(0)
//                            Text("Worst").tag(1)
//                        }
//                        .pickerStyle(.segmented)
                    LazyVGrid(
                        columns: columns,
                        alignment: .center,
                        spacing: 8,
                        pinnedViews: [.sectionHeaders, .sectionFooters]
                    )
                        {
                                ForEach(model.foodItems, id: \.self) { item in
                                    CellView(assetID: item.assetID, glucoseReading: model.glucoseRating(date: item.createDate), timeLabel: item.timeLabel)
                                }
                        }
                        .padding(.top)
        }.navigationTitle("Glucose")
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarLeading) {
                Button(action: {
                    model.didTapDeleteAll()
                }) {
                    Text("Delete All")
                }
            }
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                Button(action: {
                    showDocumentPicker = true
                }) {
                    Image(systemName: "square.and.arrow.down")
                }.sheet(isPresented: self.$showDocumentPicker) {
                    DocumentPicker(model: model, fileContent:$fileContent)
                }

            }
        }
        .toolbar {
            ToolbarItemGroup(placement: .primaryAction) {
                Button {
                    showPhotoPicker = true
                } label: {
                    Image(systemName: "plus.circle.fill")
                }
            }
        }.sheet(isPresented: self.$showPhotoPicker) {
            PhotoPicker(model: model, showPhotoPicker: $showPhotoPicker)
        }
        
        }
        
}
    
    func delete(at offsets: IndexSet) {
        model.items.remove(atOffsets: offsets)
    }

    func deleteFoodItem(at offsets: IndexSet) {
        model.foodItems.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        Group {
            let model = Model(items:[
                Item(glucose: 230.0, createDate: Date().addingTimeInterval(80000)),
                Item(glucose: 240.0, createDate: Date()),
                Item(glucose: 250.0, createDate: Date())
            ])
            
            ContentView(model: model)
        }
    }
}


