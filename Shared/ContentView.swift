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
    
    var body: some View {
            NavigationView {
                List {
                    //Text(fileContent)
                    ForEach(model.headers, id: \.self) { header in
                        Section(header: Text(header, style: .date)) {
                                        ForEach(model.groupedByDate[header]!) { item in
                                            Text("\(item.glucose)")
                            }
                        }
                    }.onDelete(perform: delete).navigationTitle("Glucose")
                }.listStyle(SidebarListStyle())
                .toolbar {
                    ToolbarItemGroup(placement: .navigationBarTrailing) {
                        Button(action: {
                            showDocumentPicker = true
                            print("Button action")
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
                            print("add reading")
                        } label: {
                            Image(systemName: "plus.circle.fill")
                        }

                    }
                }
            }
    }
    
    func delete(at offsets: IndexSet) {
        model.items.remove(atOffsets: offsets)
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
