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
        
        describe("a signal of numbers") {
            
            var signal: Signal<Int>!
            
            beforeEach {
                signal = Signal<Int>()
            }
            
            context("after several values are sent") {
                
                beforeEach {
                    signal.send(1)
                    signal.send(2)
                    signal.send(3)
                }
                
                describe("an observer added then") {
                    
                    var values: [Int]!
                    
                    beforeEach {
                        values = [Int]()
                        signal.observe { values.append($0) }
                    }
                    
                    context("after several values are sent") {
                        
                        beforeEach {
                            signal.send(4)
                            signal.send(5)
                            signal.send(6)
                        }
                        
                        it("does not receives any values sent before beginning observation") {
                            expect(values).toNotEventually(contain(1))
                            expect(values).toNotEventually(contain(2))
                            expect(values).toNotEventually(contain(3))
                        }
                        
                        it("receives the values sent after beginning observation in the order") {
                            expect(values).toEventually(equal([4, 5, 6]))
                        }
                        
                    }
                    
                    context("after several values are sent concurrently") {
                        
                        beforeEach {
                            let queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
                            dispatch_async(queue) {
                                signal.send(4)
                            }
                            dispatch_async(queue) {
                                signal.send(5)
                            }
                            dispatch_async(queue) {
                                signal.send(6)
                            }
                        }
                        
                        it("does not receives any values sent before beginning observation") {
                            expect(values).toNotEventually(contain(1))
                            expect(values).toNotEventually(contain(2))
                            expect(values).toNotEventually(contain(3))
                        }
                        
                        it("receives the values sent after beginning observation (regardless of the order)") {
                            expect(values).toEventually(contain(4))
                            expect(values).toEventually(contain(5))
                            expect(values).toEventually(contain(6))
                        }
                        
                    }
                    
                }
                
            }
            
        }
        
    }
    
}
