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
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testAreaFactorMatrix()
    {
        let max: Int = (Matrices.areaFactorMatrix.count - 1)
        
        for i in 0...max
        {
            assert(Matrices.areaFactorMatrix[i][i] == 1)
            
            assert(Matrices.areaFactorMatrix[i][i + 1] * Matrices.areaFactorMatrix[i + 1][i] == 1)
        }
    }
    
    func testLengthFactorMatrix()
    {
        let max: Int = (Matrices.lengthFactorMatrix.count - 1)
        
        for i in 0...max
        {
            assert(Matrices.lengthFactorMatrix[i][i] == 1)
        }
    }
    
    func testMassLengthFactorMatrix()
    {
        let max: Int = (Matrices.massFactorMatrix.count - 1)
        
        for i in 0...max
        {
            assert(Matrices.massFactorMatrix[i][i] == 1)
        }
    }
    
    func testPressureFactorMatrix()
    {
        let max: Int = (Matrices.pressureFactorMatrix.count - 1)
        
        for i in 0...max
        {
            assert(Matrices.pressureFactorMatrix[i][i] == 1)
        }
    }
    
    func testSpeedFactorMatrix()
    {
        let max: Int = (Matrices.speedFactorMatrix.count - 1)
        
        for i in 0...max
        {
            assert(Matrices.speedFactorMatrix[i][i] == 1)
        }
    }
    
    func testTimeFactorMatrix()
    {
        let max: Int = (Matrices.timeFactorMatrix.count - 1)
        
        for i in 0...max
        {
            assert(Matrices.timeFactorMatrix[i][i] == 1)
        }
    }
    
    func testVolumeFactorMatrix()
    {
        let max: Int = (Matrices.volumeFactorMatrix.count - 1)
        
        for i in 0...max
        {
            assert(Matrices.volumeFactorMatrix[i][i] == 1)
        }
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
