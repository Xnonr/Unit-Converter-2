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
    
    static var temperatureTypesDatabase =
        [["Celsius", "Fahrenheit", "Kelvin"],
         ["Celsius", "Fahrenheit", "Kelvin"]]
    
    //Factors in same order as databases
    
    static var areaTypesDatabase =
        [["Square Kilometer","Square Meter","Square Mile","Square Yard","Square Foot","Square Inch", "Hectare","Acre"],
         ["Square Kilometer","Square Meter","Square Mile","Square Yard","Square Foot","Square Inch", "Hectare","Acre"]]
    
    static var areaFactorMatrix =
        [[1, 1000000, 0.386102, 1195990, 10763900, 1550000000, 100, 247.105],
         [0.000001, 1, 0.000000386102, 1.19599, 10.7639, 1550, 0.0001, 0.000247105],
         [2.58999, 2589990, 1, 3098000, 27880000, 4014000000, 258.999, 640],
         [0.000000836127, 0.836127, 0.00000032283, 1, 9, 1296, 0.0000836127, 0.000206612],
         [0.000000092903, 0.092903, 0.00000003587, 0.111111, 1, 144, 0.0000092903, 0.000022957],
         [0.00000000064516, 0.00064516, 0.0000000002491, 0.000771605, 0.00694444, 1, 0.000000064516, 0.00000015942],
         [0.01, 10000, 0.00386102, 11959.9, 107639, 15500000, 1, 2.47105],
         [0.00404686, 4046.86, 0.0015625, 4840, 43560, 6273000, 0.404686, 1]]
    
    static var lengthTypesDatabase =
        [["Kilometer","Meter","Centimeter","Millimeter","Micrometer","Nanometer","Mile","Yard","Foot","Inch","Nautical Mile"],
         ["Kilometer","Meter","Centimeter","Millimeter","Micrometer","Nanometer","Mile","Yard","Foot","Inch","Nautical Mile"]]
    
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
    
    static var massTypesDatabase =
        [["Metric Ton", "Kilogram", "Gram", "Milligram", "Microgram", "Imperial Ton", "US Ton", "Stone", "Pound", "Ounce"],
         ["Metric Ton", "Kilogram", "Gram", "Milligram", "Microgram", "Imperial Ton", "US Ton", "Stone", "Pound", "Ounce"]]
    
    static var massFactorMatrix =
        [[1, 1000, 1000000, 1000000000, 1000000000000, 0.984207, 1.10231, 157.473, 2204.62, 35274],
         [0.001, 1, 1000, 1000000, 1000000000, 0.000984207, 0.00110231, 0.157473, 2.20462, 35.274],
         [0.000001, 0.001, 1, 1000, 1000000, 0.00000098421, 0.0000011023, 0.000157473, 0.00220462, 0.035274],
         [0.000000001, 0.000001, 0.001, 1, 1000, 0.00000000098421, 0.0000000011023, 0.000000157473, 0.00000220462, 0.000035274],
         [0.000000000001, 0.000000001, 0.000001, 0.001, 1, 0.00000000000098421, 0.0000000000011023, 0.00000000015747, 0.0000000022046, 0.000000035274],
         [1.01605, 1016.05, 1016050, 1016050000, 1016050000000, 1, 1.12, 160, 2240, 35840],
         [0.907185, 907.185, 907185, 907185000, 907185000000, 0.892857, 1, 142.857, 2000, 32000],
         [0.00635029, 6.35029, 6350.29, 6350290, 6350290000, 0.00625, 0.007, 1, 14, 224],
         [0.000453592, 0.453592, 453.592, 453592, 453592000, 0.000446429, 0.0005, 0.0714286, 1, 16],
         [0.0000283495, 0.0283495, 28.3495, 28349.5, 28350000, 0.000027902, 0.00003125, 0.00446429, 0.0625, 1]]
    
    static var pressureTypesDatabase =
        [["Atmosphere", "Bar", "Pascal", "Pound-Force Per Square Inch", "Torr"],
         ["Atmosphere", "Bar", "Pascal", "Pound-Force Per Square Inch", "Torr"]]
    
    static var pressureFactorMatrix =
       [[1, 1.01325, 101325, 14.6959, 760],
        [0.986923, 1, 100000, 14.5038, 750.062],
        [0.00000986923, 0.00001, 1, 0.000145038, 0.00750062],
        [0.068046, 0.0689476, 6894.76, 1, 51.7149],
        [0.00131579, 0.00133322, 133.322, 0.0193368, 1]]
    
    static var speedTypesDatabase =
        [["Miles Per Hour", "Foot Per Second", "Meter Per Second", "Kilometer Per Hour", "Knot"],
         ["Miles Per Hour", "Foot Per Second", "Meter Per Second", "Kilometer Per Hour", "Knot"]]
    
    static var speedFactorMatrix =
        [[1, 1.46667, 0.44704, 1.60934, 0.868976],
         [0.681818, 1, 0.3048, 1.09728, 0.592484],
         [2.23694, 3.28084, 1, 3.6, 1.94384],
         [0.621371, 0.911344, 0.277778, 1, 0.539957],
         [1.15078, 1.68781, 0.514444, 1.852, 1]]
    
    static var timeTypesDatabase =
        [["Nanosecond", "Microsecond", "Millisecond", "Second", "Minute", "Hour", "Day", "Week", "Month", "Year", "Decade", "Century"],
         ["Nanosecond", "Microsecond", "Millisecond", "Second", "Minute", "Hour", "Day", "Week", "Month", "Year", "Decade", "Century"]]
    
    static var timeFactorMatrix =
        [[],
         [],
         [],
         [],
         [],
         [],
         [],
         [],
         [],
         [],
         [],
         []]
    
    static var volumeTypesDatabase =
        [["US Liquid Gallon", "US Liquid Quart", "US Liquid Pint", "US Legal Cup", "US Fluid Ounce", "US Tablespoon", "US Teaspoon",
          "Cubic Meter", "Liter", "Millimeter", "Imperial Gallon", "Imperial Quart", "Imperial Cup", "Imperial Fluid Ounce",
          "Imperial Tablespoon", "Imperial Teaspoon", "Cubic Foot", "Cubic Inch"],
         ["US Liquid Gallon", "US Liquid Quart", "US Liquid Pint", "US Legal Cup", "US Fluid Ounce", "US Tablespoon", "US Teaspoon",
          "Cubic Meter", "Liter", "Millimeter", "Imperial Gallon", "Imperial Quart", "Imperial Cup", "Imperial Fluid Ounce",
          "Imperial Tablespoon", "Imperial Teaspoon", "Cubic Foot", "Cubic Inch"]]
    
    static var volumeFactorMatrix =
        [[1, 4, 8, 15.7725, 128, 256, 768, 0.00378541, 3.78541, 3785.41, 0.832674, 3.3307, 6.66139, 13.3228, 133.228, 213.165, 639.494, 0.133681, 231],
         [0.25, 1, 2, 3.94314, 32, 64, 192, 0.000946353, 0.946353, 946.353, 0.208169, 0.832674, 1.66535, 3.3307, 33.307, 53.2911, 159.873, 0.0334201, 57.75],
         [0.125, 0.5, 1, 1.97157, 16, 32, 96, 0.000473176, 0.473176, 473.176, 0.104084, 0.416337, 0.832674, 1.66535, 16.6535, 26.6456, 79.9367, 0.0167101, 28.875],
         [0.0634013, 0.253605, 0.50721, 1, 8.11537, 16.2307, 48.6922, 0.00024, 0.24, 240, 0.0527926, 0.21117, 0.422341, 0.844682, 8.44682, 13.5149, 40.5447, 0.00847552, 14.6457],
         [0.0078125, 0.03125, 0.0625, 0.123223, 1, 2, 6, 0.0000295735, 0.0295735, 29.5735, 0.00650527, 0.0260211, 0.0520421, 0.104084, 1.04084, 1.66535, 4.99604, 0.00104438, 1.80469],
         [0.00390625, 0.015625, 0.03125, 0.0616115, 0.5, 1, 3, 0.000014787, 0.0147868, 14.7868, 0.00325263, 0.0130105, 0.0260211, 0.0520421, 0.520421, 0.832674, 2.49802, 0.00052219, 0.902344],
         [0.00130208, 0.00520833, 0.0104167, 0.0205372, 0.166667, 0.333333, 1, 0.0000049289, 0.00492892, 4.92892, 0.00108421, 0.00433684, 0.00867369, 0.0173474, 0.173474, 0.277558, 0.832674, 0.000174063, 0.300781],
         [264.172, 1056.69, 2113.38, 4166.67, 33814, 67628, 202884, 1, 1000, 1000000, 219.969, 879.877, 1759.75, 3519.51, 35195.1, 56312.1, 168936, 35.3147, 61023.7],
         [0.264172, 1.05669, 2.11338, 4.16667, 33.814, 67.628, 202.884, 0.001, 1, 1000, 0.219969, 0.879877, 1.75975, 3.51951, 35.1951, 56.3121, 168.936, 0.0353147, 61.0237],
         [0.000264172, 0.00105669, 0.00211338, 0.00416667, 0.033814, 0.067628, 0.202884, 0.000001, 0.001, 1, 0.000219969, 0.000879877, 0.00175975, 0.00351951, 0.0351951, 0.168936, 0.000035315, 0.0610237],
         [1.20095, 4.8038, 9.6076, 18.942, 153.722, 307.443, 922.33, 0.00454609, 4.54609, 4546.09, 1, 4, 8, 16, 160, 256, 768, 0.160544, 277.419],
         [0.300237, 1.20095, 2.4019, 4.73551, 38.4304, 76.8608, 230.582, 0.00113652, 1.13652, 1136.52, 0.25, 1, 2, 4, 40, 64, 192, 0.0401359, 69.3549],
         [0.150119, 0.600475, 1.20095, 2.36776, 19.2152, 38.4304, 115.291, 0.000568261, 0.568261, 568.261, 0.125, 0.5, 1, 2, 20, 32, 96, 0.020068, 34.6774],
         [0.0750594, 0.300237, 0.600475, 1.18388, 9.6076, 19.2152, 57.6456, 0.000284131, 0.284131, 284.131, 0.0625, 0.25, 0.5, 1, 10, 16, 48, 0.010034, 17.3387],
         [0.00750594, 0.0300237, 0.0600475, 0.118388, 0.96076, 1.92152, 5.76456, 0.000028413, 0.0284131, 28.4131, 0.00625, 0.025, 0.05, 0.1, 1, 1.6, 4.8, 0.0010034, 1.73387],
         [0.00469121, 0.0187649, 0.0375297, 0.0739924, 0.600475, 1.20095, 3.60285, 0.000017758, 0.0177582, 17.7582, 0.00390625, 0.015625, 0.03125, 0.0625, 0.625, 1, 3, 0.000627124, 1.08367],
         [0.00156374, 0.00625495, 0.0125099, 0.0246641, 0.200158, 0.400317, 1.20095, 0.0000059194, 0.00591939, 5.91939, 0.00130208, 0.00520834, 0.0104167, 0.0208333, 0.208333, 0.333333, 1, 0.000209041, 0.361223],
         [7.48052, 29.9221, 59.8442, 117.987, 957.506, 1915.01, 5745.04, 0.0283168, 28.3168, 28316.8, 6.22884, 24.9153, 49.8307, 99.6614, 996.614, 1594.58, 4783.74, 1, 1728],
         [0.004329, 0.017316, 0.034632, 0.0682794, 0.554113, 1.10823, 3.32468, 0.000016387, 0.0163871, 16.3871, 0.00360465, 0.0144186, 0.0288372, 0.0576744, 0.576744, 0.92279, 2.76837, 0.000578704, 1]]
    
    static var allDatabases =
        ["Area": areaTypesDatabase,
         "Length": lengthTypesDatabase,
         "Mass": massTypesDatabase,
         "Pressure": pressureTypesDatabase,
         "Speed": speedTypesDatabase,
         "Temperature": temperatureTypesDatabase,
         "Time": timeTypesDatabase,
         "Volume": volumeTypesDatabase]
    
    static var allFactorMatrices =
        ["Area": areaFactorMatrix,
         "Length": lengthFactorMatrix,
         "Mass": massFactorMatrix,
         "Pressure": pressureFactorMatrix,
         "Speed": speedFactorMatrix,
         "Time": timeFactorMatrix,
         "Volume": volumeFactorMatrix]
    
    
    var currentMeasurement = "Length"
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int
    {
        return ViewController.allDatabases[currentMeasurement]!.count //2
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
