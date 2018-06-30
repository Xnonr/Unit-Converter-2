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

func squareKilometerConversion(convertTo: String, value: Double) -> Double
{
    var convertedValue: Double
    convertedValue = 0.0
    
    switch(convertTo)
    {
        case "Square Kilometer":
        convertedValue = value
        
        case "Square Meter":
        convertedValue = (value * 1000000)
        
        case "Square Mile":
        convertedValue = (value * 0.386102)
        
        case "Square Yard":
        convertedValue = (value * 1196000)
        
        case "Square Foot":
        convertedValue = (value * 10760000)
        
        case "Square Inch":
        convertedValue = (value * 1550000000)
        
        case "Hectare":
        convertedValue = (value * 100)
        
        case "Acre":
        convertedValue = (value * 247.105)
        
        default: break
    }
    return convertedValue
}

func squareMeterConversion(convertTo: String, value: Double) -> Double
{
    var convertedValue: Double
    convertedValue = 0.0
    
    switch(convertTo)
    {
        case "Square Kilometer":
        convertedValue = (value * 0.000001)
        
        case "Square Meter":
        convertedValue = value
        
        case "Square Mile":
        convertedValue = (value * 0.0000003861)
        
        case "Square Yard":
        convertedValue = (value * 1.19599)
        
        case "Square Foot":
        convertedValue = (value * 10.7639)
        
        case "Square Inch":
        convertedValue = (value * 1550)
        
        case "Hectare":
        convertedValue = (value * 0.0001)
        
        case "Acre":
        convertedValue = (value * 0.404686)
        
        default: break
    }
    return convertedValue
}

func squareMileConversion(convertTo: String, value: Double) -> Double
{
    var convertedValue: Double
    convertedValue = 0.0
    
    switch(convertTo)
    {
        case "Square Kilometer":
        convertedValue = (value * 2.58999)
        
        case "Square Meter":
        convertedValue = (value * 2590000)
        
        case "Square Mile":
        convertedValue = value
        
        case "Square Yard":
        convertedValue = (value * 3098000)
        
        case "Square Foot":
        convertedValue = (value * 27880000)
        
        case "Square Inch":
        convertedValue = (value * 4014000000)
        
        case "Hectare":
        convertedValue = (value * 258.999)
        
        case "Acre":
        convertedValue = (value * 640)
        
        default: break
    }
    return convertedValue
}

func squareYardConversion(convertTo: String, value: Double) -> Double
{
    var convertedValue: Double
    convertedValue = 0.0
    
    switch(convertTo)
    {
        case "Square Kilometer":
        convertedValue = (value * 0.00000083613)
        
        case "Square Meter":
        convertedValue = (value * 0.836127)
        
        case "Square Mile":
        convertedValue = (value * 0.00000032283)
        
        case "Square Yard":
        convertedValue = value
        
        case "Square Foot":
        convertedValue = (value * 9)
        
        case "Square Inch":
        convertedValue = (value * 1296)
        
        case "Hectare":
        convertedValue = (value * 0.000083613)
        
        case "Acre":
        convertedValue = (value * 0.000206612)
        
        default: break
    }
    return convertedValue
}

func squareFootConversion(convertTo: String, value: Double) -> Double
{
    var convertedValue: Double
    convertedValue = 0.0
    
    switch(convertTo)
    {
        case "Square Kilometer":
        convertedValue = (value * 0.000000092903)
        
        case "Square Meter":
        convertedValue = (value * 0.092903)
        
        case "Square Mile":
        convertedValue = (value * 0.00000003587)
        
        case "Square Yard":
        convertedValue = (value * 0.111111)
        
        case "Square Foot":
        convertedValue = value
        
        case "Square Inch":
        convertedValue = (value * 144)
        
        case "Hectare":
        convertedValue = (value * 0.0000092903)
        
        case "Acre":
        convertedValue = (value * 0.000022957)
        
        default: break
    }
    return convertedValue
}

