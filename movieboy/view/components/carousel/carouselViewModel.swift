//
//  carouselViewModel.swift
//  movieboy
//
//  Created by Bendegúz Timár on 16.10.23.
//

import Foundation
import SwiftUI

@Observable
/// Viewmodel for the carousel component
class CarouselViewModel<Content: View> {
    /// index of the currently shown child
    var index: Int = 0
    
    /// total number of children
    var childCount: Int = 0
    
    /// timer used for automatic transitioning
    var timer: Timer
    
    init(index: Int, childCount: Int) {
        self.index = index
        self.childCount = childCount
        self.timer = Timer()
        initTimer()
    }
    
    /// initializes the timer with the transitioning function
    func initTimer() {
        self.timer = Timer.scheduledTimer(
            withTimeInterval: 4,
            repeats: true,
            block: {_ in
                self.index = (self.index + 1) % self.childCount
            }
        )
    }
}
