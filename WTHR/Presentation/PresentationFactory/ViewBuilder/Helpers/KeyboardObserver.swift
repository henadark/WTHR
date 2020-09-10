//
//  KeyboardObserver.swift
//  WTHR
//
//  Created by Гена Книжник on 18.08.2020.
//  Copyright © 2020 Hena. All rights reserved.
//

import UIKit

final class KeyboardObserver : ObservableObject {
    
    // MARK: - Stored Properties
    
    private let center: NotificationCenter
    private var rect = CGRect.zero
    @Published var isVisible = false
    
    // MARK: - Computed properties
    
    var height: CGFloat { rect.height }
    
    // MARK: - Init
    
    init(notificationCenter: NotificationCenter = .default) {
        center = notificationCenter
        center.addObserver(self, selector: #selector(keyboardVisibilityChanged), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    deinit {
        center.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    // MARK: - Observing
    
    @objc private func keyboardVisibilityChanged(_ notification: Notification) {
        guard let userInfo = notification.userInfo else { return }
        guard let keyboardEndFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
        isVisible = keyboardEndFrame.minY < .screenHeight
        rect = isVisible ? keyboardEndFrame : .zero
    }
    
}
