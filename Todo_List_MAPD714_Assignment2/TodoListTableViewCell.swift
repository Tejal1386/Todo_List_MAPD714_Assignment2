/*
 Date: 3/1/2018
 FileName: ViewController.swift
 Auther's Name: Tejal Patel
 Student ID: 300972812
 file discription: Add todo list and display in tableview
 */

import UIKit

class TodoListTableViewCell: UITableViewCell {

    
  
    @IBOutlet weak var todoName: UILabel!
    @IBOutlet weak var completeTaskSwitch: UISwitch!
    @IBOutlet weak var editTodo: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