func squareInchConversion(convertTo: String, value: Double) -> Double
{
    var convertedValue: Double
    convertedValue = 0.0
    
    switch(convertTo)
    {
        case "Square Kilometer":
        convertedValue = (value * 0.00000000064516)
        
        case "Square Meter":
        convertedValue = (value * 0.00064516)
        
        case "Square Mile":
        convertedValue = (value * 0.0000000002491)
        
        case "Square Yard":
        convertedValue = (value * 0.000771605)
        
        case "Square Foot":
        convertedValue = (value * 0.00694444)
        
        case "Square Inch":
        convertedValue = value
        
        case "Hectare":
        convertedValue = (value * 0.000000064516)
        
        case "Acre":
        convertedValue = (value * 0.00000015942)
        
        default: break
    }
    return convertedValue
}

func squareHectareConversion(convertTo: String, value: Double) -> Double
{
    var convertedValue: Double
    convertedValue = 0.0
    
    switch(convertTo)
    {
        case "Square Kilometer":
        convertedValue = (value * 0.01)
        
        case "Square Meter":
        convertedValue = (value * 10000)
        
        case "Square Mile":
        convertedValue = (value * 0.00386102)
        
        case "Square Yard":
        convertedValue = (value * 11959.9)
        
        case "Square Foot":
        convertedValue = (value * 107639)
        
        case "Square Inch":
        convertedValue = (value * 15500000)
        
        case "Hectare":
        convertedValue = value
        
        case "Acre":
        convertedValue = (value * 2.47105)
        
        default: break
    }
    return convertedValue
}

func squareAcreConversion(convertTo: String, value: Double) -> Double
{
    var convertedValue: Double
    convertedValue = 0.0
    
    switch(convertTo)
    {
        case "Square Kilometer":
        convertedValue = (value * 0.00404686)
        
        case "Square Meter":
        convertedValue = (value * 4046.86)
        
        case "Square Mile":
        convertedValue = (value * 0.0015625)
        
        case "Square Yard":
        convertedValue = (value * 4840)
        
        case "Square Foot":
        convertedValue = (value * 43560)
        
        case "Square Inch":
        convertedValue = (value * 6273000)
        
        case "Hectare":
        convertedValue = (value * 0.404686)
        
        case "Acre":
        convertedValue = value
        
        default: break
    }
    return convertedValue
}

func kilometerConversion(convertTo: String, value: Double) -> Double
{
    var convertedValue: Double
    convertedValue = 0.0
    
    switch(convertTo)
    {
    case "Kilometer":
        convertedValue = value
        
    case "Meter":
        convertedValue = (value * 1000)
        
    case "Centimeter":
        convertedValue = (value * 100000)
        
    case "Millimeter":
        convertedValue = (value * 1000000)
        
    case "Micrometer":
        convertedValue = (value * 1000000000)
        
    case "Nanometer":
        convertedValue = (value * 1000000000000)
        
    case "Mile":
        convertedValue = (value * 0.621371)
        
    case "Yard":
        convertedValue = (value * 1093.61)
        
    case "Foot":
        convertedValue = (value * 3280.84)
        
    case "Inch":
        convertedValue = (value * 39370.1)
        
    case "Nautical Mile":
        convertedValue = (value * 0.539957)
        
    default: break
    }
    return convertedValue
}

func meterConversion(convertTo: String, value: Double) -> Double
{
    var convertedValue: Double
    convertedValue = 0.0
    
    switch(convertTo)
    {
        case "Kilometer":
        convertedValue = (value * 0.001)
        
        case "Meter":
        convertedValue = value
        
        case "Centimeter":
        convertedValue = (value * 100)
        
        case "Millimeter":
        convertedValue = (value * 1000)
        
        case "Micrometer":
        convertedValue = (value * 1000000)
        
        case "Nanometer":
        convertedValue = (value * 1000000000)
        
        case "Mile":
        convertedValue = (value * 0.000621371)
        
        case "Yard":
        convertedValue = (value * 1.09361)
        
        case "Foot":
        convertedValue = (value * 3.28084)
        
        case "Inch":
        convertedValue = (value * 39.3701)
        
        case "Nautical Mile":
        convertedValue = (value * 0.000539957)
        
        default: break
    }
    return convertedValue
}

