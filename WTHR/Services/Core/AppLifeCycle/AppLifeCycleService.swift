//
//  AppLifeCycleService.swift
//  WTHR
//
//  Created by Гена Книжник on 26.08.2020.
//  Copyright © 2020 Hena. All rights reserved.
//

import UIKit
import Combine

final class AppLifeCycleService {
    
    // MARK: Stored Properties
    
    private let center: NotificationCenter
    private var foregroundPublisher: AnyCancellable?
    private var backgroundPublisher: AnyCancellable?
    private (set) var appInBackgroundSubject = PassthroughSubject<Bool, Never>()
    
    // MARK: Init
    
    init(notificationCenter: NotificationCenter = .default) {
        center = notificationCenter
        subscribeOnAppEvent()
    }
    
    deinit {
        foregroundPublisher?.cancel()
        backgroundPublisher?.cancel()
    }
    
}

// MARK: - Setup

private extension AppLifeCycleService {
    
    func subscribeOnAppEvent() {
        foregroundPublisher = center.publisher(for: UIApplication.willEnterForegroundNotification).sink { [unowned self] _ in
            self.appInBackgroundSubject.send(false)
        }
        backgroundPublisher = center.publisher(for: UIApplication.didEnterBackgroundNotification).sink { [unowned self] _ in
            self.appInBackgroundSubject.send(true)
        }
    }
    
}

// MARK: - AppLifeCycleServiceProtocol

extension AppLifeCycleService: AppLifeCycleServiceProtocol { }
