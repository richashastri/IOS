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
    
    var places:[String]=[String]()
    var selectedplace:String = "unknown"
    let urlString:String = "http://127.0.0.1:8080"
    
    
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
        
        self.gethefields();
        // Do any additional setup after loading the view, typically from a nib.
        self.getmyvalues();
        
        
        
    }
    
    func gethefields(){
        
        
        
            let aConnect:placecollectionstub = placecollectionstub(urlString: urlString)
            let _:Bool = aConnect.get(name: selectedplace, callback: { (res: String, err: String?) -> Void in
                if err != nil {
                    NSLog(err!)
                }else{
                    NSLog(res)
                    if let data: Data = res.data(using: String.Encoding.utf8){
                        do{
                            let dict = try JSONSerialization.jsonObject(with: data,options:.mutableContainers) as?[String:AnyObject]
                            let aDict:[String:AnyObject] = (dict!["result"] as? [String:AnyObject])!
                            let aplace:PlaceDescription = PlaceDescription(dict: aDict)
                            self.Nameid.text = "\(aplace.name)"
                            self.descid.text = "\(aplace.description)"
                            self.imgid.text = "\(aplace.image)"
                            self.addsid.text = "\(aplace.addressStreet)"
                            self.addtid.text = "\(aplace.addressTitle)"
                            self.catid.text = "\(aplace.category)"
                            self.latid.text = "\(aplace.latitude)"
                            self.longid.text = "\(aplace.longitude)"
                            self.eleid.text = "\(aplace.elevation)"
                            
                            
                            
                        } catch {
                            NSLog("unable to convert to dictionary")
                        }
                    }
                }
            })
        
    }
        
    func getmyvalues() {
            let aConnect:placecollectionstub = placecollectionstub(urlString: urlString)
            let resultNames:Bool = aConnect.getNames(callback: { (res: String, err: String?) -> Void in
                if err != nil {
                    NSLog(err!)
                }else{
                    NSLog(res)
                    if let data: Data = res.data(using: String.Encoding.utf8){
                        do{
                            let dict = try JSONSerialization.jsonObject(with: data,options:.mutableContainers) as?[String:AnyObject]
                            self.places = (dict!["result"] as? [String])!
                            print(self.places[0])
                            self.places = Array(self.places).sorted()
                            self.pickerview.dataSource = self
                            self.pickerview.delegate = self
                            self.pickerview.reloadAllComponents()
                            //self.studSelectTF.text = ((self.students.count>0) ? self.students[0] : "")
                            //self.studentPicker.reloadAllComponents()
                            //if self.students.count > 0 {
                            //    self.callGetNPopulatUIFields(self.students[0])
                            //}
                        } catch {
                            print("unable to convert to dictionary")
                        }
                    }
                    
                }
            })  // end of method call to getNames
            
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
        
        let aConnect:placecollectionstub = placecollectionstub(urlString: urlString)
        
        let _:Bool = aConnect.add(place: placedesc,callback: { _ in
            self.places.append(placedesc.name)
            self.pickerview.reloadAllComponents()
            //self.callGetNPopulatUIFields(studName)
        })
        
        
        
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "saveid" {
            print("i was called")
            //print(place.names[0])
            let navController = segue.destination as! UINavigationController
            let detailController = navController.viewControllers.first as! TableViewController
            
            let myviewController:TableViewController = segue.destination as! TableViewController
            //etailController.place = self.place
            //print(place.names[0])
            
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
        return self.places.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.places[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let p:String = self.places[row]
        //dist(letplace: p)
    }
    
    
    
    /*func dist(letplace:String) {
        
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
 */
    
    

}
