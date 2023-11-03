//
//  Food.swift
//  Rangoo
//
//  Created by coltec on 29/06/23.
//

import Foundation

class Food: Equatable {
    
    static func == (lhs: Food, rhs: Food) -> Bool {
        return lhs.name == rhs.name && lhs.resume == rhs.resume && lhs.details == rhs.details
    }
    
    
    private var id: String
    private var imageURL: String
    private var name: String
    private var resume: String
    private var details: String
    
    init(){
        self.id = ""
        self.imageURL = ""
        self.name = ""
        self.resume = ""
        self.details = ""
    }
    
    init (id:String, image: String, name: String, resume: String, details: String){
        self.id = id
        self.imageURL = image
        self.name = name
        self.resume = resume
        self.details = details
    }
    
    public func getId() -> String {return self.id }
    
    public func getImage() -> String { return self.imageURL }
    
    public func getName() -> String { return self.name }
    
    public func getResume() -> String { return self.resume }
    
    public func getDetails() -> String { return self.details }
    
}
