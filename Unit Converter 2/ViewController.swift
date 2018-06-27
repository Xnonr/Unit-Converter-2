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
    @IBOutlet weak var measurementSelectionDropButton: UIButton!
    @IBOutlet weak var measurementSelectionTableView: UITableView!
    @IBOutlet weak var measurementConversionSelection: UIPickerView!
    
    static var measurementList = ["Area","Length","Mass","Pressure","Speed",
                           "Temperature","Time","Volume"]
    
    /*static var lengthTypesDatabase =
        [["Kilometer","Meter","Centimeter","Millimeter","Micrometer","Nanometer","Mile","Yard","Foot","Inch","Nautical Mile"],
        ["Kilometer","Meter","Centimeter","Millimeter","Micrometer","Nanometer","Mile","Yard","Foot","Inch","Nautical Mile"]]
    
    static var temperatureDatabase =
            [["Faranheight","Celsius"],
            ["Faranheight","Celsius"]]*/
    
    static var allDatabases =
        ["Length": [["Kilometer","Meter","Centimeter","Millimeter","Micrometer","Nanometer","Mile","Yard","Foot","Inch","Nautical Mile"],
                    ["Kilometer","Meter","Centimeter","Millimeter","Micrometer","Nanometer","Mile","Yard","Foot","Inch","Nautical Mile"]],
         
         "Temperature": [["Faranheight","Celsius"],
                         ["Faranheight","Celsius"]],
         
         "Area": [["A","B"],
                  ["A","B"]],
    
         "Mass": [["c","d"],
                  ["c","d"]],
    
         "Pressure": [["e","f"],
                      ["e","f"]],
    
         "Speed": [["A","B"],
                   ["A","B"]],
    
         "Time": [["g","h"],
                  ["g","h"]],
    
         "Volume": [["i","j"],
                    ["i","j"]]]
    
    var currentMeasurement = "Length"

    func numberOfComponents(in pickerView: UIPickerView) -> Int
    {
        return ViewController.allDatabases[currentMeasurement]!.count
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        return ViewController.allDatabases[currentMeasurement]![component].count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        var localrow = row
        if (row >= ViewController.allDatabases[currentMeasurement]![component].count)
        {
           localrow = 0
        }
        return ViewController.allDatabases[currentMeasurement]?[component][localrow]
    }
    
    /*func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        print(component)
        print(row)
        
        switch(component)
        {
            case 0:
                lengthType1 = lengthTypesDatabase[component][row]
                lengthType1Label.text = lengthType1
                print lengthType1
            
            case 1:
                lengthType2 = lengthTypesDatabase[component][row]
                lengthType2Label.text = lengthType2
                print lengthType2
            
            default:break
        }
    }*/
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        measurementSelectionTableView.isHidden = true
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
            UIView.animate(withDuration: 0.5)
            {
                self.measurementSelectionTableView.isHidden = false
            }
        }
        else
        {
            UIView.animate(withDuration: 0.5)
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
    }
}
