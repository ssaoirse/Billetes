//
//  Bundle+Extension.swift
//  Billetes
//
//  Created by Gayatri Nagarkar on 04/01/18.
//  Copyright © 2018 Gayatri Nagarkar. All rights reserved.
//

import Foundation

extension Bundle {
    var displayName: String {
        return (Bundle.main.object(forInfoDictionaryKey: "CFBundleDisplayName") as? String) ??
            (Bundle.main.object(forInfoDictionaryKey: kCFBundleNameKey as String) as? String) ?? ""
    }
}
