//
//  ContactModel.swift
//  VisualFit
//
//  Created by iOS on 01/05/24.
//

import Foundation

struct ContactModel {
    var peerName : String
    var peerImage : String
    var peerContact : String
}
// creating a singleton instance
class ContactData {
    var contacts : [ContactModel] = []
    
    private static let instance : ContactData = ContactData()
    
    static func getInstance() ->ContactData {
        return instance
    }
    
    func getContactData() -> [ContactModel]{
        return contacts
    }
    
    private init() {
        let data: [ContactModel] = [
            ContactModel(peerName: "Ansh", peerImage: "mimoji1", peerContact: "9898989776"),
            ContactModel(peerName: "Harashish", peerImage: "mimoji2", peerContact: "9898989776"),
            ContactModel(peerName: "Tanishk", peerImage: "mimoji3", peerContact: "1234567890"),
            ContactModel(peerName: "Udhav", peerImage: "mimoji4", peerContact: "9876543210"),
            ContactModel(peerName: "Jatin", peerImage: "mimoji5", peerContact: "1112223334"),
            ContactModel(peerName:"Jipnesh", peerImage: "mimoji6", peerContact: "5556667778"),
            ContactModel(peerName: "Ishita", peerImage: "mimoji7", peerContact: "9998887776"),
            ContactModel(peerName: "Drishti", peerImage: "mimoji8", peerContact: "3334445556"),
            ContactModel(peerName: "Hiti", peerImage: "mimoji7", peerContact: "7778889990"),
            ContactModel(peerName: "Kamal", peerImage: "mimoji4", peerContact: "4445556667")
        ]
        
        
        contacts = data
    }
}
