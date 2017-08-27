//
//  PokemoDetailVC.swift
//  Pokedex
//
//  Created by Parth Tamane on 24/08/17.
//  Copyright © 2017 Parth Tamane. All rights reserved.
//

import UIKit

class PokemoDetailVC: UIViewController {

    var pokemon: Pokemon!
    
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var heightLbl: UILabel!
    @IBOutlet weak var defenceLbl: UILabel!
    @IBOutlet weak var pokedexLbl: UILabel!
    @IBOutlet weak var weightLbl: UILabel!
    @IBOutlet weak var typeLbl: UILabel!
    @IBOutlet weak var attackLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var pokemonNameLbl: UILabel!
    @IBOutlet weak var currentEvoImg: UIImageView!
    @IBOutlet weak var nextEvoImg: UIImageView!
    @IBOutlet weak var evoLbl: UILabel!
    
    @IBAction func backPressed(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pokemonNameLbl.text = pokemon.name.capitalized
        
        let img = UIImage(named: "\(pokemon.pokedexId)" )
        pokedexLbl.text = "\(pokemon.pokedexId)"
        mainImage.image = img
        currentEvoImg.image = img

        
        pokemon.downloadPokemonDetails {
            
            
            self.updateUI()
        }
    }
    
    func updateUI() {
        
        attackLbl.text = pokemon.attack
        defenceLbl.text = pokemon.defense
        heightLbl.text = pokemon.height
        weightLbl.text = pokemon.weight
        typeLbl.text = pokemon.type
        descriptionLbl.text = pokemon.description
        
        if pokemon.nextEvolId == "" {
            
            evoLbl.text = "No Evolution"
            nextEvoImg.isHidden = true
            currentEvoImg.isHidden = true
            
        } else {
            nextEvoImg.isHidden = false
            currentEvoImg.isHidden = false
            nextEvoImg.image = UIImage(named: pokemon.nextEvolId)
            let str = "Next Evolution: \(pokemon.nextEvolName) - LVL \(pokemon.nextEvolLvl)"
            evoLbl.text = str 
            
        }
        
    }


}
