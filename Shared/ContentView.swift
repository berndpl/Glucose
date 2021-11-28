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
    
    var body: some View {
            NavigationView {
                List {
                    ForEach(model.foodItems, id: \.self) { item in
                        VStack {
                            Image(uiImage:  PhotoLoader().loadImage(assetIdentifier: item.assetID)!)
                            HStack {
                                Text("\(model.glucoseRating(date:item.createDate))")
                                    .fontWeight(.bold)
                                Text("\(item.timeLabel)")
                                    .fontWeight(.regular)
                            }
                        }
                    }.onDelete(perform: deleteFoodItem)
                    ForEach(model.headers, id: \.self) { header in
                        Section(header: Text(header, style: .date)) {
                                        ForEach(model.groupedByDate[header]!) { item in
                                            HStack {
                                                Text("\(item.glucoseLabel)")
                                                Text("\(item.timeLabel)")
                                                    .font(.caption)
                                            }
                                            
                            }
                        }
                    }.onDelete(perform: delete).navigationTitle("Glucose")
                }.listStyle(SidebarListStyle())
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
                        }.sheet(isPresented: self.$showPhotoPicker) {
                            PhotoPicker(model: model, showPhotoPicker: $showPhotoPicker)
                        }
                    }
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
