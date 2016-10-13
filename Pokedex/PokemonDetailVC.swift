//
//  PokemonDetailVC.swift
//  Pokedex
//
//  Created by Emil Møller Lind on 07/10/2016.
//  Copyright © 2016 Emil Møller Lind. All rights reserved.
//

import UIKit

class PokemonDetailVC: UIViewController {

    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var mainImg: UIImageView!
    @IBOutlet weak var describtionLbl: UILabel!
    @IBOutlet weak var typeLbl: UILabel!
    @IBOutlet weak var defenseLbl: UILabel!
    @IBOutlet weak var heighLbl: UILabel!
    @IBOutlet weak var pokedexIDLbl: UILabel!
    @IBOutlet weak var weightLbl: UILabel!
    @IBOutlet weak var baseAttackLbl: UILabel!
    @IBOutlet weak var evolutionLbl: UILabel!
    @IBOutlet weak var currentEvoImg: UIImageView!
    @IBOutlet weak var nextEvoImg: UIImageView!
    @IBOutlet weak var evolutionArrow: UIImageView!
    
    @IBAction func backBtn(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
        
    }
    
    func updateUI() {
        print("did arrive")
        self.heighLbl.text = destinationPokemon.height
        self.weightLbl.text = destinationPokemon.weight
        self.typeLbl.text = destinationPokemon.type
        self.defenseLbl.text = destinationPokemon.defense
        self.baseAttackLbl.text = destinationPokemon.attack
        self.pokedexIDLbl.text = "\(destinationPokemon.pokedexID)"
        self.currentEvoImg.image =  UIImage(named: "\(destinationPokemon.pokedexID)")
        self.mainImg.image = UIImage(named: "\(destinationPokemon.pokedexID)")
        self.describtionLbl.text = destinationPokemon.description
        
        if destinationPokemon.evolveName != "" && destinationPokemon.evolveLvl != "" {
            self.evolutionArrow.isHidden = false
            self.evolutionLbl.text = "Next evolution: \(destinationPokemon.evolveName) at LVL: \(destinationPokemon.evolveLvl)"
            self.nextEvoImg.image = UIImage(named:"\(destinationPokemon.evolvePokeID)")
        } else {
            self.evolutionLbl.text = "No further evolutions"
            self.nextEvoImg.isHidden = true
            self.evolutionArrow.isHidden = true
        }
        
    }
    
    
    
    var destinationPokemon: Pokemon!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        destinationPokemon.downloadPokemonDetail {
            self.updateUI()
        }
        
        
        
        // Do any additional setup after loading the view.
        nameLbl.text = destinationPokemon.name.capitalized
        self.evolutionArrow.isHidden = true
        
    }



}
