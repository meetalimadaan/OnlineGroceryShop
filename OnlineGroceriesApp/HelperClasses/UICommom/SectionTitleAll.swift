//
//  SectionTitleAll.swift
//  OnlineGroceriesApp
//
//  Created by meetali on 18/07/24.
//

import SwiftUI

struct SectionTitleAll: View {
    
    @State var title: String = "Title"
//
    var body: some View {
        HStack{
            
            Text(title)
                .font(.customfont(.semibold, fontSize: 20))
                .foregroundColor(.primaryText)

            
            Spacer()
       
        }
        .frame(height: 40)
    }
}

#Preview {
    SectionTitleAll()
        .padding(20)
}
