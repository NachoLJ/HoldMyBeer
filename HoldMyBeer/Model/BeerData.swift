//
//  BeerData.swift
//  HoldMyBeer
//
//  Created by Ignacio Lopez Jimenez on 17/6/21.
//

import Foundation

struct BeerData: Codable {
    let name: String
    let tagline: String
    let abv: Float
    let image_url: String?
    let description: String
    let brewers_tips: String
    let food_pairing: [String]
}
