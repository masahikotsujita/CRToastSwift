//
//  NotificationSpec.swift
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

class NotificationSpec: QuickSpec {
    
    override func spec() {
        
        describe("the notification initialized with text and subtext") {
            
            let notification = Notification(text: "AAA", subtext: "BBB")
            
            it("has given text and subtext on initialization") {
                expect(notification.text).to(equal("AAA"))
                expect(notification.subtext).to(equal("BBB"))
            }
            
        }
        
        describe("the notification initialized with text only") {
            
            let notification = Notification(text: "AAA")
            
            it("has nil subtext") {
                expect(notification.subtext).to(beNil())
            }
            
        }
        
        context("after setting text") {
            
            var notification: Notification!
            
            beforeEach {
                notification = Notification(text: "AAA", subtext: "BBB")
                notification.text = "CCC"
            }
            
            it("has set text") {
                expect(notification.text).to(equal("CCC"))
            }
            
            it("has same subtext as before") {
                expect(notification.subtext).to(equal("BBB"))
            }
            
        }
        
        context("after setting subtext") {
            
            var notification: Notification!
            
            beforeEach {
                notification = Notification(text: "AAA", subtext: "BBB")
                notification.subtext = "DDD"
            }
            
            it("has set subtext") {
                expect(notification.subtext).to(equal("DDD"))
            }
            
            it("has same text as before") {
                expect(notification.text).to(equal("AAA"))
            }
            
        }
        
    }
    
}
