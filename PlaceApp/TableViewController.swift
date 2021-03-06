//
//  TableViewController.swift
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
//Purpose: The TableViewController class that handles the table for place list. It also contains the button to add a new place
//
// Ser423 Mobile Applications
//see http://pooh.poly.asu.edu/Mobile
//@author Richa Shastri Richa.Shastri@asu.edu
//        Software Engineering, CIDSE, ASU Poly
//@version March 02, 2017

import UIKit

class TableViewController: UITableViewController {
    
    var place:PlaceLibrary = PlaceLibrary()

    @IBOutlet var table: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
         self.navigationItem.leftBarButtonItem = self.editButtonItem
    }

    
    @IBAction func addme(_ sender: UIBarButtonItem) {
        print("addd")
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
            return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
            print(self.place.names.count)
            return self.place.names.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Configure the cell...
     
     
     let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell", for: indexPath)
     let aStud = place.names[indexPath.row] as String
     print(aStud)
     cell.textLabel?.text = aStud
     

    return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {

            print("tableView editing row at: \(indexPath.row)")
            if editingStyle == .delete {
                let selectedStudent:String = place.names[indexPath.row]
                print("deleting the student \(selectedStudent)")
                place.placedesc.removeValue(forKey: selectedStudent)
                place.names = Array(place.placedesc.keys).sorted()
                tableView.deleteRows(at: [indexPath], with: .fade)
                // do
        }
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        NSLog("seque identifier is \(segue.identifier)")
        if segue.identifier == "PlaceIdentifier" {
            let viewController:ViewController = segue.destination as! ViewController
            let indexPath = self.tableView.indexPathForSelectedRow!
            viewController.place = self.place
            viewController.selectedplace = self.place.names[indexPath.row]
    }
    
    }
}
