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
            
            VStack {
                Text("\(glucoseReading)")
                    .font(.footnote)
                    .fontWeight(.black)
//                Text("\(timeLabel)")
//                    .font(.footnote)
//                    .fontWeight(.regular)
            }
            .padding(8)
            .background(.ultraThickMaterial)
            .cornerRadius(16.0)
            .offset(y: -8)

            //Text("\(timeLabel)").fontWeight(.regular)
        }
    }
}

struct CellView_Previews: PreviewProvider {
    
    static var previews: some View {
        Group {
            CellView(assetID: "abc", glucoseReading: "120", timeLabel: "13:34")
            .previewDevice("iPhone 11")
            .environment(\.sizeCategory, .accessibilityExtraExtraExtraLarge)
        }
    }
}
