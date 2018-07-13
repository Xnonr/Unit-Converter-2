//
//  Unit_Converter_2Tests.swift
//  Unit Converter 2Tests
//
//  Created by Maxence Brette on 6/15/18.
//  Copyright © 2018 Maxence Brette. All rights reserved.
//

import XCTest
@testable import Unit_Converter_2

class Unit_Converter_2Tests: XCTestCase {
    
    override func setUp()
    {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown()
    {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    //Tests whether the factor matrices all correctly display 1 to 1 conversion factors in a diagonal line for identical units
    func testAreaFactorMatrix()
    {
        let max: Int = (Matrices.areaFactorMatrix.count - 1)
        
        for i in 0...max
        {
            assert(Matrices.areaFactorMatrix[i][i] == 1)
            
            assert(round(Matrices.areaFactorMatrix[0][i] * Matrices.areaFactorMatrix[i][0]) == 1)
        }
    }
    
    func testLengthFactorMatrix()
    {
        let max: Int = (Matrices.lengthFactorMatrix.count - 1)
        
        for i in 0...max
        {
            assert(Matrices.lengthFactorMatrix[i][i] == 1)
            
            assert(round(Matrices.lengthFactorMatrix[0][i] * Matrices.lengthFactorMatrix[i][0]) == 1)
        }
    }
    
    func testMassLengthFactorMatrix()
    {
        let max: Int = (Matrices.massFactorMatrix.count - 1)
        
        for i in 0...max
        {
            assert(Matrices.massFactorMatrix[i][i] == 1)
            
            assert(round(Matrices.massFactorMatrix[0][i] * Matrices.massFactorMatrix[i][0]) == 1)
        }
    }
    
    func testPressureFactorMatrix()
    {
        let max: Int = (Matrices.pressureFactorMatrix.count - 1)
        
        for i in 0...max
        {
            assert(Matrices.pressureFactorMatrix[i][i] == 1)
            
            assert(round(Matrices.pressureFactorMatrix[0][i] * Matrices.pressureFactorMatrix[i][0]) == 1)
        }
    }
    
    func testSpeedFactorMatrix()
    {
        let max: Int = (Matrices.speedFactorMatrix.count - 1)
        
        for i in 0...max
        {
            assert(Matrices.speedFactorMatrix[i][i] == 1)
            
            assert(round(Matrices.speedFactorMatrix[0][i] * Matrices.speedFactorMatrix[i][0]) == 1)
        }
    }
    
    func testTimeFactorMatrix()
    {
        let max: Int = (Matrices.timeFactorMatrix.count - 1)
        
        for i in 0...max
        {
            assert(Matrices.timeFactorMatrix[i][i] == 1)
            
            assert(round(Matrices.timeFactorMatrix[0][i] * Matrices.timeFactorMatrix[i][0]) == 1)
        }
    }
    
    func testVolumeFactorMatrix()
    {
        let max: Int = (Matrices.volumeFactorMatrix.count - 1)
        
        for i in 0...max
        {
            assert(Matrices.volumeFactorMatrix[i][i] == 1)
            
            assert(round(Matrices.volumeFactorMatrix[0][i] * Matrices.volumeFactorMatrix[i][0]) == 1)
        }
    }
    
    //Tests Celsius Conversion
    func testCelsiusConversion()
    {
        let testTemperature = Array(stride(from: -30.0, through: 30.0, by: 1.0))
        var temporaryTemperature = 0.0
    
        for i in 0...59
        {
            assert(Matrices.celsiusConversion(convertTo: 0, value: testTemperature[i]) == testTemperature[i])
            
            temporaryTemperature = round(Matrices.celsiusConversion(convertTo: 1, value: testTemperature[i]))
            assert(round(Matrices.fahrenheitConversion(convertTo: 0, value: temporaryTemperature)) == testTemperature[i])
            
            temporaryTemperature = round(Matrices.celsiusConversion(convertTo: 2, value: testTemperature[i]))
            assert(round(Matrices.kelvinConversion(convertTo: 0, value: temporaryTemperature)) == testTemperature[i])
        }
    }
    
    func testPerformanceExample()
    {
        // This is an example of a performance test case.
        self.measure
        {
            // Put the code you want to measure the time of here.
        }
    }
}
