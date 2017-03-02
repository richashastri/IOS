//
//  PlaceLibrary.swift
//  RichaGeo
//
//  Created by rshastri on 2/28/17.
//  Copyright © 2017 rshastri. All rights reserved.
//
import Foundation

class PlaceLibrary {
    var placedesc: [String : PlaceDescription] = [String:PlaceDescription]()
    var names:[String] = [String]()
    
    init() {
        
        
        if let path = Bundle.main.path(forResource: "data", ofType: "json"){
            do {
                let jsonStr:String = try String(contentsOfFile:path)
                let data:Data = jsonStr.data(using: String.Encoding.utf8)!
                let dict:[String:Any] = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! [String:Any]
                for aplacename:String in dict.keys {
                    let aplace:PlaceDescription = PlaceDescription(dict: dict[aplacename] as! [String:Any])
                    self.placedesc[aplacename] = aplace
                    //print("NEW" + aplacename)
                }
            } catch {
                print("contents of students.json could not be loaded")
            }
        }
        self.names = Array(self.placedesc.keys).sorted()
        for name in self.names{
            print(name)
            
            
        }
    }
}
