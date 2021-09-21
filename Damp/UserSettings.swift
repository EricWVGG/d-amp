//
//  UserSettings.swift
//  d’AMP
//
//  Created by Eric Jacobsen on 9/15/21.
//

import Foundation

class UserSettings: ObservableObject {
    @Published var whiteList: [String] {
        didSet {
            UserDefaults.standard.set(whiteList, forKey: "whiteList")
        }
    }
    
    init() {
        self.whiteList = UserDefaults.standard.object(forKey: "whiteList") as? [String] ?? ["example.com"]
    }
}
