//
//  AppDelegate.swift
//  TV01
//
//  Created by Ludimila da Bela Cruz on 5/18/16.
//  Copyright © 2016 BEPiD. All rights reserved.
//

import UIKit
import TVMLKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var tvml: TVApplicationController?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        
        let tvAppContext = TVApplicationControllerContext()
        let jsURL = NSBundle.mainBundle().URLForResource("main", withExtension: "js")
        
        tvAppContext.javaScriptApplicationURL = jsURL!
        
        self.tvml = TVApplicationController(context: tvAppContext, window: self.window, delegate: self)
        
        return true
    }
}
    extension AppDelegate: TVApplicationControllerDelegate{
    
        func appController(appController: TVApplicationController, evaluateJavascriptInContext jsContext: JSContext) {
            
            jsContext.setObject(ResourceLoader.self, forKeyedSubscript: "NativeResourceLoader")
        }
        
    
    }
   


