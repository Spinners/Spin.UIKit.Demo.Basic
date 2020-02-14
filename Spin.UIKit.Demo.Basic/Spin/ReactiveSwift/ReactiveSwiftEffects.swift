//
//  ReactiveSwiftEffects.swift
//  Spin.UIKit.Demo.Basic
//
//  Created by Thibault Wittemberg on 2020-02-13.
//  Copyright © 2020 Spinners. All rights reserved.
//

import ReactiveSwift

func decreaseEffect(state: State) -> SignalProducer<Event, Never> {
    guard case let State.decreasing(value, _) = state else { return .empty }

    if value > 0 {
        return SignalProducer<Event, Never>(value: .decrease)
    }

    return SignalProducer<Event, Never>(value: .increase)
}

func increaseEffect(state: State) -> SignalProducer<Event, Never> {
    guard case let State.increasing(value, _) = state else { return .empty }

    if value < 10 {
        return SignalProducer<Event, Never>(value: .increase)
    }

    return SignalProducer<Event, Never>(value: .decrease)
}
