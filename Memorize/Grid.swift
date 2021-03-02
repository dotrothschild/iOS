//
//  Grid.swift
//  Memorize
//
//  Created by Shimon Rothschild on 17-02-21.
//

import SwiftUI

struct Grid<Item, ItemView>: View where Item: Identifiable, ItemView: View{ // the where are constraints because in the
                        // body foreach loop item must be identifiable and viewForItem must by constrained to type view
    private var items: [Item]
    private var viewForItem: (Item) -> ItemView
    
    
    init (_ items: [Item], viewForItem: @escaping (Item) -> ItemView) {
        self.items = items
        self.viewForItem = viewForItem
    }
    
    var body: some View {
        GeometryReader { geometry in
            body(for: GridLayout(itemCount: self.items.count, in: geometry.size))//(for: geometry.size) // only body func 1 accepts geometry.size for param
        }
    }
    // func 1 after changed geometry reader to use Gridlayout, this is not used
    private func body(for size: CGSize) -> some View {
        ForEach(items) { item in
            body(for: item, in: size)
        }
    }
    // func 2
    private func body (for item: Item, in size: CGSize) -> some View {
        return viewForItem(item)
    }
    
    //func 1b
    private func body(for layout: GridLayout) -> some View {
        ForEach(items) { item in
            self.body(for: item, in: layout)
        }
    }
    
    // func 2b
    private  func body(for item: Item, in layout: GridLayout) -> some View {
        let index = items.firstIndex(matching: item)
        return Group {
            if index != nil {
            viewForItem(item)
                .frame(width: layout.itemSize.width, height: layout.itemSize.height)
                .position(layout.location(ofItemAt: index!))
            }
        } // group will return empty view if / else
    }
}
