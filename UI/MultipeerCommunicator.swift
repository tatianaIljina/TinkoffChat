//
//  MultipeerCommunicator.swift
//  UI
//
//  Created by Татьяна Ильина on 27.10.2018.
//  Copyright © 2018 Татьяна Ильина. All rights reserved.
//

import UIKit
import MultipeerConnectivity

class MultipeerCommunicator: NSObject, Communicator {

    var delegate: CommunicatorDelegate?
    var online: Bool
    var session: [String : MCSession] = [:]
    //var session = MCSession(peer: myPeer)
    var advertiser: MCNearbyServiceAdvertiser //видимость
    var browser: MCNearbyServiceBrowser //поиск

    let myPeer: MCPeerID

    func sendMessage(string: String, to UserId: String, completionHandler: ((Bool, Error?) -> ())?) {
        if let session = session[UserId] {
            var message = [
                "eventType": "TextMessage",
                "messageId": string,
                "text": string]
            message["messageId"] = generateMessageID()
            do {
                let data = try JSONSerialization.data(withJSONObject: message, options: [])
                try session .send(data, toPeers: session.connectedPeers, with: .reliable)
                completionHandler?(true, nil)
            }
            catch {
                completionHandler?(false, error)
            }
        }
    }
    func generateMessageID() -> String {
        let string = "\(arc4random_uniform(UINT32_MAX))+\(Date.timeIntervalSinceReferenceDate)+\(arc4random_uniform(UINT32_MAX))".data(using: .utf8)?.base64EncodedString()
        return string!
    }

    

    override init() {
        myPeer = MCPeerID(displayName: "TI")
        online = true
        advertiser = MCNearbyServiceAdvertiser(peer: myPeer, discoveryInfo: ["userName" : "TI"], serviceType: "tinkoff-chat")
        browser = MCNearbyServiceBrowser(peer: myPeer, serviceType: "tinkoff-chat")
        super.init()
        advertiser.delegate = self
        browser.delegate = self

        advertiser.startAdvertisingPeer() //включение видимости
        browser.startBrowsingForPeers() //начало поиска
    }
    
    func session(displayName: String) -> MCSession? {
        var session = self.session[displayName]
        
        if let session = session {
            return session
        } else {
            session = MCSession(peer: self.myPeer, securityIdentity: nil, encryptionPreference: .none)
            session?.delegate = self
            self.session[displayName] = session
            return session
        }
    }
}

extension MultipeerCommunicator: MCNearbyServiceAdvertiserDelegate, MCSessionDelegate, MCNearbyServiceBrowserDelegate {
    func browser(_ browser: MCNearbyServiceBrowser, foundPeer peerID: MCPeerID, withDiscoveryInfo info: [String : String]?) {
        if let session = session(displayName: peerID.displayName) {
            if session.connectedPeers.contains(peerID){
                browser.invitePeer(peerID, to: session, withContext: nil, timeout: 10)
                delegate?.didLostUser(userId: peerID.displayName)
            }
        }
    }

    func browser(_ browser: MCNearbyServiceBrowser, lostPeer peerID: MCPeerID) {
        session.removeValue(forKey: peerID.displayName)
        delegate?.didLostUser(userId: peerID.displayName)
    }
    
    func browser(_ browser: MCNearbyServiceBrowser, didNotStartBrowsingForPeers error: Error) {
        self.delegate?.failedToStartBrowsingForUsers(error: error)
        self.online = false
    }

    func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
        switch state {
        case .connected:
            print ("\(peerID) connected" )
        case .notConnected:
            print ("\(peerID) notConnected" )
        case .connecting:
            print ("\(peerID) Connecting" )
        }
    }

    func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
        do {
        let message = try JSONSerialization.jsonObject(with: data) as! [String : String]
//        delegate?.didReceiveMessage(text: message, fromUser: peerID.displayName, toUser: myPeer.displayName)
        } catch {
            print(error)
        }
    }

    func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String, fromPeer peerID: MCPeerID) {
    }

    func session(_ session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, with progress: Progress) {
    }

    func session(_ session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, at localURL: URL?, withError error: Error?) {
    }


    //проверка видимости
    func advertiser(_ advertiser: MCNearbyServiceAdvertiser, didNotStartAdvertisingPeer error: Error) {
        print ("Видимость не включена")
        online = false
        delegate?.failedToStartAdvertising(error: error)
    }

    //получили приглашение
    func advertiser(_ advertiser: MCNearbyServiceAdvertiser, didReceiveInvitationFromPeer peerID: MCPeerID, withContext context: Data?, invitationHandler: @escaping (Bool, MCSession?) -> Void) {
        if let session = session(displayName: peerID.displayName) {
            if session.connectedPeers.contains(peerID){
                invitationHandler(false,nil)
            } else {
                invitationHandler(true, session)
            }
            
        }

    }


}



