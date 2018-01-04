/*
 Date: 3/1/2018
 FileName: ViewController.swift
 Auther's Name: Tejal Patel,Amandeep Sekhon, Mankiran Kaur
 Student ID: 300972812, 300976886, 300990016
 file discription: Add todo list and display in tableview
 */

import UIKit

// definig class object to get values from database and display on view
class TodoList: NSObject {
    var id:String?
    var Notes: String?
    var Name: String?
    var Completed: Bool?
   
    init(id:String? ,Notes:String?, Name:String?, Completed:Bool?) {
        self.id = id;
        self.Notes = Notes;
        self.Name = Name;
        self.Completed = Completed;
    }
}

