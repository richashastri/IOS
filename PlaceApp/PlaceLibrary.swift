//
//  PlaceLibrary.swift
//  RichaGeo
//
//  Created by rshastri on 2/28/17.
//  Copyright © 2017 rshastri. All rights reserved.
//
// Copyright 2017 Richa Shastri
//
//
//I give the full right to Dr lindquist and Arizona State University to build my project and evaluate it or the purpose of determining your grade and program assessment.
//
//Purpose: The place library class that contains the hashmap for place name and its description
//
// Ser423 Mobile Applications
//see http://pooh.poly.asu.edu/Mobile
//@author Richa Shastri Richa.Shastri@asu.edu
//        Software Engineering, CIDSE, ASU Poly
//@version March 02, 2017
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
