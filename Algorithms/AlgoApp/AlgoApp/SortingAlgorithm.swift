//
//  SortingAlgorithm.swift
//  AlgoApp
//
//  Created by Mustafa Bekirov on 30.01.2025.
//

import SwiftUI

enum SortingType: String, CaseIterable, Identifiable {
    case bubble = "Bubble"
    case selection = "Selection"
    case insertion = "Insertion"
    case merge = "Merge"
    case quick = "Quick"
    case parallelMerge = "Parallel Merge"
    
    var id: String {
        self.rawValue
    }
    
    var title: String {
        self.rawValue
    }
    
}

@Observable
class SortingAlgorithm {
    var items: [Int]
    var firstIndex: Int?
    var secondIndex: Int?
    
    init(items: [Int]) {
        self.items = items
    }
    
    func sort(using sortingType: SortingType) async {
        guard items.count > 1 else {
            return
        }
        
        switch sortingType {
        case .bubble:
            await bubbleSort()
        case .selection:
            await selectionSort()
        case .insertion:
            await insertionSort()
        case .merge:
            await mergeSort(0, items.count - 1)
        case .quick:
            await quickSort(0, items.count - 1)
        case .parallelMerge:
            await mergeParallelSort(0, items.count - 1)
        }
    }
    
    func reset(with items: [Int]) {
        self.items = items
        firstIndex = nil
        secondIndex = nil
    }
    
    private func delay() async {
        let duration: Duration = .seconds(SortingSettings.shared.animationDuration)
        
        if duration == .seconds(0) {
            await Task.yield()
        } else {
            try? await Task.sleep(for: duration)
        }
    }
    
    @MainActor
    private func bubbleSort() async {
        for i in 0..<items.count {
            for j in 0..<items.count - i - 1 {
                if Task.isCancelled { return }
                firstIndex = j
                secondIndex = j + 1
                if items[j] > items[j + 1] {
                    items.swapAt(j, j + 1)
                }
                
                await delay()
            }
        }
        
        firstIndex = nil
        secondIndex = nil
    }
    
    @MainActor
    private func selectionSort() async {
        for i in 0..<items.count {
            if Task.isCancelled { return }
            var minIndex = i
            firstIndex = i
            for j in (i+1)..<items.count {
                secondIndex = j
                if Task.isCancelled { return }
                //secondIndex = j
                if items[j] < items[minIndex] {
                    minIndex = j
                    firstIndex = j
                }
                
                await delay()
            }
            if minIndex != i {
                items.swapAt(i, minIndex)
            }
        }
        firstIndex = nil
        secondIndex = nil
    }
    
    @MainActor
    private func insertionSort() async {
        for i in 1..<items.count {
            if Task.isCancelled { return }
            let key = items[i]
            var j = i - 1
            firstIndex = i  // Current element being inserted
            
            while j >= 0 && items[j] > key {
                if Task.isCancelled { return }
                secondIndex = j  // Element being compared against
                items.swapAt(j + 1, j)
                j -= 1
                
                await delay()
            }
            items[j + 1] = key
            
            // Reset indices for next iteration
            secondIndex = nil
            await delay()
        }
        
        // Clear indices when done
        firstIndex = nil
        secondIndex = nil
    }
    
    @MainActor
    private func mergeSort(_ left: Int, _ right: Int) async {
        if left < right {
            if Task.isCancelled { return }
            let mid = (left + right) / 2
            await mergeSort(left, mid)
            if Task.isCancelled { return }
            await mergeSort(mid + 1, right)
            if Task.isCancelled { return }
            await merge(left, mid, right)
        }
    }
    
    @MainActor
    private func merge(_ left: Int, _ mid: Int, _ right: Int) async {
        let leftArray = Array(items[left...mid])
        let rightArray = Array(items[mid+1...right])
        var i = 0
        var j = 0
        
        for k in left...right {
            if Task.isCancelled { return }
            
            if i < leftArray.count && j < rightArray.count {
                // Compare elements from both arrays
                firstIndex = left + i
                secondIndex = mid + 1 + j
                
                if leftArray[i] <= rightArray[j] {
                    items[k] = leftArray[i]
                    i += 1
                } else {
                    items[k] = rightArray[j]
                    j += 1
                }
            } else if i < leftArray.count {
                // Only elements from left array remain
                firstIndex = left + i
                secondIndex = nil
                items[k] = leftArray[i]
                i += 1
            } else {
                // Only elements from right array remain
                firstIndex = mid + 1 + j
                secondIndex = nil
                items[k] = rightArray[j]
                j += 1
            }
            
            await delay()
        }
        
        // Clear indices when done with this merge
        firstIndex = nil
        secondIndex = nil
    }
    
    @MainActor
    private func mergeParallelSort(_ left: Int, _ right: Int) async {
        if left < right {
            if Task.isCancelled { return }
            
            let mid = (left + right) / 2
            async let merge1: Void = await mergeSort(left, mid)
            
            if Task.isCancelled { return }
            
            async let merge2: Void = await mergeSort(mid + 1, right)
            if Task.isCancelled { return }
            
            await merge1
            await merge2
            await merge(left, mid, right)
        }
    }
    
    @MainActor
    private func quickSort(_ low: Int, _ high: Int) async {
        if Task.isCancelled { return }
        if low < high {
            let pivotIndex = await partition(low, high)
            if Task.isCancelled { return }
            await quickSort(low, pivotIndex - 1)
            if Task.isCancelled { return }
            await quickSort(pivotIndex + 1, high)
        }
    }
    
    @MainActor
    private func partition(_ low: Int, _ high: Int) async -> Int {
        let pivot = items[high]
        var i = low
        firstIndex = high  // Highlight pivot element
        
        for j in low..<high {
            if Task.isCancelled { return i }
            
            secondIndex = j  // Element being compared with pivot
            if items[j] < pivot {
                items.swapAt(i, j)
                i += 1
            }
            
            await delay()
        }
        
        // Final swap to put pivot in its correct position
        secondIndex = i
        items.swapAt(i, high)
        
        await delay()
        
        // Clear indices before returning
        firstIndex = nil
        secondIndex = nil
        
        return i
    }
}
