//
//  ViewController.swift
//  Unit Converter 2
//
//  Created by Maxence Brette on 6/15/18.
//  Copyright © 2018 Maxence Brette. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate
{
    
    
    @IBOutlet weak var notationTypeButton: UISegmentedControl!
    @IBAction func notationTypeChanged(_ sender: UISegmentedControl)
    {
        if(notationTypeButton.selectedSegmentIndex == 0)
        {
            
        }
        
        else if(notationTypeButton.selectedSegmentIndex == 1)
        {
            
        }
        
        else
        {
            
        }
    }
    
    //Rounding
    @IBOutlet weak var roundingValueButton: UIStepper!
    
    @IBAction func roundingValueChanged(_ sender: UIStepper)
    {
        if(roundingValueButton.value == 0)
        {
            roundingValueField.text = "0.001"
            roundOrNot = true
            roundingValue = 1000.0
        }
            
        else if(roundingValueButton.value == 1)
        {
            roundingValueField.text = "0.01"
            roundOrNot = true
            roundingValue = 100.0
        }
            
        else if(roundingValueButton.value == 2)
        {
            roundingValueField.text = "0.1"
            roundOrNot = true
            roundingValue = 10.0
        }
            
        else if(roundingValueButton.value == 3)
        {
            roundingValueField.text = "1"
            roundOrNot = true
            roundingValue = 1.0
        }
            
        else if(roundingValueButton.value == 4)
        {
            roundingValueField.text = "10"
            roundOrNot = true
            roundingValue = 0.1
        }
            
        else if(roundingValueButton.value == 5)
        {
            roundingValueField.text = "100"
            roundOrNot = true
            roundingValue = 0.01
        }
            
        else if(roundingValueButton.value == 6)
        {
            roundingValueField.text = "1000"
            roundOrNot = true
            roundingValue = 0.001
        }
        
        else
        {
            roundingValueField.text = "No Rounding"
            roundOrNot = false
        }
    }
    
    @IBOutlet weak var roundingValueField: UITextField!
    
    //Input & Output
    @IBOutlet var inputValueField: UITextField!
    @IBOutlet var outputValueField: UITextField!
    
    //Conversion Button
    @IBOutlet weak var conversionButtonSelection: UIButton!
    
    @IBAction func conversionButton(_ sender: Any)
    {
        let inputValue = Double(inputValueField.text ?? "") ?? 0.0
        let outputValue: Double = Matrices.conversion(measurementType: currentMeasurement, from: fromValue, to: toValue, inputValue: inputValue, toRound: roundOrNot, roundTo: roundingValue)
        outputValueField.text = String(outputValue)
    }
    
    @IBOutlet weak var measurementSelectionDropButton: UIButton!
    @IBOutlet weak var measurementSelectionTableView: UITableView!
    @IBOutlet weak var measurementConversionSelection: UIPickerView!
    
    static var measurementList =
        ["Area", "Length", "Mass", "Pressure", "Speed", "Temperature", "Time", "Volume"]
    
    var currentMeasurement = "Length"
    
    var fromValue: Int = 0
    var toValue: Int = 0
    var roundOrNot: Bool = false
    var roundingValue: Double = 1.0
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int
    {
        return Matrices.allDatabases[currentMeasurement]!.count
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        return Matrices.allDatabases[currentMeasurement]![component].count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        var localrow = row
        
        if (row >= Matrices.allDatabases[currentMeasurement]![component].count)
        {
           localrow = 0
        }
        
        return Matrices.allDatabases[currentMeasurement]?[component][localrow]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        switch(component)
        {
            case 0:
            fromValue = row
                
            case 1:
            toValue = row
                
            default:break
        }
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        measurementSelectionTableView.isHidden = true
        
        measurementConversionSelection.isHidden = true
        notationTypeButton.isHidden = true
        roundingValueButton.isHidden = true
        roundingValueField.isHidden = true
        inputValueField.isHidden = true
        outputValueField.isHidden = true
        conversionButtonSelection.isHidden = true
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func clickMeasurementSelectionDropButton(_ sender: Any)
    {
        if measurementSelectionTableView.isHidden
        {
            animate(toogle: true)
        }
            
        else
        {
            animate(toogle: false)
        }
    }
    
    func animate(toogle: Bool)
    {
        if toogle
        {
            UIView.animate(withDuration: 0.3)
            {
                self.measurementSelectionTableView.isHidden = false
            }
        }
        else
        {
            UIView.animate(withDuration: 0.3)
            {
                self.measurementSelectionTableView.isHidden = true
            }
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return ViewController.measurementList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = ViewController.measurementList[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        measurementSelectionDropButton.setTitle(ViewController.measurementList[indexPath.row], for: .normal)
        currentMeasurement = ViewController.measurementList[indexPath.row]
        animate(toogle: false)
        
        measurementConversionSelection.isHidden = false
        notationTypeButton.isHidden = false
        roundingValueButton.isHidden = false
        roundingValueField.isHidden = false
        inputValueField.isHidden = false
        outputValueField.isHidden = false
        conversionButtonSelection.isHidden = false
        
        self.measurementConversionSelection.reloadAllComponents()
    }
}