func centimeterConversion(convertTo: String, value: Double) -> Double
{
    var convertedValue: Double
    convertedValue = 0.0
    
    switch(convertTo)
    {
        case "Kilometer":
        convertedValue = (value * 0.00001)
        
        case "Meter":
        convertedValue = (value * 0.01)
        
        case "Centimeter":
        convertedValue = value
        
        case "Millimeter":
        convertedValue = (value * 10)
        
        case "Micrometer":
        convertedValue = (value * 10000)
        
        case "Nanometer":
        convertedValue = (value * 10000000)
        
        case "Mile":
        convertedValue = (value * 0.0000062137)
        
        case "Yard":
        convertedValue = (value * 0.0109361)
        
        case "Foot":
        convertedValue = (value * 0.0328084)
        
        case "Inch":
        convertedValue = (value * 0.393701)
        
        case "Nautical Mile":
        convertedValue = (value * 0.0000053996)
        
        default: break
    }
    return convertedValue
}

func millimeterConversion(convertTo: String, value: Double) -> Double
{
    var convertedValue: Double
    convertedValue = 0.0
    
    switch(convertTo)
    {
        case "Kilometer":
        convertedValue = (value * 0.000001)
        
        case "Meter":
        convertedValue = (value * 0.001)
        
        case "Centimeter":
        convertedValue = (value * 100000)
        
        case "Millimeter":
        convertedValue = value
        
        case "Micrometer":
        convertedValue = (value * 1000)
        
        case "Nanometer":
        convertedValue = (value * 1000000)
        
        case "Mile":
        convertedValue = (value * 0.00000062137)
        
        case "Yard":
        convertedValue = (value * 0.00109361)
        
        case "Foot":
        convertedValue = (value * 0.00328084)
        
        case "Inch":
        convertedValue = (value * 0.0393701)
        
        case "Nautical Mile":
        convertedValue = (value * 0.00000053996)
        
        default: break
    }
    return convertedValue
}

func micrometerConversion(convertTo: String, value: Double) -> Double
{
    var convertedValue: Double
    convertedValue = 0.0
    
    switch(convertTo)
    {
        case "Kilometer":
        convertedValue = (value * 0.000000001)
        
        case "Meter":
        convertedValue = (value * 0.000001)
        
        case "Centimeter":
        convertedValue = (value * 0.0001)
        
        case "Millimeter":
        convertedValue = (value * 0.001)
        
        case "Micrometer":
        convertedValue = value
        
        case "Nanometer":
        convertedValue = (value * 1000)
        
        case "Mile":
        convertedValue = (value * 0.00000000062137)
        
        case "Yard":
        convertedValue = (value * 0.0000010936)
        
        case "Foot":
        convertedValue = (value * 0.0000032808)
        
        case "Inch":
        convertedValue = (value * 0.00003937)
        
        case "Nautical Mile":
        convertedValue = (value * 0.00000000053996)
        
        default: break
    }
    return convertedValue
}

