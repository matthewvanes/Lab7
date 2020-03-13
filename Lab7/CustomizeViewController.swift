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
    
    var documentViewController: DocumentViewController? = nil
    var pickerData = [StyleEntry]()
    var rowSelected: Int = 0
    var boldSelected: Bool = false
    var italicsSelected: Bool = false
    var underlineSelected: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Additional setup after loading the view.
        // Connect data and picker:
        self.picker.delegate = self
        self.picker.dataSource = self
        // Set buttons
        checkButtonColors(rowSelected: rowSelected)
    }
    
    //MARK: - Delegate Functions
    @IBAction func buttonLabelChanged(_ sender: UITextField) {
        pickerData[rowSelected].styleName = buttonLabel.text ?? "Style \(rowSelected)"
        picker.reloadAllComponents()
        documentViewController?.style1Button.setTitle("label", for: .normal)
    }
    
    @IBAction func boldButtonPressed(_ sender: UIButton) {
        if pickerData[rowSelected].isBold {
            sender.setTitleColor(UIColor.systemBlue, for: .normal)
            pickerData[rowSelected].isBold = false
        } else {
            sender.setTitleColor(UIColor.systemRed, for: .normal)
            pickerData[rowSelected].isBold = true
        }
    }
    
    @IBAction func italicsButtonPressed(_ sender: UIButton) {
        if pickerData[rowSelected].isItalic {
            sender.setTitleColor(UIColor.systemBlue, for: .normal)
            pickerData[rowSelected].isItalic = false
        } else {
            sender.setTitleColor(UIColor.systemRed, for: .normal)
            pickerData[rowSelected].isItalic = true
        }
    }
    
    @IBAction func underlineButtonPressed(_ sender: UIButton) {
        if pickerData[rowSelected].isUnderline {
            sender.setTitleColor(UIColor.systemBlue, for: .normal)
            pickerData[rowSelected].isUnderline = false
        } else {
            sender.setTitleColor(UIColor.systemRed, for: .normal)
            pickerData[rowSelected].isUnderline = true
        }
    }
    
    //MARK: - Data Source Functions
    // Returns number of columns of data
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // Returns number of rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        //print("picker view 1")
        return pickerData.count;
    }
    
    //MARK: - PickerView Functions
    // Used when a row in picker is selected. Sets rowSelected variable.
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // sets row selected
        // sets button colours
        // clears text field
        rowSelected = row
        buttonLabel.text = ""
        checkButtonColors(rowSelected: rowSelected)
        print("row selected: \(rowSelected)")
    }
    
    //
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        //print("picker view 3")
        return pickerData[row].styleName
    }
    
    //MARK: - Custom Functions
    func checkButtonColors(rowSelected: Int) {
        if pickerData[rowSelected].isBold {
            boldButton.setTitleColor(UIColor.systemRed, for: .normal)
        }
        else {
            boldButton.setTitleColor(UIColor.systemBlue, for: .normal)
        }
        
        if pickerData[rowSelected].isItalic {
            italicsButton.setTitleColor(UIColor.systemRed, for: .normal)
        }
        else {
            italicsButton.setTitleColor(UIColor.systemBlue, for: .normal)
        }
        if pickerData[rowSelected].isUnderline {
            underlineButton.setTitleColor(UIColor.systemRed, for: .normal)
        }
        else {
            underlineButton.setTitleColor(UIColor.systemBlue, for: .normal)
        }
    }
    
}
