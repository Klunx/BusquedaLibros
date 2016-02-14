//
//  ViewController.swift
//  BusquedaLibros
//
//  Created by Fernando Renteria on 9/02/2016.
//  Copyright © 2016 Fernando Renteria. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var isbn: UITextField!
    @IBOutlet weak var errorlbl: UILabel!
    @IBOutlet weak var titulolbl: UILabel!
    @IBOutlet weak var autorlbl: UILabel!
    @IBOutlet weak var publisherlbl: UILabel!
    
    @IBAction func buscarLibro(sender: UITextField) {
        errorlbl.text = ""
        autorlbl.text = ""
        publisherlbl.text = ""
        titulolbl.text = ""
        
        var mainObject : String = "ISBN:"
        let valorisbn : String = isbn.text!
        let urls = "https://openlibrary.org/api/books?jscmd=data&format=json&bibkeys=ISBN:"
        mainObject = mainObject + valorisbn
        let url = NSURL(string: urls + valorisbn)
        let JSONData = NSData(contentsOfURL: url!)
        
        if (JSONData == nil) {
            errorlbl.text = "Recurso no accesible"
        }
        else {
            do {
                let json = try NSJSONSerialization.JSONObjectWithData(JSONData!, options:NSJSONReadingOptions.MutableLeaves)
                let diccionario = json as! NSDictionary
                if (diccionario.count == 0){
                    errorlbl.text = "No hay datos disponibles"
                } else {
                    let recursos = diccionario[mainObject] as! NSDictionary
                    let titulo = recursos["title"] as! NSString as String
                    let publishers = recursos["publishers"] as! NSArray
                    let autores = recursos["authors"] as! NSArray
                    self.titulolbl.text = titulo
                    for autor in autores {
                        let tmpAutor : String = autor["name"] as! NSString as String
                        self.autorlbl.text = self.autorlbl.text! + "\(tmpAutor)\n"
                    }
                    for publisher in publishers {
                        let tmpPublisher : String = publisher["name"] as! NSString as String
                        self.publisherlbl.text = self.publisherlbl.text! + "\(tmpPublisher)\n"
                    }
                }
                
            }
            catch let JSONError as NSError {
                errorlbl.text = "\(JSONError)"
                
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

