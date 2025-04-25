//
//  CoreDataFeedStore.swift
//  EssentialFeed
//
//  Created by Work on 03.03.2025.
//

import CoreData

public final class CoreDataFeedStore: FeedStore {
    enum StoreError: Error {
        case modelNotFound
        case failedToLoadPersistentContainer(Error)
    }
    
    private static let modelName = "FeedStore"
    private static let model = NSManagedObjectModel.with(name: modelName, in: Bundle(for: CoreDataFeedStore.self))
    
    private let container: NSPersistentContainer
    private let context: NSManagedObjectContext
    
    public init(storeURL: URL) throws {
        guard let model = CoreDataFeedStore.model else { throw StoreError.modelNotFound }
        
        do {
            self.container = try NSPersistentContainer.load(name: CoreDataFeedStore.modelName, model: model, url: storeURL)
            self.context = container.newBackgroundContext()
        } catch {
            throw StoreError.failedToLoadPersistentContainer(error)
        }
    }
    
    public func retrieve(completion: @escaping FeedStore.RetrievalCompletion) {
        perform { context in
            completion(Result(catching: {
                try ManagedCache.find(in: context).map { cache in
                    CachedFeed(feed: cache.localFeed, timestamp: cache.timestamp)
                }
            }))
        }
    }
    
    public func insert(_ feed: [LocalFeedImage], timestamp: Date, completion: @escaping FeedStore.InsertionCompletion) {
        perform { context in
            completion(Result(catching: {
                let managedCache = try ManagedCache.newUniqueInstance(in: context)
                managedCache.timestamp = timestamp
                managedCache.feed = ManagedFeedImage.images(from: feed, in: context)
                try context.save()
            }))
        }
    }
    
    public func deleteCachedFeed(completion: @escaping FeedStore.DeletionCompletion) {
        perform { context in
            completion(Result(catching: {
                try ManagedCache.find(in: context).map(context.delete).map(context.save)
            }))
        }
    }
    
    func perform(_ action: @escaping (NSManagedObjectContext) -> Void) {
        let context = self.context
        context.perform { action(context) }
    }
}
