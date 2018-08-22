//
//  Form.swift
//  Form
//
//  Created by Swain Molster on 8/22/18.
//  Copyright © 2018 OneAfternoon. All rights reserved.
//

import UIKit

public enum Context {
    case navigationController(UINavigationController)
    
    func push(viewController: UIViewController) {
        switch self {
        case .navigationController(let nav):
            nav.pushViewController(viewController, animated: true)
        }
    }
}

class MyViewController: UIViewController {
    convenience init(done: @escaping (String) -> Void) {
        self.init()
    }
}

public class Step<Model> {
    
    public typealias BeginFunction = (_ form: Form<Model>, _ context: Context, _ completion: @escaping () -> Void) -> Void
    
    internal let begin: BeginFunction
    
    public init(begin: @escaping BeginFunction) {
        self.begin = begin
    }
}

public class Form<BigModel> {
    internal var state: BigModel
    private let steps: [Step<BigModel>]
    private let completion: (BigModel) -> Void
    
    public init(initial: BigModel, steps: [Step<BigModel>], completion: @escaping (BigModel) -> Void) {
        self.state = initial
        self.steps = steps
        self.completion = completion
    }
    
    public func begin(in context: Context) {
        func beginStep(at index: Int) {
            if index == self.steps.count-1 {
                self.steps[index].begin(self, context) {
                    self.completion(self.state)
                }
            } else {
                self.steps[index].begin(self, context) {
                    beginStep(at: index+1)
                }
            }
        }
        beginStep(at: 0)
    }
}
