//
//  Pokemon.swift
//  Pokedex
//
//  Created by Emil Møller Lind on 03/10/2016.
//  Copyright © 2016 Emil Møller Lind. All rights reserved.
//

import Foundation

class Pokemon {
    
    fileprivate var _name: String!
    
    fileprivate var _pokedexID: Int!
    
    var name: String {
        return _name
    }
    
    var pokedexID: Int {
        return _pokedexID
    }
    
    init(name: String, pokedexID: Int) {
        
        self._name = name
        self._pokedexID = pokedexID
    }
    
    
    
}
