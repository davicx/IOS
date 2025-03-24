//
//  PollingManager.swift
//  Kite
//
//  Created by David Vasquez on 3/23/25.
//

import Foundation


class PollingManager {
    private var timer: Timer?
    private var failureCount = 0
    private var pauseCount = 0
    private var isPollingPaused = false
    private let pollingInterval: TimeInterval
    private let maxFailures = 4
    private let maxPauses = 3
    private let pauseDuration: TimeInterval = 300 // 5 minutes
    
    var onFetchPosts: (() -> Void)?
    
    init(pollingInterval: TimeInterval = 10.0) {
        self.pollingInterval = pollingInterval
    }
    
    func startPolling() {
        guard timer == nil else { return }
        print("Polling started with an interval of \(pollingInterval) seconds")
        
        timer = Timer.scheduledTimer(withTimeInterval: pollingInterval, repeats: true) { [weak self] _ in
            self?.fetchPosts()
        }
    }
    
    func stopPolling() {
        timer?.invalidate()
        timer = nil
        print("Polling stopped.")
    }
    
    private func fetchPosts() {
        guard !isPollingPaused else {
            print("Polling is paused, skipping fetch")
            return
        }
        
        onFetchPosts?()
    }
    
    func handlePollingFailure() {
        failureCount += 1
        print("Polling failure count: \(failureCount)")
        
        if pauseCount < maxPauses {
            print("Pausing for 5 minutes. Attempt \(pauseCount + 1) of \(maxPauses)")
            pausePolling(for: pauseDuration)
            pauseCount += 1
        } else {
            print("Max pause attempts reached.")
            if failureCount >= maxFailures {
                stopPolling()
                print("Polling stopped after \(maxFailures) failures.")
            }
        }
    }
    
    func pausePolling(for seconds: TimeInterval) {
        print("Pausing polling for \(seconds) seconds")
        isPollingPaused = true
        stopPolling()
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) { [weak self] in
            guard let self = self else { return }
            self.isPollingPaused = false
            print("Resuming polling after pause")
            self.startPolling()
        }
    }
    
    func resetFailureCount() {
        failureCount = 0
        pauseCount = 0
    }
}



//WORKS
/*
class PollingManager {
    private var timer: Timer?
    private var failureCount = 0
    private var isPollingPaused = false
    private let pollingInterval: TimeInterval
    private let maxFailures = 4
    private let pauseDuration: TimeInterval = 300 // 5 minutes
    
    var onFetchPosts: (() -> Void)?
    
    init(pollingInterval: TimeInterval = 10.0) {
        self.pollingInterval = pollingInterval
    }
    
    func startPolling() {
        guard timer == nil else { return }
        print("Polling started with an interval of \(pollingInterval) seconds")
        
        timer = Timer.scheduledTimer(withTimeInterval: pollingInterval, repeats: true) { [weak self] _ in
            self?.fetchPosts()
        }
    }
    
    func stopPolling() {
        timer?.invalidate()
        timer = nil
        print("Polling stopped.")
    }
    
    private func fetchPosts() {
        guard !isPollingPaused else {
            print("Polling is paused, skipping fetch")
            return
        }
        
        onFetchPosts?()
    }
    
    func handlePollingFailure() {
        failureCount += 1
        print("Polling failure count: \(failureCount)")
        
        if failureCount >= 3 {
            pausePolling(for: pauseDuration)
        }

        if failureCount >= maxFailures {
            stopPolling()
            print("Polling stopped after multiple failures.")
        }
    }
    
    func pausePolling(for seconds: TimeInterval) {
        print("Pausing polling for \(seconds) seconds")
        isPollingPaused = true
        stopPolling()
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) { [weak self] in
            guard let self = self else { return }
            self.isPollingPaused = false
            print("Resuming polling after pause")
            self.startPolling()
        }
    }
    
    func resetFailureCount() {
        failureCount = 0
    }
}
*/
 
 
 
