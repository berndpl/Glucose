//
//  SnackedApp.swift
//  Shared
//
//  Created by Bernd Plontsch on 28.06.20.
//

import SwiftUI

@main
struct SnackedApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(model: Model())
        }
    }
}

struct SnackedApp_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
