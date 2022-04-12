//
//  Content-ViewModel.swift
//  favs
//
//  Created by Federico on 12/04/2022.
//

import Foundation
import SwiftUI

extension ContentView {
    final class ViewModel: ObservableObject {
        @Published var items = [Item]()
        @Published var showingFavs = false
        @Published var savedItems: Set<Int> = [1, 7]
        
        // Filter saved items
        var filteredItems: [Item]  {
            if showingFavs {
                var newList = [Item]()
                
                for item in items {
                    for saved in savedItems {
                        if saved == item.id {
                            newList.append(item)
                        }
                    }
                }
                return newList
            }
            return items
        }
        
        private var db = Database()
        
        init() {
            self.savedItems = db.load()
            self.items = Item.sampleItems
        }
        
        func filterFavs() {
            withAnimation() {
                showingFavs.toggle()
            }
        }
        
        func contains(_ item: Item) -> Bool {
                savedItems.contains(item.id)
            }
        
        // Toggle saved items
        func toggleFav(item: Item) {
            if contains(item) {
                savedItems.remove(item.id)
            } else {
                savedItems.insert(item.id)
            }
            db.save(items: savedItems)
        }
    }
}
