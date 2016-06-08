//
//  ResourceLoader.swift
//  TV01
//
//  Created by Ludimila da Bela Cruz on 5/18/16.
//  Copyright © 2016 BEPiD. All rights reserved.
//

import UIKit
import JavaScriptCore


@objc protocol ResourceLoaderExport : JSExport{
    
    static func create()-> ResourceLoaderExport
    func loadBundleResource(name: String) -> String

}



@objc class  ResourceLoader: NSObject, ResourceLoaderExport{
    
    
    static func create()-> ResourceLoaderExport{
        
        return ResourceLoader()
        
    }
    
    
    
    
    func loadBundleResource(name: String) -> String {
        
        
        let path = NSBundle.mainBundle().pathForResource(name, ofType: nil)
        
        do{
            
            return try String(contentsOfFile: path!, encoding: NSUTF8StringEncoding)
            
        }catch{
            
            return ""
        }
        
    }
}

