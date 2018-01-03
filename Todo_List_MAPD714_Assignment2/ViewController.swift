/*
 Date: 3/1/2018
 FileName: ViewController.swift
 Auther's Name: Tejal Patel
 Student ID: 300972812
 file discription: Add todo list and display in tableview
 */

import UIKit
import FirebaseDatabase

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
 
    
    var ref: DatabaseReference!
    
    
    var Name:String = ""
    var Note:String = ""
    var Key:String = ""
    var completed:Bool = false
    var Todo_List = [TodoList]()
    
    @IBOutlet weak var todoListName: UITextField!
    @IBOutlet weak var myTableView: UITableView!
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
 
        ref = Database.database().reference().child("TodoList")
        
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

    //Saving item to database
    @IBAction func saveButton(_ sender: UIButton) {
        
        let key = ref.childByAutoId().key
        
        let todo_List = ["id": key,
                         "Name": todoListName.text! as String,
                         "Note": todoListName.text! as String,
                         "Completed": false as Bool] as [String : Any]
        
        ref.child(key).setValue(todo_List)
    
    }
    
    //setting up Table View
    
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
        let switchView = UISwitch(frame: .zero)
        if list.Completed == false {
            switchView.setOn(true, animated: true)
            cell.backgroundColor =  UIColor.white
             cell.editTodo.isHidden = false
        }
        else {
            cell.backgroundColor =  UIColor.lightGray
            cell.editTodo.isHidden = true
            switchView.setOn(false, animated: false)
        }
        switchView.tag = indexPath.row // for detect which row switch Changed
        switchView.addTarget(self, action: #selector(self.switchChanged(_:)), for: .valueChanged)
        cell.accessoryView = switchView
    
    
        self.myTableView.rowHeight = UITableViewAutomaticDimension
        
        self.myTableView.estimatedRowHeight = 200
    
        return cell
    }
    
    @objc func switchChanged(_ sender : UISwitch!){
        
        print("table row switch Changed \(sender.tag)")
        print("The switch is \(sender.isOn ? "ON" : "OFF")")
        
        
        let todolist = Todo_List[sender.tag]
        
        Key = todolist.id!
        Name = todolist.Name!
        Note = todolist.Notes!
        
        if sender.isOn{
             sender.superview?.backgroundColor =  UIColor.white
            let todo_List = ["id": Key,
                             "Name": Name,
                             "Note": Note,
                             "Completed": false as Bool] as [String : Any]
            
            ref.child(Key).setValue(todo_List)
            
        }else{
            sender.superview?.backgroundColor =  UIColor.lightGray
            let todo_List = ["id": Key,
                             "Name": Name,
                             "Note": Note,
                             "Completed": true as Bool] as [String : Any]
            sender.isOn = false
            ref.child(Key).setValue(todo_List)
        }
    }
 
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let todolist = Todo_List[indexPath.row]
        
        Key = todolist.id!
        Name = todolist.Name!
        Note = todolist.Notes!
        completed = todolist.Completed!
    }
    
    @IBAction func editbutton(_ sender: UIButton) {
           performSegue(withIdentifier: "EditTodo", sender: self)
       
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let detailController = segue.destination as! DetailViewController
        detailController.todo_Name = Name
        detailController.todo_Note = Note
        detailController.KeyValue = Key
        detailController.todo_Completed = Bool(completed)
    }
    
    
    
}

