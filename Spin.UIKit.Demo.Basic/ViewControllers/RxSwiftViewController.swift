//
//  RxSwiftViewController.swift
//  Spin.UIKit.Demo.Basic
//
//  Created by Thibault Wittemberg on 2020-02-11.
//  Copyright © 2020 Spinners. All rights reserved.
//

import Spin_RxSwift
import Spin_Swift
import UIKit

class RxSwiftViewController: UIViewController {

    @IBOutlet weak var counterLabel: UILabel!
    @IBOutlet weak var debugStateLabel: UILabel!
    @IBOutlet weak var toggleButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!

    private var uiSpin: RxUISpin<State, Event>!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.resetButton.layer.cornerRadius = 20
        self.resetButton.backgroundColor = .gray
        self.resetButton.setTitleColor(.white, for: .normal)

        self.toggleButton.layer.cornerRadius = 20
        self.toggleButton.backgroundColor = .gray
        self.toggleButton.setTitleColor(.white, for: .normal)

        // the countdownSpin is the formal feedback loop definition
        // it has an initial state and 2 effects that will handle
        // the decrease and increase cycles
        // the reducer function is common to ReactiveSwift/RxSwift/Combine implementation
        let countdownSpin = Spinner
            .initialState(State.fixed(value: 10))
            .feedback(RxFeedback(effect: decreaseEffect))
            .feedback(RxFeedback(effect: increaseEffect))
            .reducer(RxReducer(reducer))

        // the uiSpin is a UI decoration of the countdownSpin
        // it is a feedback loop the has 1 special UI feedback
        // that we can use to interpret the State and emit Event
        self.uiSpin = RxUISpin(spin: countdownSpin)
        self.uiSpin.render(on: self, using: { $0.render(state:) })
        self.uiSpin.start()
    }

    @IBAction func toggleButton(_ sender: UIButton) {
        self.uiSpin.emit(.toggle)
    }

    @IBAction func resetButton(_ sender: UIButton) {
        self.uiSpin.emit(.reset(value: 10))
    }
}

private extension RxSwiftViewController {
    func render(state: State) {

        self.debugStateLabel.text = "state = \(state)"

        switch state {
        case .fixed(let value):
            self.counterLabel.text = "\(value)"
            self.counterLabel.textColor = .green
            self.toggleButton.isEnabled = true
            self.resetButton.isEnabled = false
            self.resetButton.alpha = 0.5
            self.toggleButton.setTitle("Start", for: .normal)
        case .decreasing(let value, let paused):
            self.counterLabel.text = "\(value)"
            self.counterLabel.textColor = .red
            self.toggleButton.isEnabled = true
            self.toggleButton.setTitle(paused ? "Start": "Stop", for: .normal)
            self.resetButton.isEnabled = true
            self.resetButton.alpha = 1.0
        case .increasing(let value, let paused):
            self.counterLabel.text = "\(value)"
            self.counterLabel.textColor = .blue
            self.toggleButton.isEnabled = true
            self.toggleButton.setTitle(paused ? "Start": "Stop", for: .normal)
            self.resetButton.isEnabled = true
            self.resetButton.alpha = 1.0
        }
    }
}
