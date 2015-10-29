//
//  ViewController.swift
//  serverDemo
//
//  Created by 栾有数 on 15/10/29.
//  Copyright © 2015年 栾有数. All rights reserved.
//

import Cocoa
extension ViewController: TCPServerDelegate {//tcpserver协议
    
    func server(server: TCPServer, serverIsWorking isWorking: Bool) {
        print(isWorking)
        
//        alert("Alert", msg: "server is work: \(isWorking)")
    }
    
    func server(server: TCPServer, connectedClient client: TCPClient) {
        print(client.addr)
        
        dispatch_async(dispatch_get_main_queue()) { [weak self] in
//            self?.alert("Alert", msg: "connected client addr: \(client.addr)")
        }
    }
    
    func server(server: TCPServer, client: TCPClient, receivedData data: NSData) {
        
        if let msg = NSString(data: data, encoding: NSUTF8StringEncoding) {
            dispatch_async(dispatch_get_main_queue()) { [weak self] in
//                self?.receivedMsg.text = "\(client.addr):\(msg)"
                print(msg);
            }
        }
    }
}

class ViewController: NSViewController {
    
    var server: TCPServer!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let ipUtil = IPAddress()
        
        let localIP = ipUtil.getIPAddress(true)//获取本地的ipv4的地址
        
        if self.server != nil {
            self.server.close()
        }
        
        self.server = TCPServer(addr: localIP, port: 9999)//tcpserver即成socket初始化参数 本地地址＋端口号9999
        self.server.delegate = self
        
        self.server.start()//这里面会根据情况执行不同的代理

    }

    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

