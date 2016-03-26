//
//  SignalSpec.swift
//  CRToastSwiftTests
//
//  Copyright (c) 2015 Masahiko Tsujita <tsujitamasahiko.dev@icloud.com>
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import XCTest
import Nimble
import Quick
@testable import CRToastSwift

class SignalSpec: QuickSpec {
    
    override func spec() {
        
        describe("the signal of numbers") {
            
            var signal: Signal<Int>!
            var values: [Int]!
            
            beforeEach {
                signal = Signal<Int>()
                values = []
                signal.observe { _ in }
                signal.observe { values.append($0) }
                signal.observe { _ in }
            }
                
            context("after sending a number to the signal") {
                
                beforeEach {
                    signal.send(1)
                }
                
                it("notifies the number") {
                    expect(values).toEventually(equal([1]))
                }
                
            }
            
            context("after sending multiple numbers to the signal in order") {
                
                beforeEach {
                    signal.send(1)
                    signal.send(2)
                    signal.send(3)
                }
                
                it("notifies the numbers in order") {
                    expect(values).toEventually(equal([1, 2, 3]))
                }
                
            }
            
            context("after sending multiple numbers to the signal concurrently") {
                
                beforeEach {
                    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
                        signal.send(1)
                    }
                    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
                        signal.send(2)
                    }
                    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
                        signal.send(3)
                    }
                }
                
                it("notifies the all numbers") {
                    expect(values).toEventually(contain(1))
                    expect(values).toEventually(contain(2))
                    expect(values).toEventually(contain(3))
                }
                
            }
            
        }
        
    }
    
}
