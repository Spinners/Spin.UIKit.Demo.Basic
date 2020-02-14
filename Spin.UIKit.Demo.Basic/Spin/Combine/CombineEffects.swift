//
//  CombineEffects.swift
//  Spin.UIKit.Demo.Basic
//
//  Created by Thibault Wittemberg on 2020-02-13.
//  Copyright © 2020 Spinners. All rights reserved.
//

import Combine

func decreaseEffect(state: State) -> AnyPublisher<Event, Never> {
    guard case let State.decreasing(value, _) = state else { return Empty().eraseToAnyPublisher() }

    if value > 0 {
        return Just<Event>(.decrease).eraseToAnyPublisher()
    }

    return Just<Event>(.increase).eraseToAnyPublisher()
}

func increaseEffect(state: State) -> AnyPublisher<Event, Never> {
    guard case let State.increasing(value, _) = state else { return Empty().eraseToAnyPublisher() }

    if value < 10 {
        return Just<Event>(.increase).eraseToAnyPublisher()
    }

    return Just<Event>(.decrease).eraseToAnyPublisher()
}
