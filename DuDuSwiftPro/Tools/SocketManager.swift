//
//  SocketManager.swift
//  DuDuSwiftPro
//
//  Created by 夕阳西下 on 2021/11/20.
//

import Foundation

import UIKit

class SocketManager: NSObject, GCDAsyncSocketDelegate {
    let serverIP:String = "localhost"
//    let serverIP:String = "127.0.0.1"
    let serverPort: UInt16 = UInt16(6666)
    static let shared = SocketManager.init()
    private override init() {
        
    }
    
    lazy var SocketTCP : GCDAsyncSocket = {
        let socket = GCDAsyncSocket.init()
        socket.delegate = self
        socket.delegateQueue = DispatchQueue.global()
        do {
            try socket.connect(toHost: serverIP, onPort: serverPort)
        } catch {
            print("try connect error: \(error)")
        }
        return socket
    }()
    
    
    func conentToSocket() -> Bool {
        if SocketTCP.isConnected {
            return true
        }
        do {
            try SocketTCP .connect(toHost: serverIP, onPort: serverPort, withTimeout: 15)
            return true
        } catch {
            print(error)
            return false
        }
    }
    
    func discontentSocket() -> Bool {
        if SocketTCP.isDisconnected {
            return true
        }
        SocketTCP.disconnect()
        return true
    }
    
    //Mark sockdelegate
    func socket(_ sock: GCDAsyncSocket, didConnectToHost host: String, port: UInt16) {
        print("socket---链接成功")
    }
}
