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
    
    var columns: [GridItem] = [
        GridItem(.adaptive(minimum: 100.0))
        ]
        
    var body: some View {
        NavigationView {
        ScrollView {
                    LazyVGrid(
                        columns: columns,
                        alignment: .center,
                        spacing: 16,
                        pinnedViews: [.sectionHeaders, .sectionFooters]
                    )
                        {
                                ForEach(model.foodItems, id: \.self) { item in
                                    let foodInfo = model.glucoseRating(date: item.createDate)
                                    CellView(assetID: item.assetID, glucoseReading: foodInfo.label, isBad: foodInfo.isBad, timeLabel: item.timeLabel)
                                        .contextMenu {
                                            Button(
                                                role: .destructive,
                                                action: {
                                                    print("delete")
                                                    }
                                            ) {
                                                Text("Delete food")
                                                Image(systemName: "trash")
                                            }
                                        }
                                }
                        }
                        .padding(.all)
            Text("\(model.items.count) Measurements \n \(model.lastItem())")
                .font(.footnote)
                .multilineTextAlignment(.center)
                .lineLimit(nil)
                .tint(.secondary)
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


