//
//  LocationViewModel.swift
//  OnlineGroceriesApp
//
//  Created by Prince on 26/07/24.
//

import Foundation
class LocationViewModel:
ObservableObject{
    
    static var shared: LocationViewModel = LocationViewModel()
    @Published var txtYourZone: String = ""
    @Published var txtYourArea: String = ""

}
