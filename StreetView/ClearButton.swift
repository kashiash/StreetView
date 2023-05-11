//
//  ClearButton.swift
//  StreetView
//
//  Created by Jacek Kosinski U on 11/05/2023.
//

import SwiftUI

struct ClearButton: View {
    @Binding var text: String
    var body: some View {
        if text.isEmpty == false {
            HStack{
                Spacer()
                Button{
                    text = ""
                } label: {
                    Image(systemName: "multiply.circle.fill")
                }
            }
            
        } else {
            EmptyView()
        }
    }
}

struct ClearButton_Previews: PreviewProvider {
    @State   static var value = ""
    static var previews: some View {
        ClearButton(text: $value)
    }
}
