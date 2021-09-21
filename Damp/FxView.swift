//
//  FxView.swift
//  d’AMP
//
//  Created by Eric Jacobsen on 9/20/21.
//

import SwiftUI
import Foundation
import Combine
import UIKit



//enum DeviceTraits {
//    static var highContrast: Bool {
//        return UIView().traitCollection.accessibilityContrast == .high
//    }
//}



struct FxView: View {
    
    @ObservedObject var manager: MotionManager = MotionManager()

    var contrastRed = SwiftUI.Color(red: 220/255, green: 55/255, blue: 75/255)
    var shineRed = SwiftUI.Color(red: 230/255, green: 75/255, blue: 85/255)
    var highShineRed = SwiftUI.Color(red: 245/255, green: 90/255, blue: 100/255)
    var darkRed = SwiftUI.Color(red: 186/255, green: 21/255, blue: 40/255)
    var stripeRed = SwiftUI.Color(red: 215/255, green: 50/255, blue: 70/255)
    var spread: Double = 0.15 // width of shine / 2
    
    var body: some View {
        ZStack {
            // device background color
            Rectangle()
                .background(darkRed)
            
            // "shine" fx
            Rectangle()
                .fill(
                    LinearGradient(
                        gradient: Gradient(stops: [
                            .init(color: contrastRed, location: 0),
                            .init(color: shineRed, location: CGFloat(clamp((0.5 - spread) - manager.roll, minValue: 0.01, maxValue: 0.85))),
                            .init(color: highShineRed, location: CGFloat(clamp(0.5 - manager.roll, minValue: 0.1, maxValue: 0.9))),
                            .init(color: shineRed, location: CGFloat(clamp((0.5 + spread) - manager.roll, minValue: 0.15, maxValue: 0.99))),
                            .init(color: contrastRed, location: 1)
                        ]),
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
            
            // stripes over shine
            Rectangle()
                .fill(stripeRed)
                .mask(
                    Image("tile")
                        .resizable(resizingMode: .tile)
                )

            // smoov transition from device color to UI
            VStack {
                Rectangle()
                    .fill(
                        LinearGradient(
                            gradient: Gradient(colors: [
                                darkRed,
                                darkRed.opacity(0)
                            ]),
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )
                    .frame(height: 100)
                Spacer()
                Rectangle()
                    .fill(
                        LinearGradient(
                            gradient: Gradient(colors: [
                                darkRed,
                                darkRed.opacity(0)
                            ]),
                            startPoint: .bottom,
                            endPoint: .top
                        )
                    )
                    .frame(height: 100)
            }
            
        }
    }

}


struct FxView_Previews: PreviewProvider {
    static var previews: some View {
        FxView().preferredColorScheme(.light)
    }
}
