//
//  WeakObject.swift
//  
//
//  Created by Minhyuk Kim on 2020/03/14.
//

import Foundation

class WeakObject<T: AnyObject & Hashable>: Equatable, Hashable {
    weak var object: T?
    init(object: T) {
        self.object = object
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(object)
        
        if var object = object {
            hasher.combine(UnsafeMutablePointer<T>(&object).hashValue)
        }
    }
    
    var hashValue: Int {
        if var object = object { return UnsafeMutablePointer<T>(&object).hashValue }
        return 0
    }
    
    static func == (lhs: WeakObject<T>, rhs: WeakObject<T>) -> Bool {
        return lhs.object === rhs.object
    }
}

class WeakObjectSet<T: AnyObject & Hashable> {
    var objects: Set<WeakObject<T>>

    init() {
        self.objects = Set<WeakObject<T>>([])
    }

    init(objects: [T]) {
        self.objects = Set<WeakObject<T>>(objects.map { WeakObject(object: $0) })
    }

    var allObjects: [T] {
        return objects.compactMap { $0.object }
    }

    func contains(_ object: T) -> Bool {
        return self.objects.contains(WeakObject(object: object))
    }

    func addObject(_ object: T) {
        self.objects.formUnion([WeakObject(object: object)])
    }

    func addObjects(_ objects: [T]) {
        self.objects.formUnion(objects.map { WeakObject(object: $0) })
    }
}
