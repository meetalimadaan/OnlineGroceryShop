//
//  ExploreVireModel.swift
//  OnlineGroceriesApp
//
//  Created by meetali on 19/07/24.
//

import SwiftUI

class ExploreVireModel: ObservableObject {
    
    static var shared: ExploreVireModel = ExploreVireModel()
    
    @Published var selectTab: Int = 0
    @Published var txtSearch: String = ""
}

