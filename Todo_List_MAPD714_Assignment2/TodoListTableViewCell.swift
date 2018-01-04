/*
 Date: 3/1/2018
 FileName: ViewController.swift
 Auther's Name: Tejal Patel,Amandeep Sekhon, Mankiran Kaur
 Student ID: 300972812, 300976886, 300990016
 file discription: Add todo list and display in tableview
 */

import UIKit

// setting up Table View custom cell
class TodoListTableViewCell: UITableViewCell {

    
  
    @IBOutlet weak var todoName: UILabel!
    @IBOutlet weak var editTodo: UIButton!
    @IBOutlet weak var switch_completed: UISwitch!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
