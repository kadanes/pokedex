//
//  Pokemon.swift
//  Pokedex
//
//  Created by Parth Tamane on 15/08/17.
//  Copyright © 2017 Parth Tamane. All rights reserved.
//

import Foundation
import Alamofire

class Pokemon {
    
    private var _name: String!
    private var _pokedexId: Int!
    private var _description: String!
    private var _type: String!
    private var _defense: String!
    private var _height: String!
    private var _weight: String!
    private var _attack: String!
    private var _nextEvoTxt: String!
    private var _nextEvolName: String!
    private var _nextEvolId: String!
    private var _nextEvolLvl: String!
    private var _pokemonURL: String!
    
    
    var nextEvolLvl: String {
        if _nextEvolLvl == nil {
            
            _nextEvolLvl = ""
        }
        
        return _nextEvolLvl
    }
    
    var nextEvolName: String {
        
        if _nextEvolName == nil {
            
            _nextEvolName = ""
        }
        
        return _nextEvolName
    }
    
    var nextEvolId: String {
        
        if _nextEvolId == nil {
            
            _nextEvolId =  ""
            
        }
        
        return _nextEvolId
    }
    
    var description: String {
        
        if _description == nil {
            
            _description = ""
        }
        
        return _description
    }
    
    var type: String {
        
        if _type == nil {
            
            _type = "Empty"
            
        }
        
        return _type
    }
    
    var defense: String {
        
        if _defense == nil {
            
            _defense = "Empty"
            
        }
        
        return _defense
    }
    
    var height: String {
        
        if _height == nil {
            
            _height = "Empty"
            
        }
        
        return _height
    }
    
    var weight: String {
        
        if _weight == nil {
            
            _weight = "Emptty"
            
        }
        
        return _weight
    }
    
    var attack: String {
        
        if _attack == nil {
            _attack = "Empty"
        }
        
        return _attack
    }
    
    var nextEvoTxt: String {
        if _nextEvoTxt == nil {
           
            _nextEvoTxt = " Empty"
        
        }
        
        return _nextEvoTxt
    }
    
    
    var name: String {
        
        return _name
    }
    
    var pokedexId: Int {
        
        return _pokedexId
    }
    
    
    
    init(name: String, pokedexId: Int) {
        self._name = name
        self._pokedexId = pokedexId
        
        self._pokemonURL = "\(URL_Base)\(URL_Pokemon)\(self.pokedexId)/"
        
    }
    
    func downloadPokemonDetails(completed: @escaping DownloadComplete) {
        
        Alamofire.request(_pokemonURL).responseJSON { (response) in
           
            if let dict = response.result.value as? Dictionary<String, AnyObject> {
                
                if let weight = dict["weight"] as? String {
                    
                    self._weight = weight
                }
                
                if let height = dict["height"] as? String {
                    
                    self._height = height
                }
                
                if let attact = dict["attack"] as? Int {
                    
                    self._attack = "\(attact)"
                    
                }
                
                if let defense = dict["defense"] as? Int {
                    
                    self._defense = "\(defense)"
                }
                
                if let types = dict["types"] as? [Dictionary<String, String>] , types.count > 0 {
                    
                    if let name = types[0]["name"] {
                        
                        self._type = name.capitalized

                    }
                    
                    if types.count > 1 {
                        
                        for x in 1..<types.count {
                            
                            if let name = types[x]["name"] {
                                
                                self._type! += "/\(name.capitalized )"
                            }
                            
                        }
                        
                    }
                } else {
                    
                    self._type = ""
                }
                
                if let descArr = dict["descriptions"] as? [Dictionary<String,String>] , descArr.count > 0 {
                    
                    if let URL = descArr[0]["resource_uri"] {
                        
                        
                        
                        let descriptionURL = "\(URL_Base)\(URL)"
                        
                        
                        
                        Alamofire.request(descriptionURL).responseJSON { (response) in
                                if let descDict =  response.result.value as? Dictionary<String, AnyObject> {
    
                                    if let description = descDict["description"] as? String {
                                        
                                        let newDescription = description.replacingOccurrences(of: "POKMON", with: "pokemon")
                                        
                                        self._description = newDescription
                                    }
                                    
                                }
                            completed()
                                
                            }
                        
                }
                
                
                } else {
                    self._description = ""
                }
                
                if let evolutions = dict["evolutions"] as? [Dictionary<String,AnyObject>] , evolutions.count > 0 {
                    
                    if let nextEvo = evolutions[0]["to"] as? String {
                        
                        if nextEvo.range(of: "mega") == nil {
                            
                            self._nextEvolName = nextEvo
                            
                            if let uri = evolutions[0]["resource_uri"] as? String {
                                
                                print(uri)
                                let newStr = uri.replacingOccurrences(of: "api/v1/pokemon/",with:"")
                                let nextEvoId = newStr.replacingOccurrences(of: "/",with:"")
                                
                                self._nextEvolId = nextEvoId
                                
                               
                                if let lvlExist = evolutions[0]["level"] {
                                    
                                    
                                    if let lvl = lvlExist as? Int {
                                        self._nextEvolLvl = "\(lvl)"
                                        
                                    }
                                    
                                } else {
                                    
                                    self._nextEvolLvl = ""
                                    
                                }
                            }
                            
                        }
                    }
                    
                    print(self.nextEvolLvl)
                    print(self.nextEvolName)
                    print(self.nextEvolId)
                }
           }
        
            completed()
        }
    }
}
