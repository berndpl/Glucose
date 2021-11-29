//
//  CellView.swift
//  iOS
//
//  Created by Bernd on 28.11.21.
//

import SwiftUI

struct CellView: View {
    
    let assetID:String
    let glucoseReading:String
    let isBad:Bool
    let timeLabel:String
    
    var body: some View {
        ZStack(alignment: .bottom) {
            GeometryReader { geometry in
                Image(uiImage:  PhotoLoader().loadImage(assetIdentifier: assetID)!)
                    .resizable()
                    .scaledToFill()
                    .frame(height: geometry.size.width)
                    .cornerRadius(geometry.size.height/2)
            }
            .clipped()
            .aspectRatio(1, contentMode: .fit)
            .opacity(glucoseReading == "?" ? 0.2 : 1.0)
            
            if glucoseReading != "?" {
            VStack {
                    Text("\(glucoseReading)")
                        .font(.footnote)
                        .fontWeight(.black)
                        .foregroundColor(isBad ? Color.red : Color.primary)
            }
            .padding(8)
//                if isBad {
//                    .background(Color.pink)
//                } else {
//                }
            .background(.thickMaterial )
            .cornerRadius(16.0)
            .offset(y: -10)
            }
        }
    }
}

struct CellView_Previews: PreviewProvider {
    
    static var previews: some View {
        Group {
            CellView(assetID: "abc", glucoseReading: "120", isBad: false, timeLabel: "13:34")
            .previewDevice("iPhone 11")
            .environment(\.sizeCategory, .accessibilityExtraExtraExtraLarge)
        }
    }
}
