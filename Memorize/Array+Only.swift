//
//  Array+Only.swift
//  Memorize
//
//  Created by Shimon Rothschild on 17-02-21.
//

import Foundation

extension Array {
    var only: Element? {
        count == 1 ? first : nil
    }
}
