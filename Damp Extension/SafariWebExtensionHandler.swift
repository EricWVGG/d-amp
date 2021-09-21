//
//  SafariWebExtensionHandler.swift
//  Damp Extension
//
//  Created by Eric Jacobsen on 9/13/21.
//

import SafariServices
import os.log

enum MyError: Error {
    case runtimeError(String)
}

class SafariWebExtensionHandler: NSObject, NSExtensionRequestHandling {

    func beginRequest(with context: NSExtensionContext) {
        // Unpack the message from Safari Web Extension.
        let item = context.inputItems[0] as? NSExtensionItem
        let message = item?.userInfo?[SFExtensionMessageKey] as? String
        if( message != "get_damp_whitelist" ) {
            return
        }

        let defaults = UserDefaults(suiteName: "com.wvgg.Damp")
        let whiteList = defaults!.object(forKey: "whiteList") as? [String] ?? ["example.com"]

        let response = NSExtensionItem()
        response.userInfo = [ SFExtensionMessageKey: [ "damp_whitelist": whiteList ] ]
        
        context.completeRequest(returningItems: [response], completionHandler: nil)
    }

}
