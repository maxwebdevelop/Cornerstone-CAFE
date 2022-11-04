//
//  NetworkConnection.swift
//  Cornerstone CAFE
//
//  Created by Maxim Fedorets on 8/12/22.
//

import Foundation
import Network

final class NetworkConnection: ObservableObject{
    let monitor = NWPathMonitor()
    let queue = DispatchQueue(label: "Monitor")
    
    @Published var isConnected = true
    
    init(){
        monitor.pathUpdateHandler = { [weak self] path in
            DispatchQueue.main.async {
                self?.isConnected = path.status == .satisfied ? true : false
            }
        }
        monitor.start(queue: queue)
    }
}
