//
//  RxSwiftEffects.swift
//  Spin.UIKit.Demo.Basic
//
//  Created by Thibault Wittemberg on 2020-02-13.
//  Copyright © 2020 Spinners. All rights reserved.
//

import RxSwift

func decreaseEffect(state: State) -> Observable<Event> {
    guard case let State.decreasing(value, _) = state else { return .empty() }

    if value > 0 {
        return .just(.decrease)
    }

    return .just(.increase)
}

func increaseEffect(state: State) -> Observable<Event> {
    guard case let State.increasing(value, _) = state else { return .empty() }

    if value < 10 {
        return .just(.increase)
    }

    return .just(.decrease)
}
