//
//  Model.swift
//  test_reichl
//
//  Created by Reichl Sarah on 26.01.22.
//

import Foundation

class CovidInfo{
    
    let state : String
    let fzHosp : Int
    let fzICU : Int
    
    init(state: String,fzHosp:Int, fzICU:Int) {
        self.state = state
        self.fzHosp = fzHosp
        self.fzICU = fzICU
    }
}
