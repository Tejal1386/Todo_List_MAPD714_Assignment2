/*
 Date: 3/1/2018
 FileName: ViewController.swift
 Auther's Name: Tejal Patel
 Student ID: 300972812
 file discription: Add todo list and display in tableview
 */

import UIKit
import FirebaseDatabase

class DetailViewController: UIViewController {

   
    @IBOutlet weak var TodoName: UITextField!
    
    @IBOutlet weak var TodoNote: UITextView!
    
    var ref: DatabaseReference!
    
    var KeyValue = String()
    var todo_Name = String()
    var todo_Note = String()
    var todo_Completed = Bool()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        ref = Database.database().reference().child("TodoList")
        
        TodoName.text = todo_Name
        TodoNote.text = todo_Note
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
   }
    
   
    @IBAction func update_todolist(_ sender: UIButton) {
    
        let todo_List = ["id": KeyValue,
                         "Name": TodoName.text! as String,
                         "Note": TodoNote.text! as String,
                         "Completed": todo_Completed as Bool] as [String : Any]
        
      ref.child(KeyValue).setValue(todo_List)
    }
    
    
    
    @IBAction func delete_todolist(_ sender: UIButton) {
        ref.child(KeyValue).setValue(nil)
    }
    
}