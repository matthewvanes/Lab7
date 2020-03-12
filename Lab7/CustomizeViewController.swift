//
//  CustomizeViewController.swift
//  Lab7
//
//  Created by Matthew on 2020-03-11.
//  Copyright © 2020 MV X01A. All rights reserved.
//

import UIKit

class CustomizeViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    //MARK: - Properties
    @IBOutlet weak var picker: UIPickerView!
    @IBOutlet weak var buttonLabel: UITextField!
    @IBOutlet weak var boldButton: UIButton!
    @IBOutlet weak var italicsButton: UIButton!
    @IBOutlet weak var underlineButton: UIButton!
    
    var pickerData = [String]()
    var rowSelected: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Additional setup after loading the view.
        // Connect data:
        self.picker.delegate = self
        self.picker.dataSource = self
        // Load data:
        pickerData = ["Style 1", "Style 2", "Style 3", "Style 4"]
    }
    
    //MARK: - Delegate Functions
    @IBAction func buttonLabelChanged(_ sender: UITextField) {
        // change picker entry to text
        // send reload message to picker to update new text
        pickerData[rowSelected] = buttonLabel.text ?? "Style \(rowSelected)"
        picker.reloadAllComponents()
        print("reloaded")
    }
    
    //MARK: - Data Source Functions
    // Returns number of columns of data
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // Returns number of rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        print("picker view 1")
        return pickerData.count;
    }
    
    //MARK: - PickerView Functions
    // Used when a row in picker is selected. Sets rowSelected variable.
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        rowSelected = row
        print("row selected: \(rowSelected)")
    }
    
    //
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        print("picker view 3")
        return pickerData[row]
    }
}
