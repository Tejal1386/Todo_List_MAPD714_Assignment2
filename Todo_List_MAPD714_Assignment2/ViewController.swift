/*
 Date: 3/1/2018
 FileName: ViewController.swift
 Auther's Name: Tejal Patel,Amandeep Sekhon, Mankiran Kaur
 Student ID: 300972812, 300976886, 300990016
 file discription: Add todo list and display in tableview
 */

import UIKit
import FirebaseDatabase


/// ViewController file extends UITableViewDelegate and UITableViewDataSource
class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
 
    //Database reference
    var ref: DatabaseReference!
    
    // outlet
    @IBOutlet weak var todoListName: UITextField!
    @IBOutlet weak var myTableView: UITableView!
    
    //variables to transfer values from one view to anotherview
    var Name:String = ""
    var Note:String = ""
    var Key:String = ""
    var completed:Bool = false
    
    //object of TodoList Class
    var Todo_List = [TodoList]()
  
    override func viewDidLoad() {
        super.viewDidLoad()
 
        // initialise database reference
        ref = Database.database().reference().child("TodoList")
        
        //Get data from Firebase database and appand with Todo_List object, to display in tableview
        ref.observe(DataEventType.value, with: {(DataSnapshot) in
            if DataSnapshot.childrenCount>0 {
                self.Todo_List.removeAll()
                
                for list in DataSnapshot.children.allObjects as![DataSnapshot]{
                    let todo_listObject = list.value as? [String: AnyObject]
                    let name = todo_listObject?["Name"]
                    let note = todo_listObject?["Note"]
                    let completed = todo_listObject?["Completed"]
                    let list_id = todo_listObject?["id"]
                    let todolist = TodoList(id: list_id as! String?, Notes: note as! String?, Name: name as! String?, Completed: completed as! Bool?)
                    
                    self.Todo_List.append(todolist)
                }
            }
          self.myTableView.reloadData()
        })
    }
    
    //////////////////////////////////////////   setting up Table View  //////////////////////////////////////////
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Todo_List.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = myTableView.dequeueReusableCell(
            withIdentifier: "cell", for: indexPath)
            as! TodoListTableViewCell
        
        let list: TodoList
        
        list = Todo_List[indexPath.row]
        
        cell.todoName.text = list.Name
        
        
        //here is programatically switch make to the table view
        if list.Completed == false {
            cell.switch_completed.setOn(true, animated: true)
            cell.backgroundColor =  UIColor.white
            cell.editTodo.isHidden = false
        }
        else {
            cell.backgroundColor =  UIColor.lightGray       // when task is done on switch off event tablecell is grayed out
            cell.editTodo.isHidden = true                   // when task is done on switch off event editbutton is hidden
             cell.switch_completed.setOn(false, animated: false)
        }
         cell.switch_completed.tag = indexPath.row // for detect which row switch Changed
        
        return cell
    }
    
     // setting up tableview cell height
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let todolist = Todo_List[indexPath.row]
        
        Key = todolist.id!
        Name = todolist.Name!
        Note = todolist.Notes!
        completed = todolist.Completed!
    }
    
    //////////////////////////////////////////   Action Methods  //////////////////////////////////////////
    
    /// Save Button
    ///
    ///Saving item to database
    @IBAction func saveButton(_ sender: UIButton) {
        
        if todoListName.text != "" {
        
        let key = ref.childByAutoId().key
        
        let todo_List = ["id": key,
                         "Name": todoListName.text! as String,
                         "Note": todoListName.text! as String,
                         "Completed": false as Bool] as [String : Any]
        
        ref.child(key).setValue(todo_List)
        }
    }
    
    /// Switch
    ///
    ///Switch on and off function defines completed task when switch is off
    
    
    @IBAction func switch_completed(_ sender: UISwitch) {
        
        let todolist = Todo_List[sender.tag]
        
        Key = todolist.id!
        Name = todolist.Name!
        Note = todolist.Notes!
        
        if sender.isOn{
            
            // on switch-on event,  completed is set to false and update in database
            sender.superview?.backgroundColor =  UIColor.white
            let todo_List = ["id": Key,
                             "Name": Name,
                             "Note": Note,
                             "Completed": false as Bool] as [String : Any]
            
            ref.child(Key).setValue(todo_List)
            
        }else{
            // on switch-off event,  completed is set to true and update in database
            sender.superview?.backgroundColor =  UIColor.lightGray
            let todo_List = ["id": Key,
                             "Name": Name,
                             "Note": Note,
                             "Completed": true as Bool] as [String : Any]
            sender.isOn = false
            ref.child(Key).setValue(todo_List)
    }
    
  
    }
 
  
    
    /// Edit Button
    ///
    /// Perform Segue to DetailViewController
    @IBAction func editbutton(_ sender: UIButton) {
           performSegue(withIdentifier: "EditTodo", sender: self)
       
    }
    
    // Transfer Values to DetailViewController for update or delete
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let detailController = segue.destination as! DetailViewController
        detailController.todo_Name = Name
        detailController.todo_Note = Note
        detailController.KeyValue = Key
        detailController.todo_Completed = Bool(completed)
    }
    
    
    
}

