//
//  Reducer.swift
//  Spin.UIKit.Demo.Basic
//
//  Created by Thibault Wittemberg on 2020-02-11.
//  Copyright © 2020 Spinners. All rights reserved.
//

func reduce(state: State, event: Event) -> State {
    switch (state, event) {
    case (.fixed(let value), .start):
        return .decreasing(value: value, max: value, paused: false)
    case (.decreasing(let value, let max, let paused), .pause):
        return .decreasing(value: value, max: max, paused: !paused)
    case (.decreasing(let value, let max, let paused), .decrease) where paused == false && value > 0:
        return .decreasing(value: value-1, max: max, paused: false)
    case (.decreasing(let value, let max, let paused), .decrease) where paused == false && value == 0:
        return .increasing(value: value+1, max: max, paused: false)
    case (.increasing(let value, let max, let paused), .pause):
        return .increasing(value: value, max: max, paused: !paused)
    case (.increasing(let value, let max, let paused), .increase) where paused == false && value < max:
        return .increasing(value: value+1, max: max, paused: false)
    case (.increasing(let value, let max, let paused), .increase) where paused == false && value == max:
        return .decreasing(value: value-1, max: max, paused: false)
    case (.increasing(_, let max, _), .reset), (.decreasing(_, let max, _), .reset):
        return .fixed(value: max)
    default:
        return state
    }
}
