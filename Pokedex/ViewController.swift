//
//  ViewController.swift
//  Pokedex
//
//  Created by Emil Møller Lind on 03/10/2016.
//  Copyright © 2016 Emil Møller Lind. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var seachBar: UISearchBar!
    @IBAction func musicCtl(_ sender: UIButton) {
    
        
        if musicPlayer.isPlaying {
            musicPlayer.pause()
            sender.alpha = 0.5
        } else {
            musicPlayer.play()
            sender.alpha = 1.0
        }
    }
    
    var pokemonsArray = [Pokemon]()
    var filteredPokemonsArray = [Pokemon]()
    var musicPlayer: AVAudioPlayer!
    var isInSeachMode = false
    var shouldBeginEditing = true

    override func viewDidLoad() {
        super.viewDidLoad()
        self.seachBar.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        
        seachBar.returnKeyType = UIReturnKeyType.done
        seachBar.enablesReturnKeyAutomatically = false
        parseCSVFile()
        initAudio()
    }
    
    func initAudio() { // prepare audio for playing
        let path = Bundle.main.path(forResource: "music", ofType: "mp3")
        
        do {
        
        musicPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path!))
            musicPlayer.prepareToPlay()
            musicPlayer.numberOfLoops = -1
            musicPlayer.play()
        
        } catch let err as NSError {
            print(err.debugDescription)
        }
        
    }
    
    func parseCSVFile() { // parse though the csv file, to retrive names and pokeID
        
        let path = Bundle.main.path(forResource: "pokemon", ofType: "csv")
        do {
           let csv = try CSV(contentsOfURL: path!)
            let rows = csv.rows
            
            for row in rows {
                let identifier = row["identifier"]
                let pokeId = Int(row["id"]!)
                let poke = Pokemon(name: identifier!, pokedexID: pokeId!)
                pokemonsArray.append(poke)
                
                
            }
            print(rows)
            
            
            
        } catch
            let err as NSError {
                print(err.debugDescription)
        }
        }
        
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokeCell", for: indexPath) as? PokeCell {
            
            if isInSeachMode != true {
                let poke = pokemonsArray[indexPath.row]
                cell.configeCell(poke)
                return cell
            } else {
                let filteredPokeCell = filteredPokemonsArray[indexPath.row]
                cell.configeCell(filteredPokeCell)
                return cell
            }
            
        } else {
            return UICollectionViewCell()
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("")
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
       return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isInSeachMode {
            return filteredPokemonsArray.count
        } else {
            return pokemonsArray.count
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 115, height: 115)
    }
   
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if seachBar.isFirstResponder {
            shouldBeginEditing = true
        
        if seachBar.text == nil || seachBar.text == "" {
            isInSeachMode = false
            collectionView.reloadData()
            view.endEditing(true)
        } else {
        isInSeachMode = true
            let lowerCased = seachBar.text!.lowercased()
            filteredPokemonsArray = pokemonsArray.filter({$0.name.range(of: lowerCased) != nil})
            collectionView.reloadData()
        }
        } else {
            shouldBeginEditing = false
            isInSeachMode = false
            collectionView.reloadData()
        }
    }
    
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        let returnBool = shouldBeginEditing
        shouldBeginEditing = true
        return returnBool
    }
    
}

