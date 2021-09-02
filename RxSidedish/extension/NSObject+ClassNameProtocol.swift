//
//  NSObject+ClassNameProtocol.swift
//  RxSidedish
//
//  Created by Issac on 2021/09/02.
//

import Foundation

public protocol ClassNameProtocol {
    static var className: String { get }
    var className: String { get }
}

public extension ClassNameProtocol {
    static var className: String {
        return String(describing: self)
    }

    var className: String {
        return type(of: self).className
    }
}

extension NSObject: ClassNameProtocol { }