func nanometerConversion(convertTo: String, value: Double) -> Double
{
    var convertedValue: Double
    convertedValue = 0.0
    
    switch(convertTo)
    {
        case "Kilometer":
        convertedValue = (value * 0.000000000001)
        
        case "Meter":
        convertedValue = (value * 0.000000001)
        
        case "Centimeter":
        convertedValue = (value * 0.0000001)
        
        case "Millimeter":
        convertedValue = (value * 0.000001)
        
        case "Micrometer":
        convertedValue = (value * 0.001)
        
        case "Nanometer":
        convertedValue = value
        
        case "Mile":
        convertedValue = (value * 0.00000000000062137)
        
        case "Yard":
        convertedValue = (value * 0.0000000010936)
        
        case "Foot":
        convertedValue = (value * 0.0000000032808)
        
        case "Inch":
        convertedValue = (value * 0.00000003937)
        
        case "Nautical Mile":
        convertedValue = (value * 0.00000000000053996)
        
        default: break
    }
    return convertedValue
}

func mileConversion(convertTo: String, value: Double) -> Double
{
    var convertedValue: Double
    convertedValue = 0.0
    
    switch(convertTo)
    {
        case "Kilometer":
        convertedValue = (value * 1.60934)
        
        case "Meter":
        convertedValue = (value * 1609.34)
        
        case "Centimeter":
        convertedValue = (value * 160934)
        
        case "Millimeter":
        convertedValue = (value * 1609000)
        
        case "Micrometer":
        convertedValue = (value * 1609000000)
        
        case "Nanometer":
        convertedValue = (value * 1609000000000)
        
        case "Mile":
        convertedValue = value
        
        case "Yard":
        convertedValue = (value * 1760)
        
        case "Foot":
        convertedValue = (value * 5280)
        
        case "Inch":
        convertedValue = (value * 63360)
        
        case "Nautical Mile":
        convertedValue = (value * 0.868976)
        
        default: break
    }
    return convertedValue
}

func yardConversion(convertTo: String, value: Double) -> Double
{
    var convertedValue: Double
    convertedValue = 0.0
    
    switch(convertTo)
    {
        case "Kilometer":
        convertedValue = (value * 0.0009144)
        
        case "Meter":
        convertedValue = (value * 0.9144)
        
        case "Centimeter":
        convertedValue = (value * 91.44)
        
        case "Millimeter":
        convertedValue = (value * 914.4)
        
        case "Micrometer":
        convertedValue = (value * 914400)
        
        case "Nanometer":
        convertedValue = (value * 914400000)
        
        case "Mile":
        convertedValue = (value * 0.000568182)
        
        case "Yard":
        convertedValue = value
        
        case "Foot":
        convertedValue = (value * 3)
        
        case "Inch":
        convertedValue = (value * 36)
        
        case "Nautical Mile":
        convertedValue = (value * 0.000493737)
        
        default: break
    }
    return convertedValue
}

func footConversion(convertTo: String, value: Double) -> Double
{
    var convertedValue: Double
    convertedValue = 0.0
    
    switch(convertTo)
    {
        case "Kilometer":
        convertedValue = (value * 0.0003048)
        
        case "Meter":
        convertedValue = (value * 0.3048)
        
        case "Centimeter":
        convertedValue = (value * 30.48)
        
        case "Millimeter":
        convertedValue = (value * 304.8)
        
        case "Micrometer":
        convertedValue = (value * 304800)
        
        case "Nanometer":
        convertedValue = (value * 304800000)
        
        case "Mile":
        convertedValue = (value * 0.000189394)
        
        case "Yard":
        convertedValue = (value * 0.3333336)
        
        case "Foot":
        convertedValue = value
        
        case "Inch":
        convertedValue = (value * 12)
        
        case "Nautical Mile":
        convertedValue = (value * 0.000164579)
        
        default: break
    }
    return convertedValue
}

func inchConversion(convertTo: String, value: Double) -> Double
{
    var convertedValue: Double
    convertedValue = 0.0
    
    switch(convertTo)
    {
        case "Kilometer":
        convertedValue = (value * 0.0000254)
        
        case "Meter":
        convertedValue = (value * 0.0254)
        
        case "Centimeter":
        convertedValue = (value * 2.54)
        
        case "Millimeter":
        convertedValue = (value * 25.4)
        
        case "Micrometer":
        convertedValue = (value * 25400)
        
        case "Nanometer":
        convertedValue = (value * 25400000)
        
        case "Mile":
        convertedValue = (value * 0.000015783)
        
        case "Yard":
        convertedValue = (value * 0.0277778)
        
        case "Foot":
        convertedValue = (value * 0.0833333)
        
        case "Inch":
        convertedValue = value
        
        case "Nautical Mile":
        convertedValue = (value * 0.000013715)
        
        default: break
    }
    return convertedValue
}

