//
//  CombineViewController.swift
//  Spin.UIKit.Demo.Basic
//
//  Created by Thibault Wittemberg on 2020-02-11.
//  Copyright © 2020 Spinners. All rights reserved.
//

import Spin_Swift
import Spin_Combine
import UIKit

class CombineViewController: UIViewController {

    @IBOutlet weak var debugStateLabel: UILabel!
    @IBOutlet weak var counterLabel: UILabel!
    @IBOutlet weak var toggleButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!

    private var uiSpin: CombineUISpin<State, Event>!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let countdownSpin = Spinner
             .from(initialState: State.fixed(value: 10))
             .add(feedback: DispatchQueueCombineFeedback(effect: decreaseEffect))
             .add(feedback: DispatchQueueCombineFeedback(effect: increaseEffect))
             .reduce(with: CombineReducer(reducer: reducer))

         self.uiSpin = CombineUISpin(spin: countdownSpin)
         self.uiSpin.render(on: self, using: { $0.render(state:) })
         self.uiSpin.spin()
    }

    @IBAction func toggleButton(_ sender: UIButton) {
        self.uiSpin.emit(.toggle)
    }
    
    @IBAction func resetButton(_ sender: UIButton) {
        self.uiSpin.emit(.reset(value: 10))
    }
}

private extension CombineViewController {
    func render(state: State) {

        self.debugStateLabel.text = "state = \(state)"

        switch state {
        case .fixed(let value):
            self.counterLabel.text = "\(value)"
            self.counterLabel.textColor = .green
            self.toggleButton.isEnabled = true
            self.resetButton.isEnabled = false
            self.toggleButton.setTitle("Start", for: .normal)
        case .decreasing(let value, let paused):
            self.counterLabel.text = "\(value)"
            self.counterLabel.textColor = .red
            self.toggleButton.isEnabled = true
            self.toggleButton.setTitle(paused ? "Start": "Pause", for: .normal)
            self.resetButton.isEnabled = true
        case .increasing(let value, let paused):
            self.counterLabel.text = "\(value)"
            self.counterLabel.textColor = .blue
            self.toggleButton.isEnabled = true
            self.toggleButton.setTitle(paused ? "Start": "Pause", for: .normal)
            self.resetButton.isEnabled = true
        }
    }
}
