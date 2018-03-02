
//  VSTextField.swift
//  Created by Vojta Stavik
//  Copyright (c) 2016 www.vojtastavik.com All rights reserved.
//
//  Created by Dave Neff on 11/8/17.
//

import UIKit
import VSTextField

struct Row {
    let title: String
    let formattingType: TextFieldFormatting
}

final class ExamplesListController: UITableViewController {
    
    let rows: [Row] = [
        Row(title: "UUID", formattingType: .uuid),
        Row(title: "Social Security Number", formattingType: .socialSecurityNumber),
        Row(title: "Phone Number", formattingType: .phoneNumber),
        Row(title: "Custom", formattingType: .custom),
        Row(title: "No Formatting", formattingType: .noFormatting)
    ]
    
    override func viewDidLoad() {
        title = "VSTextField Examples"
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.textLabel?.text = rows[indexPath.row].title
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rows.count
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 { return "Formatting Types" }
        return nil
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedRow = rows[indexPath.row]
        let controller = ExampleDetailController(formatting: selectedRow.formattingType)
        controller.label.text = selectedRow.title
        navigationController?.pushViewController(controller, animated: true)
    }
}