func nauticalMileConversion(convertTo: String, value: Double) -> Double
{
    var convertedValue: Double
    convertedValue = 0.0
    
    switch(convertTo)
    {
        case "Kilometer":
        convertedValue = (value * 1.852)
        
        case "Meter":
        convertedValue = (value * 1852)
        
        case "Centimeter":
        convertedValue = (value * 185200)
        
        case "Millimeter":
        convertedValue = (value * 1852000)
        
        case "Micrometer":
        convertedValue = (value * 1852000000)
        
        case "Nanometer":
        convertedValue = (value * 1852000000000)
        
        case "Mile":
        convertedValue = (value * 1.15078)
        
        case "Yard":
        convertedValue = (value * 2025.37)
        
        case "Foot":
        convertedValue = (value * 6076.12)
        
        case "Inch":
        convertedValue = (value * 72913.4)
        
        case "Nautical Mile":
        convertedValue = value
        
        default: break
    }
    return convertedValue
}

func metricTonConversion(convertTo: String, value: Double) -> Double
{
    var convertedValue: Double
    convertedValue = 0.0
    
    switch(convertTo)
    {
        case "Metric Ton":
        convertedValue = value
        
        case "Kilogram":
        convertedValue = (value * 1000)
        
        case "Gram":
        convertedValue = (value * 1000000)
        
        case "Milligram":
        convertedValue = (value * 1000000000)
        
        case "Microgram":
        convertedValue = (value * 1000000000000)
        
        case "Imperial Ton":
        convertedValue = (value * 0.984207)
        
        case "US Ton":
        convertedValue = (value * 1.10231)
        
        case "Stone":
        convertedValue = (value * 157.473)
        
        case "Pound":
        convertedValue = (value * 2204.62)
        
        case "Ounce":
        convertedValue = (value * 35274)
        
        default: break
    }
    return convertedValue
}

func kilogramConversion(convertTo: String, value: Double) -> Double
{
    var convertedValue: Double
    convertedValue = 0.0
    
    switch(convertTo)
    {
        case "Metric Ton":
        convertedValue = (value * 0.001)
        
        case "Kilogram":
        convertedValue = value
        
        case "Gram":
        convertedValue = (value * 1000)
        
        case "Milligram":
        convertedValue = (value * 1000000)
        
        case "Microgram":
        convertedValue = (value * 1000000000)
        
        case "Imperial Ton":
        convertedValue = (value * 0.000984207)
        
        case "US Ton":
        convertedValue = (value * 0.00110231)
        
        case "Stone":
        convertedValue = (value * 0.157473)
        
        case "Pound":
        convertedValue = (value * 2.20462)
        
        case "Ounce":
        convertedValue = (value * 35.274)
        
        default: break
    }
    return convertedValue
}

func gramConversion(convertTo: String, value: Double) -> Double
{
    var convertedValue: Double
    convertedValue = 0.0
    
    switch(convertTo)
    {
        case "Metric Ton":
        convertedValue = (value * 0.000001)
        
        case "Kilogram":
        convertedValue = (value * 0.001)
        
        case "Gram":
        convertedValue = value
        
        case "Milligram":
        convertedValue = (value * 1000)
        
        case "Microgram":
        convertedValue = (value * 1000000)
        
        case "Imperial Ton":
        convertedValue = (value * 0.00000098421)
        
        case "US Ton":
        convertedValue = (value * 0.0000011023)
        
        case "Stone":
        convertedValue = (value * 0.000157473)
        
        case "Pound":
        convertedValue = (value * 0.00220462)
        
        case "Ounce":
        convertedValue = (value * 0.035274)
        
        default: break
    }
    return convertedValue
}

