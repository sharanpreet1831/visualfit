//
//  CustomGoalUIPickerView.swift
//  VisualFit
//
//  Created by Goyal Harsh on 18/04/24.
//

import UIKit

class CustomGoalUIPickerView: UIPickerView {
    let daysArr = Array(3...7)
    
    var selectedRowFont: UIFont = UIFont.boldSystemFont(ofSize: 25)
    
    override func view(forRow row: Int, forComponent component: Int) -> UIView? {
        let view = super.view(forRow: row, forComponent: component)
        
        if let label = view as? UILabel, row == selectedRow(inComponent: component) {
            // Customize the appearance of the selected row
            label.font = selectedRowFont
            label.text = "\(daysArr[row]) Days"
        }
        return view
    }
}
