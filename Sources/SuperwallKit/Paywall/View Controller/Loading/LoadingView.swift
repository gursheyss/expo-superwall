//
//  SwiftUIView.swift
//
//
//  Created by Yusuf Tör on 11/10/2022.
//

import SwiftUI

struct LoadingView: View {
  @ObservedObject var model: LoadingModel

  var body: some View {
    GeometryReader { proxy in
      ActivityIndicatorView(isAnimating: model.isAnimating)
        .rotationAnimation(for: model.rotationAmount)
        .padding(20)
        .darkBlurredBackground()
        .scaleAnimation(for: model.scaleAmount)
        .opacityAnimation(for: model.opacityAmount)
        .bottomPaddingAnimation(for: model.padding)
        .listen(
          to: model.$movedUp,
          fromModel: model,
          maxPadding: proxy.size.height / 2
        )
        .listen(
          to: model.$isHidden,
          fromModel: model
        )
        .frame(
          maxWidth: .infinity,
          maxHeight: .infinity
        )
        .background(
          Color.black.opacity(0.25)
            .edgesIgnoringSafeArea(.all)
        )
        .opacityAnimation(for: model.opacityAmount)
    }
  }
}

struct LoadingView_Previews: PreviewProvider {
  static var previews: some View {
    let model = LoadingModel(delegate: nil)
    model.isAnimating = true
    return LoadingView(model: model)
      .previewLayout(.sizeThatFits)
  }
}