func milligramTonConversion(convertTo: String, value: Double) -> Double
{
    var convertedValue: Double
    convertedValue = 0.0
    
    switch(convertTo)
    {
    case "Metric Ton":
        convertedValue = (value * )
        
    case "Kilogram":
        convertedValue = (value * 1000)
        
    case "Gram":
        convertedValue = (value * 1000000)
        
    case "Milligram":
        convertedValue = value
        
    case "Microgram":
        convertedValue = (value * 1000000000000)
        
    case "Imperial Ton":
        convertedValue = (value * 0.984207)
        
    case "US Ton":
        convertedValue = (value * 1.10231)
        
    case "Stone":
        convertedValue = (value * 157.473)
        
    case "Pound":
        convertedValue = (value * 2204.62)
        
        case "Ounce":
        convertedValue = (value * 0.000035274)
        
        default: break
    }
    return convertedValue
}

func microgramConversion(convertTo: String, value: Double) -> Double
{
    var convertedValue: Double
    convertedValue = 0.0
    
    switch(convertTo)
    {
    case "Metric Ton":
        convertedValue = (value * )
        
    case "Kilogram":
        convertedValue = (value * 1000)
        
    case "Gram":
        convertedValue = (value * 1000000)
        
    case "Milligram":
        convertedValue = (value * 1000000000)
        
    case "Microgram":
        convertedValue = value
        
    case "Imperial Ton":
        convertedValue = (value * 0.984207)
        
    case "US Ton":
        convertedValue = (value * 1.10231)
        
    case "Stone":
        convertedValue = (value * 157.473)
        
    case "Pound":
        convertedValue = (value * 2204.62)
        
    case "Ounce":
        convertedValue = (value * 35274)
        
    default: break
    }
    return convertedValue
}

func imperialTonConversion(convertTo: String, value: Double) -> Double
{
    var convertedValue: Double
    convertedValue = 0.0
    
    switch(convertTo)
    {
    case "Metric Ton":
        convertedValue = (value * )
        
    case "Kilogram":
        convertedValue = (value * 1000)
        
    case "Gram":
        convertedValue = (value * 1000000)
        
    case "Milligram":
        convertedValue = (value * 1000000000)
        
    case "Microgram":
        convertedValue = (value * 1000000000000)
        
        case "Imperial Ton":
        convertedValue = value
        
    case "US Ton":
        convertedValue = (value * 1.10231)
        
    case "Stone":
        convertedValue = (value * 157.473)
        
    case "Pound":
        convertedValue = (value * 2204.62)
        
    case "Ounce":
        convertedValue = (value * 35274)
        
        default: break
    }
    return convertedValue
}

func USTonConversion(convertTo: String, value: Double) -> Double
{
    var convertedValue: Double
    convertedValue = 0.0
    
    switch(convertTo)
    {
        case "Metric Ton":
        convertedValue = (value * 0.907185)
        
        case "Kilogram":
        convertedValue = (value * 907.185)
        
        case "Gram":
        convertedValue = (value * 907185)
        
        case "Milligram":
        convertedValue = (value * 907200000)
        
        case "Microgram":
        convertedValue = (value * 907200000000)
        
        case "Imperial Ton":
        convertedValue = (value * 0.892857)
        
        case "US Ton":
        convertedValue = value
        
        case "Stone":
        convertedValue = (value * 142.857)
        
        case "Pound":
        convertedValue = (value * 2000)
        
        case "Ounce":
        convertedValue = (value * 32000)
        
        default: break
    }
    return convertedValue
}

