//
//  ViewController.swift
//  PlaceApp
//
//  Created by rshastri on 3/1/17.
//  Copyright © 2017 rshastri. All rights reserved.
//
// Copyright 2017 Richa Shastri
//
//
//I give the full right to Dr lindquist and Arizona State University to build my project and evaluate it or the purpose of determining your grade and program assessment.
//
//Purpose: The view controller that lists the description of the selected place and contains picker, edit text filed and save button
//
// Ser423 Mobile Applications
//see http://pooh.poly.asu.edu/Mobile
//@author Richa Shastri Richa.Shastri@asu.edu
//        Software Engineering, CIDSE, ASU Poly
//@version March 02, 2017

import UIKit


extension Int {
    var degreesToRadians: Double { return Double(self) * .pi / 180 }
}
extension FloatingPoint {
    var degreesToRadians: Self { return self * .pi / 180 }
    var radiansToDegrees: Self { return self * 180 / .pi }
}

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var place:PlaceLibrary = PlaceLibrary()
    var selectedplace:String = "unknown"
    
    
    @IBOutlet weak var distid: UILabel!

    @IBOutlet weak var bearing: UILabel!
    @IBOutlet weak var pickerview: UIPickerView!
    
    @IBOutlet weak var Nameid: UITextField!
        
    @IBOutlet weak var catid: UITextField!
    @IBOutlet weak var addsid: UITextField!
    @IBOutlet weak var addtid: UITextField!
    @IBOutlet weak var descid: UITextField!
    @IBOutlet weak var eleid: UITextField!
    
    @IBOutlet weak var imgid: UITextField!
    @IBOutlet weak var longid: UITextField!
    @IBOutlet weak var latid: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if(selectedplace != "unknown"){
            Nameid.text = "\(self.place.placedesc[selectedplace]!.name)"
            descid.text = "\(self.place.placedesc[selectedplace]!.description)"
            imgid.text = "\(self.place.placedesc[selectedplace]!.image)"
            addsid.text = "\(self.place.placedesc[selectedplace]!.addressStreet)"
            addtid.text = "\(self.place.placedesc[selectedplace]!.addressTitle)"
            catid.text = "\(self.place.placedesc[selectedplace]!.category)"
            latid.text = "\(self.place.placedesc[selectedplace]!.latitude)"
            longid.text = "\(self.place.placedesc[selectedplace]!.longitude)"
            eleid.text = "\(self.place.placedesc[selectedplace]!.elevation)"
            pickerview.dataSource = self
            pickerview.delegate = self
        }
        
        
    }

    @IBAction func addingfields(_ sender: Any) {
        print("save")
        let myname:String = Nameid.text!
        let mydesc:String = descid.text!
        let myimg:String = imgid.text!
        let myadds:String = addsid.text!
        let myaddt:String = addtid.text!
        let mycat:String = catid.text!
        let mylat:String = latid.text!
        let mylong:String = longid.text!
        let myele:String = eleid.text!
        
        let placedesc = PlaceDescription(name:myname, description:mydesc,category:mycat,addressTitle:myaddt, addressStreet:myadds, elevation: Double(myele)!, latitude: Double(mylat)!, longitude: Double(mylong)!,image:myimg)
        
        self.place.placedesc[myname] = placedesc
        self.place.names = Array(place.placedesc.keys).sorted()
        print(myname)
        //self.tableView.reloadData()
        
        //NSString *name = Nameid.text
        
        
        
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "saveid" {
            print("i was called")
            print(place.names[0])
            let navController = segue.destination as! UINavigationController
            let detailController = navController.viewControllers.first as! TableViewController
            
            //let myviewController:TableViewController = segue.destination as! TableViewController
            detailController.place = self.place
            print(place.names[0])
            
        }
        
    }
   
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return place.names.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return place.names[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let p:String = place.names[row]
        dist(letplace: p)
    }
    
    
    
    func dist(letplace:String) {
        
        let lat1 = self.place.placedesc[letplace]!.latitude
        //print(lat1)
        let lat2 = self.place.placedesc[selectedplace]!.latitude
        //print(lat2)
        
        let long1 = self.place.placedesc[letplace]!.longitude
        //print(long1)
        let long2 = self.place.placedesc[selectedplace]!.longitude
        //print(long2)
        
        let R = Double(6371) // Radius of the earth in km
        
        let d = lat2 - lat1
        //print(d)
        
        let p = d.degreesToRadians
        //print(p)
        
        let dLon = (long2 - long1).degreesToRadians
        //print(dLon)
        
        
        let a = sin(d/2) * sin(d/2) + cos(lat1) * cos(lat2) * sin(dLon/2) * sin(dLon/2)
        //print(a)
        let c = 2 * atan2(sqrt(a), sqrt(1-a))
        //print(c)
        let ans = R * c // Distance in km
        //print (ans)
        
        distid.text = String(ans)
        bearing.text = String(ans-lat2 * lat1)
        
        
        
    }
    
}

