//
//  AddToWhitelistView.swift
//  d’AMP
//
//  Created by Eric Jacobsen on 9/14/21.
//

import SwiftUI
import Combine

enum ValidationError: LocalizedError {
    case badDomainName

    var errorDescription: String? {
        switch self {
        case .badDomainName:
            return "Invalid domain name."
        }
    }
}

struct AddToWhitelistView: View {
    @Environment(\.dismiss) var dismiss
    @State private var domainName: String = ""
    @State private var isEditing = false

    @StateObject var userSettings: UserSettings
    @EnvironmentObject var errorHandling: ErrorHandling
    
    var body: some View {
        ZStack {
            FxView(
                contrastRed: SwiftUI.Color(red: 190/255, green: 25/255, blue: 45/255),
                shineRed: SwiftUI.Color(red: 180/255, green: 15/255, blue: 35/255),
                highShineRed: SwiftUI.Color(red: 170/255, green: 5/255, blue: 25/255),
                darkRed: SwiftUI.Color(red: 190/255, green: 25/255, blue: 45/255),
                stripeRed: SwiftUI.Color(red: 195/255, green: 30/255, blue: 50/255),
                spread: 0.2
            )
            VStack {
                HStack {
                    Spacer()
                    Button(action: {
                        dismiss()
                    }) {
                        Text("Cancel")
                            .foregroundColor(.white)
                    }
                }
                .padding()
                
                Text("Whitelist")
                    .font(.custom("Cochin-BoldItalic", size: 60))
                    .foregroundColor(.white)
                
                HStack {
                    Text("d’AMP will ignore any website whose canonical domain name is on the whitelist.")
                        .foregroundColor(.white)
                        .padding(EdgeInsets(top: 1, leading: 0, bottom: 0, trailing: 0))
                    Spacer()
                }
                
                HStack {
                    TextField(
                        "Domain name",
                         text: $domainName
                    )
                        .foregroundColor(.black)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                        .padding()
                        .background(.white)
                    Button(action: {
                        addItem(domainName)
                    }) {
                        Text("Add")
                            .foregroundColor(.white)
                    }
                    .padding()
                }
                .padding(EdgeInsets(top: 20, leading: 0, bottom: 20, trailing: 0))

                HStack {
                    Text("example: To view AMP pages for *The Guardian*, type **amp.theguardian.com** to the input below, and click **Add**.")
                        .font(.caption)
                        .foregroundColor(.white)
                    Spacer()
                }

                Spacer()
            }
            .padding()
        }
        .background(SwiftUI.Color(red: 215/255, green: 51/255, blue: 70/255))
    }
    
    private func validate(_ domainName: String) throws {
        let possibleURL: String = "https://" + domainName

        let urlRegEx = "(http|https)://((\\w)*|([0-9]*)|([-|_])*)+([\\.|/]((\\w)*|([0-9]*)|([-|_])*))+"
        guard NSPredicate(format: "SELF MATCHES %@", urlRegEx).evaluate(with: possibleURL) else {
            throw ValidationError.badDomainName
        }
    }

    private func addItem(_ domainName: String) {
        do {
            let filteredDomainName = domainName.replacingOccurrences(of: "http://", with: "").replacingOccurrences(of: "https://", with: "")
            if(userSettings.whiteList.contains(filteredDomainName)) {
                dismiss()
                return
            }
            try self.validate(filteredDomainName)
            userSettings.whiteList.append(filteredDomainName)
            dismiss()
        } catch {
            self.errorHandling.handle(error: error)
        }
    }
}


struct ErrorAlert: Identifiable {
    var id = UUID()
    var message: String
    var dismissAction: (() -> Void)?
}


class ErrorHandling: ObservableObject {
    @Published var currentAlert: ErrorAlert?

    func handle(error: Error) {
        currentAlert = ErrorAlert(message: error.localizedDescription)
    }
}


extension View {
    func withErrorHandling() -> some View {
        modifier(HandleErrorsByShowingAlertViewModifier())
    }
}


struct HandleErrorsByShowingAlertViewModifier: ViewModifier {
    @StateObject var errorHandling = ErrorHandling()

    func body(content: Content) -> some View {
        content
            .environmentObject(errorHandling)
            // Applying the alert for error handling using a background element
            // is a workaround, if the alert would be applied directly,
            // other .alert modifiers inside of content would not work anymore
            .background(
                EmptyView()
                    .alert(item: $errorHandling.currentAlert) { currentAlert in
                        Alert(
                            title: Text("Error"),
                            message: Text(currentAlert.message),
                            dismissButton: .default(Text("Ok")) {
                                currentAlert.dismissAction?()
                            }
                        )
                    }
            )
    }
}


extension AddToWhitelistView {
    func withErrorHandling() -> some View {
        modifier(HandleErrorsByShowingAlertViewModifier())
    }
}


struct AddToWhitelistView_Previews: PreviewProvider {
    static var previews: some View {
        AddToWhitelistView(userSettings: UserSettings()).preferredColorScheme(.light)
    }
}
