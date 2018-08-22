//
//  FormTests.swift
//  FormTests
//
//  Created by Swain Molster on 8/22/18.
//  Copyright © 2018 OneAfternoon. All rights reserved.
//

import XCTest
@testable import Form

class FormTests: XCTestCase {
    
    public func testNothing() {
        typealias SampleState = (string: String, integer: Int)
        
        let myForm = Form<SampleState>(
            initial: ("", 0),
            steps: [
                .init { form, context, completion in
                    let myVC = MyViewController { string in
                        form.state.string = string
                        completion()
                    }
                }
            ],
            completion: { model in
                print(model)
            }
        )
    }
}
