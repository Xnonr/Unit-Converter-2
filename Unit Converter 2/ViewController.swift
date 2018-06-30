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
    @IBOutlet var inputValueField: UITextField!
    @IBOutlet var outputValueField: UITextField!
    
    @IBAction func conversionButton(_ sender: Any)
    {
        let inputValue = Double(inputValueField.text ?? "") ?? 0.0
        let outputValue: Double = Matrices.conversion(measurementType: currentMeasurement, from: fromValue, to: toValue, inputValue: inputValue)
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
        inputValueField.isHidden = true
        outputValueField.isHidden = true
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
        
        if measurementSelectionDropButton.currentTitle != "Measurement Selection"
        {
            measurementConversionSelection.isHidden = false
            inputValueField.isHidden = false
            outputValueField.isHidden = false
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
        //ViewController.component[0].ViewDidLoad
    }
}
