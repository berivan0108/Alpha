//
//  HeaderView.swift
//  AlphaToDoApp
//
//  Created by beri on 5.06.2026.
//

import SwiftUI

struct HeaderView: View {
    var body: some View {
        ZStack{
            Image("alpha-logo")
                .resizable()
                .frame(width: 180, height: 200)
            Text("Alpha")
                .font(.system(size: 30))
                .fontWeight(.bold)
                .padding(.top , 1)
            
            
        }.padding(.top, 100)
    
    }
}

#Preview {
    HeaderView()
}
