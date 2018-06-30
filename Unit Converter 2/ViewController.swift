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
        outputValueField.text = inputValueField.text
    }
    
    @IBOutlet weak var measurementSelectionDropButton: UIButton!
    @IBOutlet weak var measurementSelectionTableView: UITableView!
    @IBOutlet weak var measurementConversionSelection: UIPickerView!
    
    static var measurementList =
        ["Area", "Length", "Mass", "Pressure", "Speed", "Temperature", "Time", "Volume"]
    
    static var areaTypesDatabase =
        [["Square Kilometer","Square Meter","Square Mile","Square Yard","Square Foot","Square Inch", "Hectare","Acre"],
         ["Square Kilometer","Square Meter","Square Mile","Square Yard","Square Foot","Square Inch", "Hectare","Acre"]]
    
    static var lengthTypesDatabase =
        [["Kilometer","Meter","Centimeter","Millimeter","Micrometer","Nanometer","Mile","Yard","Foot","Inch","Nautical Mile"],
         ["Kilometer","Meter","Centimeter","Millimeter","Micrometer","Nanometer","Mile","Yard","Foot","Inch","Nautical Mile"]]
    
    static var massTypesDatabase =
        [["Metric Ton", "Kilogram", "Gram", "Milligram", "Microgram", "Imperial Ton", "US Ton", "Stone", "Pound", "Ounce"],
         ["Metric Ton", "Kilogram", "Gram", "Milligram", "Microgram", "Imperial Ton", "US Ton", "Stone", "Pound", "Ounce"]]
    
    static var pressureTypesDatabase =
        [["Atmosphere", "Bar", "Pascal", "Pound-Force Per Square Inch", "Torr"],
         ["Atmosphere", "Bar", "Pascal", "Pound-Force Per Square Inch", "Torr"]]
    
    static var speedTypesDatabase =
        [["Miles Per Hour", "Foot Per Second", "Meter Per Second", "Kilometer Per Hour", "Knot"],
         ["Miles Per Hour", "Foot Per Second", "Meter Per Second", "Kilometer Per Hour", "Knot"]]
    
    static var temperatureTypesDatabase =
        [["Celsius", "Fahrenheit", "Kelvin"],
         ["Celsius", "Fahrenheit", "Kelvin"]]
    
    static var timeTypesDatabase =
        [["Nanosecond", "Microsecond", "Millisecond", "Second", "Minute", "Hour", "Day", "Week", "Month", "Year", "Decade", "Century"],
         ["Nanosecond", "Microsecond", "Millisecond", "Second", "Minute", "Hour", "Day", "Week", "Month", "Year", "Decade", "Century"]]
    
    static var volumeTypesDatabase =
        [["US Liquid Gallon", "US Liquid Quart", "US Liquid Pint", "US Legal Cup", "US Fluid Ounce", "US Tablespoon", "US Teaspoon",
          "Cubic Meter", "Liter", "Millimeter", "Imperial Gallon", "Imperial Quart", "Imperial Cup", "Imperial Fluid Ounce",
          "Imperial Tablespoon", "Imperial Teaspoon", "Cubic Foot", "Cubic Inch"],
         ["US Liquid Gallon", "US Liquid Quart", "US Liquid Pint", "US Legal Cup", "US Fluid Ounce", "US Tablespoon", "US Teaspoon",
          "Cubic Meter", "Liter", "Millimeter", "Imperial Gallon", "Imperial Quart", "Imperial Cup", "Imperial Fluid Ounce",
          "Imperial Tablespoon", "Imperial Teaspoon", "Cubic Foot", "Cubic Inch"]]
    
    static var allDatabases =
        ["Area": areaTypesDatabase,
         "Length": lengthTypesDatabase,
         "Mass": massTypesDatabase,
         "Pressure": pressureTypesDatabase,
         "Speed": speedTypesDatabase,
         "Temperature": temperatureTypesDatabase,
         "Time": timeTypesDatabase,
         "Volume": volumeTypesDatabase]
    
    static var areaFactorMatrix =
        [[1, 1000000, 0.386102, 1195990, 10763900, 1550000000, 100, 247.105],
         [0.000001, 1, 0.000000386102, 1.19599, 10.7639, 1550, 0.0001, 0.000247105],
         [2.58999, 2589990, 1, 3098000, 27880000, 4014000000, 258.999, 640],
         [0.000000836127, 0.836127, 0.00000032283, 1, 9, 1296, 0.0000836127, 0.000206612],
         [0.000000092903, 0.092903, 0.00000003587, 0.111111, 1, 144, 0.0000092903, 0.000022957],
         [0.00000000064516, 0.00064516, 0.0000000002491, 0.000771605, 0.00694444, 1, 0.000000064516, 0.00000015942],
         [0.01, 10000, 0.00386102, 11959.9, 107639, 15500000, 1, 2.47105],
         [0.00404686, 4046.86, 0.0015625, 4840, 43560, 6273000, 0.404686, 1]]
    
    static var lengthFactorMatrix =
        [[1, 1000, 100000, 1000000, 1000000000, 1000000000000, 0.621371, 1093.61, 3280.84, 39370.1, 0.539957],
         [0.001, 1, 100, 1000, 1000000, 1000000000, 0.000621371, 1.09361, 3.28084, 39.3701, 0.000539957],
         [0.00001, 0.01, 1, 10, 10000, 10000000, 0.00000621371, 0.0109361, 0.0328084, 0.393701, 0.00000539957],
         [0.000001, 0.001, 0.1, 1, 1000, 1000000, 0.000000621371, 0.00109361, 0.00328084, 0.0393701, 0.000000539957],
         [0.000000001, 0.000001, 0.0001, 0.001, 1, 1000, 0.000000000621371, 0.00000109361, 0.00000328084, 0.0000393701, 0.000000000539967],
         [0.000000000001, 0.000000001, 0.0000001, 0.000001, 0.001, 1, 0.000000000000621371, 0.00000000109361, 0.00000000328084, 0.0000000393701, 0.000000000000539967],
         [1.60934, 1609.34, 160934, 1609340, 1609340000, 1609340000000, 1, 1760, 5280, 63360, 0.868976],
         [0.0009144, 0.9144, 91.44, 914.4, 914400, 914400000, 0.000568182, 1, 3, 36, 0.000493737],
         [0.0003048, 0.3048, 30.48, 304.8, 304800, 304800000, 0.000189394, 0.333333, 1, 12, 0.000164579],
         [0.0000254, 0.0254, 2.54, 25.4, 25400, 25400000, 0.000015783, 0.0277778, 0.0833333, 1, 0.000013715],
         [1.852, 1852, 185200, 1852000, 1852000000, 1852000000000, 1.15078, 2025.37, 6076.12, 72913.4, 1]]
    
    static var massFactorMatrix =
        [[1, 1000, 1000000, 1000000000, 1000000000000, 0.984207, 1.10231, 157.473, 2204.62, 35274],
         [0.001, 1, 1000, 1000000, 1000000000, 0.000984207, 0.00110231, 0.157473, 2.20462, 35.274],
         [0.000001, 0.001, 1, 1000, 1000000, 0.00000098421, 0.0000011023, 0.000157473, 0.00220462, 0.035274],
         [0.000000001, 0.000001, 0.001, 1, 1000, 0.00000000098421, 0.0000000011023, 0.000000157473, 0.00000220462, 0.000035274],
         [],
         [],
         [],
         []]
    
    static var pressureFactorMatrix =
       [[1, 1.01325, 101325, 14.6959, 760],
        [0.986923, 1, 100000, 14.5038, 750.062],
        [0.00000986923, 0.00001, 1, 0.000145038, 0.00750062],
        [0.068046, 0.0689476, 6894.76, 1, 51.7149],
        [0.00131579, 0.00133322, 133.322, 0.0193368, 1]]
    
    static var speedFactorMatrix =
        [[],
         [],
         [],
         [],
         []]
    
    static var allMatrices =
        [""]
    
    var currentMeasurement = "Length"

    func numberOfComponents(in pickerView: UIPickerView) -> Int
    {
        return 2 //ViewController.allDatabases[currentMeasurement]!.count
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
