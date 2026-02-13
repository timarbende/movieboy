//
//  carousel.swift
//  movieboy
//
//  Created by Bendegúz Timár on 16.10.23.
//

import SwiftUI

/// Carousel component that shows a number of children and automatically transitions between them
struct Carousel<Content: View>: View {
    /// viewBuilder function, builds the current child
    @ViewBuilder
    let childBuilder: (Int) -> Content
    
    /// viewModel
    @State var viewModel: CarouselViewModel<Content>
    
    init(childCount: Int, @ViewBuilder childBuilder: @escaping (Int) -> Content) {
        self.childBuilder = childBuilder
        viewModel = CarouselViewModel(
            index: 0, childCount: childCount
        )
    }
    
    var body: some View {
        TabView(selection: $viewModel.index) {
            ForEach((0..<viewModel.childCount), id: \.self) { index in
                childBuilder(index)
            }
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
        .animation(.easeInOut, value: viewModel.index)
        .transition(.slide)
    }
}
