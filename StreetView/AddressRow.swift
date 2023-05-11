//
//  AddressRow.swift
//  StreetView
//
//  Created by Jacek Kosinski U on 11/05/2023.
//

import SwiftUI

struct AddressRow: View {
    let address:AddressResult
    var body: some View {
        NavigationLink{
            MapView2(address: address)
            
            
            
            
        } label: {
            VStack(alignment: .leading) {
                Text(address.title)
                Text(address.subtitle)
                    .font(.caption)
            }
        }
        .padding(.bottom,2)
    }
}

struct AddressRow_Previews: PreviewProvider {
    static var previews: some View {
        AddressRow(address: AddressResult.example)
    }
}
