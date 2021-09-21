//
//  InstructionsView.swift
//  d’AMP
//
//  Created by Eric Jacobsen on 9/14/21.
//

import SwiftUI

struct InstructionsView: View {
    @Environment(\.dismiss) var dismiss

    let settingsUrl = URL(string: UIApplication.openSettingsURLString)

    var body: some View {
        ZStack {
            FxView(
                contrastRed: SwiftUI.Color(red: 186/255, green: 21/255, blue: 40/255),
                shineRed: SwiftUI.Color(red: 196/255, green: 31/255, blue: 50/255),
                highShineRed: SwiftUI.Color(red: 205/255, green: 40/255, blue: 60/255),
                darkRed: SwiftUI.Color(red: 176/255, green: 11/255, blue: 30/255),
                stripeRed: SwiftUI.Color(red: 186/255, green: 21/255, blue: 40/255),
                spread: 0.4
            )
            VStack {
                HStack {
                    Spacer()
                    Button(action: {
                        dismiss()
                    }) {
                        Text("Dismiss")
                            .foregroundColor(.white)
                    }
                }
                .padding()
                
                Text("Instructions")
                    .font(.custom("Cochin-BoldItalic", size: 52))
                    .foregroundColor(.white)
                    .padding()
                
                HStack {
                    Text("1.")
                        .font(.custom("Cochin-BoldItalic", size: 36))
                        .foregroundColor(SwiftUI.Color(red: 98/255, green: 157/255, blue: 235/255))
                    Text("in **SAFARI**, tap the **aA** button in the **address bar**")
                        .foregroundColor(.white)
                        .font(.caption)
                        .onTapGesture {
                            UIApplication.shared.open(NSURL(string: "http://google.com")! as URL)
                        }
                    Spacer()
                }
                .padding(EdgeInsets(top: 0, leading: 18, bottom: 0, trailing: 18))

                HStack {
                    Text("2.")
                        .font(.custom("Cochin-BoldItalic", size: 36))
                        .foregroundColor(SwiftUI.Color(red: 98/255, green: 157/255, blue: 235/255))
                    Text("tap **MANAGE EXTENSIONS**")
                        .foregroundColor(.white)
                        .font(.caption)
                    Spacer()
                }
                .padding(EdgeInsets(top: 0, leading: 18, bottom: 0, trailing: 18))

                HStack {
                    Text("3.")
                        .font(.custom("Cochin-BoldItalic", size: 36))
                        .foregroundColor(SwiftUI.Color(red: 98/255, green: 157/255, blue: 235/255))
                    Text("turn **d’AMP** on")
                        .foregroundColor(.white)
                        .font(.caption)
                    Spacer()
                }
                .padding(EdgeInsets(top: 0, leading: 18, bottom: 0, trailing: 18))

                HStack {
                    Text("4.")
                        .font(.custom("Cochin-BoldItalic", size: 36))
                        .foregroundColor(SwiftUI.Color(red: 98/255, green: 157/255, blue: 235/255))
                    Text("in the **aA** menu, tap **d’DAMP** extension")
                        .foregroundColor(.white)
                        .font(.caption)
                    Spacer()
                }
                .padding(EdgeInsets(top: 0, leading: 18, bottom: 0, trailing: 18))

                HStack {
                    Text("!")
                        .font(.custom("Cochin-BoldItalic", size: 36))
                        .foregroundColor(SwiftUI.Color(red: 98/255, green: 157/255, blue: 235/255))
                    Text("note: you do not need to enable d’AMP for domains beyond **GOOGLE.COM**")
                        .foregroundColor(.white)
                        .font(.caption)
                    Spacer()
                }
                .padding(EdgeInsets(top: 0, leading: 18, bottom: 0, trailing: 18))

                Spacer()
            }
        }
    }
}

struct InstructionsView_Previews: PreviewProvider {
    static var previews: some View {
        InstructionsView().preferredColorScheme(.light)
    }
}
