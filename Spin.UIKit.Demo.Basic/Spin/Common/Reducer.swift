//
//  Reducer.swift
//  Spin.UIKit.Demo.Basic
//
//  Created by Thibault Wittemberg on 2020-02-11.
//  Copyright © 2020 Spinners. All rights reserved.
//

func reduce(state: State, event: Event) -> State {
    switch (state, event) {
    // when the countdown starts, we decrease the counter
    case (.fixed(let value), .start):
        return .decreasing(value: value, paused: false)
    // while decreasing we can pause the counter
    case (.decreasing(let value, let paused), .pause):
        return .decreasing(value: value, paused: !paused)
    // while decreasing we can continue to decrease
    case (.decreasing(let value, let paused), .decrease) where paused == false:
        return .decreasing(value: value-1, paused: false)
    // while decreasing we can start to increase
    case (.decreasing(let value, let paused), .increase) where paused == false:
        return .increasing(value: value+1, paused: false)
    // while increasing we can pause the counter
    case (.increasing(let value, let paused), .pause):
        return .increasing(value: value, paused: !paused)
    // while increasing we can continue to increase
    case (.increasing(let value, let paused), .increase) where paused == false:
        return .increasing(value: value+1, paused: false)
    // while increasing we can start to decrease
    case (.increasing(let value, let paused), .decrease) where paused == false:
        return .decreasing(value: value-1, paused: false)
    // we can reset the counter any moment
    case (.increasing, .reset(let value)), (.decreasing, .reset(let value)):
        return .fixed(value: value)
    default:
        return state
    }
}
