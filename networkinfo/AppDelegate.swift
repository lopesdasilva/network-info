//
//  AppDelegate.swift
//  MyAxc
//
//  Created by Rui Silva on 15/07/2020.
//  Copyright © 2020 diconium. All rights reserved.
//

import Cocoa
import SwiftUI
import SystemConfiguration

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    var statusBarItem: NSStatusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
    var timer: Timer? = nil
       
    let statusBarMenu = NSMenu(title: "Cap Status Bar Menu");
    
    
    
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
      guard let statusButton = statusBarItem.button else { return }
            
        statusBarItem.menu = statusBarMenu
        statusBarMenu.addItem(
            withTitle: "update",
            action:  #selector(updateStatusText),
            keyEquivalent: "")
        statusBarMenu.addItem(
            withTitle: "Exit",
            action: #selector(exit),
            keyEquivalent: "")
        statusButton.title =  "Loading..."
        updateStatusText()
            timer = Timer.scheduledTimer(
                timeInterval: 600,
                target: self,
                selector: #selector(updateStatusText),
                userInfo: nil,
                repeats: true
            )
    }
    
    @objc
       func exit() {
        NSApplication.shared.terminate(self)

       }
    
    @objc
       func updateStatusText() {
           guard let statusButton = statusBarItem.button else { return }
        
        statusButton.title =  "Loading..."

        
        let url = URL(string: "https://ifconfig.co/country")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        NSURLConnection.sendAsynchronousRequest(request, queue: OperationQueue.main) {(response, data, error) in
            guard let data = data else { return }
            //print(String(data: data, encoding: .utf8)!)
            statusButton.title = String(data: data, encoding: .utf8)!.trimmingCharacters(in: .whitespacesAndNewlines)
        }
        
       }



}


struct AppDelegate_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
