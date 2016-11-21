//
//  Pokemon.swift
//  Pokedex
//
//  Created by Emil Møller Lind on 03/10/2016.
//  Copyright © 2016 Emil Møller Lind. All rights reserved.
//

import Foundation
import Alamofire

class Pokemon {
    
    private var _name: String!
    
    private var _pokedexID: Int!
    
    private var _description: String!
    
    private var _type: String!
    
    private var _defense: String!
    
    private var _height: String!
    
    private var _weight: String!
    
    private var _attack: String!
    
    private var _nextEvolution: String!
    
    private var _pokemonURL: String!
    
    private var _evolveLvl: String!
    
    private var _evolveName: String!
    
    private var _evolvePokeID: String!

    var evolvePokeID: String {
        
        if _evolvePokeID == nil {
            _evolvePokeID = ""
        }
        return _evolvePokeID
    }
    
    
    var evolveName: String {
        if _evolveName == nil {
            _evolveName = ""
        }
        return _evolveName
    }
    
    var evolveLvl: String {
        if _evolveLvl == nil {
            _evolveLvl = ""
        }
        return _evolveLvl
    }
    
    var nextEvolution: String {
        if _nextEvolution == nil {
            _nextEvolution = ""
        }
        return _nextEvolution
    } // end of nextEvolution
    
    var attack: String {
        if _attack == nil {
            _attack = ""
        }
        return _attack
    }
    
    var weight: String {
        if _weight == nil {
            _weight = ""
        }
        return _weight
    }
    
    var height: String {
        if _height == nil {
            _height = ""
        }
        return _height
    }
    
    var defense: String {
        if _defense == nil {
            _defense = ""
        }
        return _defense
    }
    
    var type: String {
        if _type == nil {
            _type = ""
            
        }
        return _type
    }
    
    var description: String {
        if _description == nil {
            _description = ""
        }
        return _description
        }
    
    var name: String {
        return _name
    }
    
    var pokedexID: Int {
        return _pokedexID
    }
    
    var pokemonURL: String {
        return _pokemonURL
    }
    
    init(name: String, pokedexID: Int) {
        
        self._name = name
        self._pokedexID = pokedexID
        
        self._pokemonURL = "\(BASE_URL)\(POKEAPIURL)\(self.pokedexID)"
        
    } // end of init
    
    func downloadPokemonDetail(completed: @escaping DownloadComplete) {
        var canNotComplete: Bool!
        
        let newURL = URL(string: pokemonURL)!
        Alamofire.request(newURL).responseJSON { (response) in
            print(newURL)
            print(response.result.value)
            
            if let dict = response.result.value as? Dictionary<String, Any> {
                
                if let weight = dict["weight"] as? String {
                    
                    self._weight = weight
                } // end of weight
                
                if let height = dict["height"] as? String {
                    
                    self._height = height
                } // end of height
                
                if let types = dict["types"] as? [Dictionary<String, Any>] {
                    
                    var names = [String]()
                    for type in types {
                        if let name = type["name"] as? String {
                            names.append(name)
                    }
                        if names.count > 1 && names.count <= 2 {
                            self._type = "\(names[0].capitalized)/\(names[1])  "
                        } /* end of name */ else {
                            self._type = "\(names[0].capitalized)  "
                        } // end of else
                    } // end of loop
                
                    
                    } // end of types
                
                    if let defense = dict["defense"] as? Int {
                        self._defense = "\(defense)"
                    } // end of defense
                
                if let attack = dict["attack"] as? Int {
                    self._attack = "\(attack)"
                                    } // end of attack
                if let descriptionArray = dict["descriptions"] as? [Dictionary<String, String>], descriptionArray.count > 0 {
                    
                    if let url = descriptionArray[0]["resource_uri"] {
                        let descURL = "\(BASE_URL)\(url)"
                        
                        Alamofire.request(descURL).responseJSON(completionHandler:  { (response) in
                            
                            if let descDict = response.result.value as? Dictionary<String, Any> {
                                if let pokeDescription = descDict["description"] as? String {
                                    
                                    let newDescription = pokeDescription.replacingOccurrences(of: "POKMON", with: "pokemon")
                                    
                                    self._description = newDescription
                                    /*if self.description == "" {
                                        canNotComplete = true
                                        print("cannot complete = true")
                                    } else {
                                        print(self.description)
                                        print("cannotComplete = false")
                                        print(self.description)
                                        canNotComplete = false
                                    }*/
                                    print(self.description)
                                } // end of Pokedesc
                            
                             } // end of descDict
                        completed()
                        }) // end of response
                        
                    } // end of url
                    
                } //end of descriptionArray
                
                if let evolution = dict["evolutions"] as? [Dictionary<String, Any>] , evolution.count > 0 {
                    var canEvolve: Bool!
                    if let to = evolution[0]["to"] as? String {
                        if to.range(of: "mega") == nil {
                            canEvolve = true
                            self._evolveName = to
                            } else {
                            canEvolve = false
                        }
                        if canEvolve == true {
                            if let level = evolution[0]["level"] as? Int {
                             self._evolveLvl = "\(level)"
                            }
                            if let resource_uri = evolution[0]["resource_uri"] as? String {
                                print("here should resource uri be: \(resource_uri)")
                                let newResourceUri = resource_uri.replacingOccurrences(of: "/api/v1/pokemon/", with: "")
                                let nextPokeID = newResourceUri.replacingOccurrences(of: "/", with: "")
                                self._evolvePokeID = nextPokeID
                                print(nextPokeID)
                            }
                        }
                    }
                }
                
                    
                
                
                
                print("\(self._weight), \(self._height),  \(self._type), \(self._attack)")
                //print(self.description)
            
            
           
        } // end of dict
    } // end of request function
    } // end of downloadFunction
    
} // end of class
