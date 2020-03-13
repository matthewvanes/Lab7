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
    
    // PURPOSE:
    // Calls applyStyles function with provided "buttonIndex"
    //
    // PARAMETERS:
    // UIButton: self
    //
    // RETURN/SIDE EFFECTS:
    // Calls applyStyles function with provided "buttonIndex"
    //
    // NOTES:
    // Each of these functions are the functionally identical.
    // Difference is only the index provided when each button is pressed.
    //
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
    // PURPOSE:
    // Returns number of columns of data in picker.
    //
    // PARAMETERS:
    //
    //
    // RETURN/SIDE EFFECTS:
    // Returns integer of number of columns in picker.
    //
    // NOTES:
    // In this particular implementation will only ever return 1.
    //
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // PURPOSE:
    // Returns the number of total rows of data in picker.
    //
    // PARAMETERS:
    // UIPickerview pickerview, numOfRowsInComponent component
    //
    // RETURN/SIDE EFFECTS:
    // Returns length/number of rows in picker data.
    //
    // NOTES:
    // N/A
    //
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        //print("picker view 1")
        return pickerData.count;
    }
    
    //MARK: - PickerView Functions
    // PURPOSE:
    // Called when a row in picker is selected
    // Sets the rowSelected variable to index of selected row data.
    // Calls the checkbuttonColors method on that row.
    //
    // PARAMETERS:
    // N/A
    //
    // RETURN/SIDE EFFECTS:
    //
    //
    // NOTES:
    // N/A
    //
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        rowSelected = row
        buttonLabel.text = ""
        checkButtonColors(rowSelected: rowSelected)
    }
    
    // PURPOSE:
    // Called when the picker is reloaded or created.
    //
    // PARAMETERS:
    // N/A
    //
    // RETURN/SIDE EFFECTS:
    // Returns the name of the style at the selected picker row.
    //
    // NOTES:
    //
    //
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row].styleName
    }
    
    // PURPOSE:
    // Checks and sets the button colours of selected row.
    //
    // PARAMETERS:
    // Integer index of the row currently selected.
    //
    // RETURN/SIDE EFFECTS:
    // If style attriutes are selected, the buttons are set to red, otherwise
    // they will be set to blue.
    //
    // NOTES:
    // N/A
    //
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
