//
//  ContentView.swift
//  d’AMP
//
//  Created by Eric Jacobsen on 9/13/21.
//

import SwiftUI
import Foundation
import Combine
//import SafariServices.SFSafariExtensionManager
//let extensionBundleIdentifier = "com.wvgg.Damp.Damp-Extension"


struct ContentView: View {
    @State private var showingInstructions = false
    @State private var showingAddToWhitelist = false
    
    @StateObject var userSettings = UserSettings()

    //  TODO: it sure would be cool if we could inform the user if the extension is enabled.
    //  This exists for MacOS! Perhaps it will come to iOS someday. Soon.
    
    //    SFSafariExtensionManager.getStateOfSafariExtension(withIdentifier: extensionBundleIdentifier) { (state, error) in
    //        guard let state = state, error == nil else {
    //            var errorMessage: String = "Error: unable to determine state of the extension"
    //
    //            if let errorDetail = error as NSError?, errorDetail.code == 1 {
    //                errorMessage = "Couldn’t find the Native Messaging Demo extension. Are you running macOS 10.16+, or macOS 10.14+ with Safari 14+?"
    //            }
    //        }
    //    }
    
    var body: some View {
        ZStack {
            FxView()
            
            VStack {
                Text("ain’t nothing like the real thing!")
                    .font(.custom("Cochin-Italic", size: 16))
                    .foregroundColor(.white)
                    .padding(EdgeInsets(top: 50, leading: 110, bottom: -15, trailing: 20))

                Image("damp-logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 280.0)
                
                Text("The d’AMP Safari browser extension detects AMP pages and forwards users to the real websites.")
                    .font(.caption)
                    .foregroundColor(.white)
                    .frame(maxWidth: 280, alignment: .leading)
                    .padding(EdgeInsets(top: 20, leading: 0, bottom: 10, trailing: 0))
                
                Button(action: {
                    showingInstructions.toggle()
                }) {
                    Text("How to enable d’AMP")
                        .foregroundColor(.white)
                }
                .padding()
                .sheet(isPresented: $showingInstructions) {
                    InstructionsView()
                }
                
                Button(action: {
                    showingAddToWhitelist.toggle()
                }) {
                    Label("Whitelist", systemImage: "plus")
                        .foregroundColor(.white)
                }
                .sheet(isPresented: $showingAddToWhitelist) {
                    AddToWhitelistView(userSettings: userSettings).withErrorHandling()
                }

                List {
                    ForEach($userSettings.whiteList, id: \.self) { item in
                        Text(item.wrappedValue)
                    }
                    .onDelete(perform: deleteItems)
                }
                .listStyle(.plain)
                .padding()

            }
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            userSettings.whiteList.remove(atOffsets: offsets)
        }
    }
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().preferredColorScheme(.light)
    }
}