func stoneConversion(convertTo: String, value: Double) -> Double
{
    var convertedValue: Double
    convertedValue = 0.0
    
    switch(convertTo)
    {
        case "Metric Ton":
        convertedValue = (value * 0.00635029)
        
        case "Kilogram":
        convertedValue = (value * 6.35029)
        
        case "Gram":
        convertedValue = (value * 6350.29)
        
        case "Milligram":
        convertedValue = (value * 6350000)
        
        case "Microgram":
        convertedValue = (value * 6350000000)
        
        case "Imperial Ton":
        convertedValue = (value * 0.00625)
        
        case "US Ton":
        convertedValue = (value * 0.007)
        
        case "Stone":
        convertedValue = value
        
        case "Pound":
        convertedValue = (value * 14)
        
        case "Ounce":
        convertedValue = (value * 224)
        
        default: break
    }
    return convertedValue
}

func poundConversion(convertTo: String, value: Double) -> Double
{
    var convertedValue: Double
    convertedValue = 0.0
    
    switch(convertTo)
    {
        case "Metric Ton":
        convertedValue = (value * 0.000453592)
        
        case "Kilogram":
        convertedValue = (value * 0.453592)
        
        case "Gram":
        convertedValue = (value * 453.592)
        
        case "Milligram":
        convertedValue = (value * 453592)
        
        case "Microgram":
        convertedValue = (value * 453600000)
        
        case "Imperial Ton":
        convertedValue = (value * 0.000446429)
        
        case "US Ton":
        convertedValue = (value * 0.0005)
        
        case "Stone":
        convertedValue = (value * 0.0714286)
        
        case "Pound":
        convertedValue = value
        
        case "Ounce":
        convertedValue = (value * 16)
        
        default: break
    }
    return convertedValue
}

func ounceConversion(convertTo: String, value: Double) -> Double
{
    var convertedValue: Double
    convertedValue = 0.0
    
    switch(convertTo)
    {
        case "Metric Ton":
        convertedValue = (value * 0.00002835)
        
        case "Kilogram":
        convertedValue = (value * 0.0283495)
        
        case "Gram":
        convertedValue = (value * 28.3495)
        
        case "Milligram":
        convertedValue = (value * 28349.5)
        
        case "Microgram":
        convertedValue = (value * 28350000)
        
        case "Imperial Ton":
        convertedValue = (value * 0.000027902)
        
        case "US Ton":
        convertedValue = (value * 0.00003125)
        
        case "Stone":
        convertedValue = (value * 0.00446429)
        
        case "Pound":
        convertedValue = (value * 0.0625)
        
        case "Ounce":
        convertedValue = value
        
        default: break
    }
    return convertedValue
}

func celsiusConversion(convertTo: String, value: Double) -> Double
{
    var convertedValue: Double
    convertedValue = 0.0
    
    switch(convertTo)
    {
        case "Celsius":
        convertedValue = value
        
        case "Fahrenheit":
        convertedValue = ((value * 1.8) + 32)
        
        case "Kelvin":
        convertedValue = (value + 273.15)
        
        default: break
    }
    return convertedValue
}

func fahrenheitConversion(convertTo: String, value: Double) -> Double
{
    var convertedValue: Double
    convertedValue = 0.0
    
    switch(convertTo)
    {
        case "Celsius":
        convertedValue = ((value * 0.5556) - 17.7778)
        
        case "Fahrenheit":
        convertedValue = value
        
        case "Kelvin":
        convertedValue = ((value * 0.556) + 255.372)
        
        default: break
    }
    return convertedValue
}

func kelvinConversion(convertTo: String, value: Double) -> Double
{
    var convertedValue: Double
    convertedValue = 0.0
    
    switch(convertTo)
    {
        case "Celsius":
        convertedValue = (value - 273.15)
        
        case "Fahrenheit":
        convertedValue = ((value * 1.8) - 459.67)
        
        case "Kelvin":
        convertedValue = value
        
        default: break
    }
    return convertedValue
}
