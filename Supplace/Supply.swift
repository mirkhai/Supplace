//
//  Supply.swift
//  Supplace
//
//  Created by Mirta Khairunnisa on 27/04/22.
//

import UIKit

struct Supply {
    let name: String
    let image: UIImage
}

let suppliesname: [Supply] = [
    Supply(name: "Pencil", image:  #imageLiteral(resourceName: "sup-1")),
    Supply(name: "Marker", image:  #imageLiteral(resourceName: "sup-2")),
    Supply(name: "Paint", image:  #imageLiteral(resourceName: "sup-3")),
    Supply(name: "Clay", image:  #imageLiteral(resourceName: "sup-4")),
    Supply(name: "Cutlery", image:  #imageLiteral(resourceName: "sup-5")),
    Supply(name: "Pen", image:  #imageLiteral(resourceName: "sup-6"))
]
struct Storage {
    let nameSt: String
    let imageSt: UIImage
}

let storagesname: [Storage] = [
    Storage(nameSt: "Ace 30x30 Container", imageSt:  #imageLiteral(resourceName: "stor-1")),
    Storage(nameSt: "Used Bottle Jars", imageSt:  #imageLiteral(resourceName: "stor-2")),
    Storage(nameSt: "Desk Pencil Case", imageSt:  #imageLiteral(resourceName: "stor-3")),
    Storage(nameSt: "Ace Stora 25x20", imageSt:  #imageLiteral(resourceName: "stor-4")),
    Storage(nameSt: "30x10 Tool Box", imageSt:  #imageLiteral(resourceName: "stor-5")),
]
