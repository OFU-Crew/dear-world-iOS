//
//  WorldMap.Model.Country.swift
//  Dear-World
//
//  Created by dongyoung.lee on 2021/01/03.
//

import UIKit

extension WorldMap.Model {
  struct Country: Equatable, Hashable {
    let code: String
    let name: String
    let locations: [Location]
  }
}
extension WorldMap.Model {
  struct Location: Equatable, Hashable {
    let x: Int
    let y: Int
  }
}
extension WorldMap.Model {
  static let US: Country = Country(
    code: "US",
    name: "United States",
    locations: [
      Location(x: 1, y: 16),
      Location(x: 1, y: 18),
      Location(x: 1, y: 20),
      Location(x: 2, y: 15),
      Location(x: 2, y: 16),
      Location(x: 2, y: 17),
      Location(x: 2, y: 18),
      Location(x: 2, y: 19),
      Location(x: 2, y: 20),
      Location(x: 3, y: 15),
      Location(x: 3, y: 16),
      Location(x: 3, y: 17),
      Location(x: 3, y: 18),
      Location(x: 3, y: 19),
      Location(x: 3, y: 20),
      Location(x: 3, y: 21),
      Location(x: 4, y: 15),
      Location(x: 4, y: 16),
      Location(x: 4, y: 17),
      Location(x: 4, y: 18),
      Location(x: 4, y: 19),
      Location(x: 4, y: 20),
      Location(x: 5, y: 16),
      Location(x: 5, y: 17),
      Location(x: 5, y: 18),
      Location(x: 5, y: 19),
      Location(x: 5, y: 20),
      Location(x: 6, y: 16),
      Location(x: 6, y: 17),
      Location(x: 6, y: 18),
      Location(x: 6, y: 19),
      Location(x: 10, y: 25),
      Location(x: 10, y: 26),
      Location(x: 10, y: 27),
      Location(x: 11, y: 25),
      Location(x: 11, y: 26),
      Location(x: 11, y: 27),
      Location(x: 11, y: 28),
      Location(x: 12, y: 25),
      Location(x: 12, y: 26),
      Location(x: 12, y: 27),
      Location(x: 12, y: 28),
      Location(x: 12, y: 29),
      Location(x: 13, y: 25),
      Location(x: 13, y: 26),
      Location(x: 13, y: 27),
      Location(x: 13, y: 28),
      Location(x: 13, y: 29),
      Location(x: 14, y: 25),
      Location(x: 14, y: 26),
      Location(x: 14, y: 27),
      Location(x: 14, y: 28),
      Location(x: 14, y: 29),
      Location(x: 15, y: 25),
      Location(x: 15, y: 26),
      Location(x: 15, y: 27),
      Location(x: 15, y: 28),
      Location(x: 15, y: 29),
      Location(x: 15, y: 30),
      Location(x: 16, y: 25),
      Location(x: 16, y: 26),
      Location(x: 16, y: 27),
      Location(x: 16, y: 28),
      Location(x: 16, y: 29),
      Location(x: 17, y: 25),
      Location(x: 17, y: 26),
      Location(x: 17, y: 27),
      Location(x: 17, y: 28),
      Location(x: 17, y: 29),
      Location(x: 18, y: 26),
      Location(x: 18, y: 27),
      Location(x: 18, y: 28),
      Location(x: 18, y: 29),
      Location(x: 19, y: 27),
      Location(x: 19, y: 28),
      Location(x: 19, y: 29),
      Location(x: 19, y: 30),
      Location(x: 20, y: 26),
      Location(x: 20, y: 27),
      Location(x: 20, y: 28),
      Location(x: 21, y: 26),
    ]
  )
  static let CA: Country = Country(
    code: "CA",
    name: "Canada",
    locations: [
      Location(x: 7, y: 16),
      Location(x: 7, y: 17),
      Location(x: 7, y: 18),
      Location(x: 7, y: 19),
      Location(x: 7, y: 20),
      Location(x: 8, y: 16),
      Location(x: 8, y: 17),
      Location(x: 8, y: 18),
      Location(x: 8, y: 19),
      Location(x: 8, y: 20),
      Location(x: 8, y: 21),
      Location(x: 9, y: 16),
      Location(x: 9, y: 17),
      Location(x: 9, y: 18),
      Location(x: 9, y: 19),
      Location(x: 9, y: 20),
      Location(x: 9, y: 21),
      Location(x: 9, y: 22),
      Location(x: 9, y: 23),
      Location(x: 10, y: 12),
      Location(x: 10, y: 13),
      Location(x: 10, y: 14),
      Location(x: 10, y: 16),
      Location(x: 10, y: 17),
      Location(x: 10, y: 18),
      Location(x: 10, y: 19),
      Location(x: 10, y: 20),
      Location(x: 10, y: 21),
      Location(x: 10, y: 22),
      Location(x: 10, y: 23),
      Location(x: 10, y: 24),
      Location(x: 11, y: 10),
      Location(x: 11, y: 12),
      Location(x: 11, y: 13),
      Location(x: 11, y: 16),
      Location(x: 11, y: 17),
      Location(x: 11, y: 18),
      Location(x: 11, y: 19),
      Location(x: 11, y: 20),
      Location(x: 11, y: 21),
      Location(x: 11, y: 22),
      Location(x: 11, y: 23),
      Location(x: 11, y: 24),
      Location(x: 12, y: 9),
      Location(x: 12, y: 11),
      Location(x: 12, y: 13),
      Location(x: 12, y: 14),
      Location(x: 12, y: 15),
      Location(x: 12, y: 17),
      Location(x: 12, y: 18),
      Location(x: 12, y: 19),
      Location(x: 12, y: 20),
      Location(x: 12, y: 21),
      Location(x: 12, y: 22),
      Location(x: 12, y: 23),
      Location(x: 12, y: 24),
      Location(x: 13, y: 11),
      Location(x: 13, y: 14),
      Location(x: 13, y: 15),
      Location(x: 13, y: 17),
      Location(x: 13, y: 18),
      Location(x: 13, y: 19),
      Location(x: 13, y: 20),
      Location(x: 13, y: 21),
      Location(x: 13, y: 22),
      Location(x: 13, y: 23),
      Location(x: 13, y: 24),
      Location(x: 14, y: 8),
      Location(x: 14, y: 13),
      Location(x: 14, y: 14),
      Location(x: 14, y: 15),
      Location(x: 14, y: 17),
      Location(x: 14, y: 18),
      Location(x: 14, y: 19),
      Location(x: 14, y: 20),
      Location(x: 14, y: 21),
      Location(x: 14, y: 22),
      Location(x: 14, y: 23),
      Location(x: 14, y: 24),
      Location(x: 15, y: 8),
      Location(x: 15, y: 11),
      Location(x: 15, y: 13),
      Location(x: 15, y: 14),
      Location(x: 15, y: 17),
      Location(x: 15, y: 18),
      Location(x: 15, y: 19),
      Location(x: 15, y: 20),
      Location(x: 15, y: 21),
      Location(x: 15, y: 22),
      Location(x: 15, y: 23),
      Location(x: 15, y: 24),
      Location(x: 16, y: 5),
      Location(x: 16, y: 6),
      Location(x: 16, y: 7),
      Location(x: 16, y: 8),
      Location(x: 16, y: 10),
      Location(x: 16, y: 13),
      Location(x: 16, y: 14),
      Location(x: 16, y: 15),
      Location(x: 16, y: 17),
      Location(x: 16, y: 18),
      Location(x: 16, y: 19),
      Location(x: 16, y: 20),
      Location(x: 16, y: 21),
      Location(x: 16, y: 22),
      Location(x: 16, y: 23),
      Location(x: 16, y: 24),
      Location(x: 17, y: 4),
      Location(x: 17, y: 6),
      Location(x: 17, y: 7),
      Location(x: 17, y: 8),
      Location(x: 17, y: 11),
      Location(x: 17, y: 16),
      Location(x: 17, y: 17),
      Location(x: 17, y: 18),
      Location(x: 17, y: 22),
      Location(x: 17, y: 23),
      Location(x: 17, y: 24),
      Location(x: 18, y: 4),
      Location(x: 18, y: 5),
      Location(x: 18, y: 6),
      Location(x: 18, y: 8),
      Location(x: 18, y: 9),
      Location(x: 18, y: 10),
      Location(x: 18, y: 11),
      Location(x: 18, y: 13),
      Location(x: 18, y: 14),
      Location(x: 18, y: 15),
      Location(x: 18, y: 16),
      Location(x: 18, y: 17),
      Location(x: 18, y: 18),
      Location(x: 18, y: 22),
      Location(x: 18, y: 23),
      Location(x: 18, y: 24),
      Location(x: 19, y: 3),
      Location(x: 19, y: 4),
      Location(x: 19, y: 5),
      Location(x: 19, y: 6),
      Location(x: 19, y: 7),
      Location(x: 19, y: 8),
      Location(x: 19, y: 9),
      Location(x: 19, y: 10),
      Location(x: 19, y: 11),
      Location(x: 19, y: 13),
      Location(x: 19, y: 14),
      Location(x: 19, y: 15),
      Location(x: 19, y: 23),
      Location(x: 19, y: 24),
      Location(x: 19, y: 25),
      Location(x: 19, y: 26),
      Location(x: 20, y: 2),
      Location(x: 20, y: 3),
      Location(x: 20, y: 4),
      Location(x: 20, y: 5),
      Location(x: 20, y: 6),
      Location(x: 20, y: 7),
      Location(x: 20, y: 8),
      Location(x: 20, y: 13),
      Location(x: 20, y: 14),
      Location(x: 20, y: 15),
      Location(x: 20, y: 16),
      Location(x: 20, y: 18),
      Location(x: 20, y: 20),
      Location(x: 20, y: 21),
      Location(x: 20, y: 22),
      Location(x: 20, y: 23),
      Location(x: 20, y: 24),
      Location(x: 20, y: 25),
      Location(x: 21, y: 2),
      Location(x: 21, y: 3),
      Location(x: 21, y: 4),
      Location(x: 21, y: 5),
      Location(x: 21, y: 6),
      Location(x: 21, y: 14),
      Location(x: 21, y: 15),
      Location(x: 21, y: 16),
      Location(x: 21, y: 17),
      Location(x: 21, y: 18),
      Location(x: 21, y: 20),
      Location(x: 21, y: 21),
      Location(x: 21, y: 22),
      Location(x: 21, y: 23),
      Location(x: 21, y: 24),
      Location(x: 21, y: 25),
      Location(x: 22, y: 2),
      Location(x: 22, y: 3),
      Location(x: 22, y: 4),
      Location(x: 22, y: 5),
      Location(x: 22, y: 15),
      Location(x: 22, y: 16),
      Location(x: 22, y: 17),
      Location(x: 22, y: 18),
      Location(x: 22, y: 19),
      Location(x: 22, y: 21),
      Location(x: 22, y: 22),
      Location(x: 22, y: 23),
      Location(x: 22, y: 24),
      Location(x: 22, y: 25),
      Location(x: 23, y: 3),
      Location(x: 23, y: 17),
      Location(x: 23, y: 21),
      Location(x: 23, y: 22),
      Location(x: 23, y: 23),
      Location(x: 23, y: 24),
      Location(x: 24, y: 23),
      Location(x: 24, y: 24),
      Location(x: 24, y: 25)
    ]
  )
  static let MX: Country = Country(
    code: "MX",
    name: "Mexico",
    locations: [
      Location(x: 12, y: 30),
      Location(x: 12, y: 31),
      Location(x: 13, y: 30),
      Location(x: 14, y: 30),
      Location(x: 14, y: 31),
      Location(x: 14, y: 32),
      Location(x: 15, y: 31),
      Location(x: 15, y: 32),
      Location(x: 15, y: 33),
      Location(x: 16, y: 33),
      Location(x: 17, y: 32)
    ]
  )
  static let GT: Country = Country(
    code: "GT",
    name: "Guatemala",
    locations: [
      Location(x: 17, y: 33)
    ]
  )
  static let SV: Country = Country(
    code: "SV",
    name: "El Salvador",
    locations: [
      Location(x: 17, y: 34)
    ]
  )
  static let BZ: Country = Country(
    code: "BZ",
    name: "Belize",
    locations: [
      Location(x: 18, y: 32)
    ]
  )
  static let HN: Country = Country(
    code: "HN",
    name: "Honduras",
    locations: [
      Location(x: 18, y: 33)
    ]
  )
  static let NI: Country = Country(
    code: "NI",
    name: "Nicaragua",
    locations: [
      Location(x: 18, y: 34)
    ]
  )
  static let CR: Country = Country(
    code: "CR",
    name: "Costa Rico",
    locations: [
      Location(x: 18, y: 35)
    ]
  )
  static let PA: Country = Country(
    code: "PA",
    name: "Panama",
    locations: [
      Location(x: 19, y: 35)
    ]
  )
  static let CO: Country = Country(
    code: "CO",
    name: "Colombia",
    locations: [
      Location(x: 20, y: 35),
      Location(x: 20, y: 36),
      Location(x: 21, y: 36)
    ]
  )
  static let BS: Country = Country(
    code: "BS",
    name: "Bahamas",
    locations: [
      Location(x: 20, y: 31)
    ]
  )
  static let CU: Country = Country(
    code: "CU",
    name: "Cuba",
    locations: [
      Location(x: 20, y: 32)
    ]
  )
  static let JM: Country = Country(
    code: "JM",
    name: "Jamaica",
    locations: [
      Location(x: 20, y: 33)
    ]
  )
  static let HT: Country = Country(
    code: "HT",
    name: "Bahamas",
    locations: [
      Location(x: 21, y: 32)
    ]
  )
  static let DO: Country = Country(
    code: "DO",
    name: "Dominican Republic",
    locations: [
      Location(x: 22, y: 32)
    ]
  )
  static let PR: Country = Country(
    code: "PR",
    name: "Puerto Rico",
    locations: [
      Location(x: 22, y: 33)
    ]
  )
  static let DM: Country = Country(
    code: "DM",
    name: "Dominica",
    locations: [
      Location(x: 23, y: 32)
    ]
  )
  static let GD: Country = Country(
    code: "GD",
    name: "Grenada",
    locations: [
      Location(x: 23, y: 33)
    ]
  )
  static let TT: Country = Country(
    code: "TT",
    name: "Trinidad and Tobago",
    locations: [
      Location(x: 23, y: 34)
    ]
  )
  static let AG: Country = Country(
    code: "AG",
    name: "Antigua and Barbuda",
    locations: [
      Location(x: 24, y: 32)
    ]
  )
  static let LC: Country = Country(
    code: "LC",
    name: "Saint Lucia",
    locations: [
      Location(x: 24, y: 33)
    ]
  )
  static let BB: Country = Country(
    code: "BB",
    name: "Barbados",
    locations: [
      Location(x: 24, y: 34)
    ]
  )
  static let VE: Country = Country(
    code: "VE",
    name: "Venezuela",
    locations: [
      Location(x: 21, y: 35),
      Location(x: 22, y: 35),
      Location(x: 22, y: 36),
      Location(x: 23, y: 35)
    ]
  )
  static let EC: Country = Country(
    code: "EC",
    name: "Ecuador",
    locations: [
      Location(x: 20, y: 37)
    ]
  )
  static let PE: Country = Country(
    code: "PE",
    name: "Peru",
    locations: [
      Location(x: 21, y: 37),
      Location(x: 20, y: 38),
      Location(x: 20, y: 39),
      Location(x: 21, y: 39),
      Location(x: 21, y: 40)
    ]
  )
  static let BR: Country = Country(
    code: "BR",
    name: "Brazil",
    locations: [
      Location(x: 21, y: 38),
      Location(x: 22, y: 37),
      Location(x: 22, y: 38),
      Location(x: 23, y: 36),
      Location(x: 23, y: 37),
      Location(x: 23, y: 38),
      Location(x: 23, y: 39),
      Location(x: 24, y: 37),
      Location(x: 24, y: 38),
      Location(x: 24, y: 39),
      Location(x: 24, y: 40),
      Location(x: 25, y: 37),
      Location(x: 25, y: 38),
      Location(x: 25, y: 39),
      Location(x: 25, y: 40),
      Location(x: 25, y: 41),
      Location(x: 25, y: 42),
      Location(x: 25, y: 43),
      Location(x: 26, y: 37),
      Location(x: 26, y: 38),
      Location(x: 26, y: 39),
      Location(x: 26, y: 40),
      Location(x: 26, y: 41),
      Location(x: 26, y: 42),
      Location(x: 27, y: 37),
      Location(x: 27, y: 38),
      Location(x: 27, y: 39),
      Location(x: 27, y: 40),
      Location(x: 27, y: 41),
      Location(x: 28, y: 38),
      Location(x: 28, y: 39),
      Location(x: 28, y: 40)
    ]
  )
  static let GY: Country = Country(
    code: "GY",
    name: "Guyana",
    locations: [
      Location(x: 24, y: 35)
    ]
  )
  static let SR: Country = Country(
    code: "SR",
    name: "Suriname",
    locations: [
      Location(x: 24, y: 36)
    ]
  )
  static let GF: Country = Country(
    code: "GF",
    name: "French Guiana",
    locations: [
      Location(x: 25, y: 36)
    ]
  )
  static let BO: Country = Country(
    code: "Bolivia",
    name: "BO",
    locations: [
      Location(x: 22, y: 39),
      Location(x: 22, y: 40),
      Location(x: 22, y: 41),
      Location(x: 23, y: 40),
      Location(x: 23, y: 41)
    ]
  )
  static let CL: Country = Country(
    code: "Chile",
    name: "CL",
    locations: [
      Location(x: 21, y: 41),
      Location(x: 21, y: 42),
      Location(x: 21, y: 43),
      Location(x: 21, y: 44),
      Location(x: 21, y: 45),
      Location(x: 21, y: 46)
    ]
  )
  static let AR: Country = Country(
    code: "AR",
    name: "Argentina",
    locations: [
      Location(x: 21, y: 47),
      Location(x: 21, y: 48),
      Location(x: 21, y: 49),
      Location(x: 21, y: 50),
      Location(x: 22, y: 42),
      Location(x: 22, y: 43),
      Location(x: 22, y: 44),
      Location(x: 22, y: 45),
      Location(x: 22, y: 46),
      Location(x: 22, y: 47),
      Location(x: 22, y: 48),
      Location(x: 22, y: 51),
      Location(x: 23, y: 42),
      Location(x: 23, y: 43),
      Location(x: 23, y: 44),
      Location(x: 23, y: 45),
      Location(x: 23, y: 46),
      Location(x: 24, y: 43),
      Location(x: 24, y: 45)
    ]
  )
  static let PY: Country = Country(
    code: "PY",
    name: "Paraguay",
    locations: [
      Location(x: 24, y: 41),
      Location(x: 24, y: 42)
    ]
  )
  static let UY: Country = Country(
    code: "UY",
    name: "Uruguay",
    locations: [
      Location(x: 24, y: 44)
    ]
  )
  static let GL: Country = Country(
    code: "GL",
    name: "Greenland",
    locations: [
      Location(x: 21, y: 8),
      Location(x: 22, y: 8),
      Location(x: 22, y: 9),
      Location(x: 22, y: 10),
      Location(x: 23, y: 5),
      Location(x: 23, y: 6),
      Location(x: 23, y: 7),
      Location(x: 23, y: 8),
      Location(x: 23, y: 9),
      Location(x: 23, y: 10),
      Location(x: 24, y: 4),
      Location(x: 24, y: 5),
      Location(x: 24, y: 6),
      Location(x: 24, y: 7),
      Location(x: 24, y: 8),
      Location(x: 24, y: 9),
      Location(x: 24, y: 10),
      Location(x: 24, y: 11),
      Location(x: 25, y: 4),
      Location(x: 25, y: 5),
      Location(x: 25, y: 6),
      Location(x: 25, y: 7),
      Location(x: 25, y: 8),
      Location(x: 25, y: 9),
      Location(x: 25, y: 10),
      Location(x: 25, y: 11),
      Location(x: 25, y: 12),
      Location(x: 25, y: 13),
      Location(x: 25, y: 14),
      Location(x: 25, y: 17),
      Location(x: 26, y: 3),
      Location(x: 26, y: 4),
      Location(x: 26, y: 5),
      Location(x: 26, y: 6),
      Location(x: 26, y: 7),
      Location(x: 26, y: 8),
      Location(x: 26, y: 9),
      Location(x: 26, y: 10),
      Location(x: 26, y: 11),
      Location(x: 26, y: 12),
      Location(x: 26, y: 13),
      Location(x: 26, y: 14),
      Location(x: 26, y: 15),
      Location(x: 26, y: 16),
      Location(x: 26, y: 17),
      Location(x: 26, y: 18),
      Location(x: 26, y: 19),
      Location(x: 27, y: 2),
      Location(x: 27, y: 3),
      Location(x: 27, y: 4),
      Location(x: 27, y: 5),
      Location(x: 27, y: 6),
      Location(x: 27, y: 7),
      Location(x: 27, y: 8),
      Location(x: 27, y: 9),
      Location(x: 27, y: 10),
      Location(x: 27, y: 11),
      Location(x: 27, y: 12),
      Location(x: 27, y: 13),
      Location(x: 27, y: 14),
      Location(x: 27, y: 15),
      Location(x: 27, y: 16),
      Location(x: 27, y: 17),
      Location(x: 27, y: 18),
      Location(x: 27, y: 19),
      Location(x: 27, y: 20),
      Location(x: 28, y: 2),
      Location(x: 28, y: 3),
      Location(x: 28, y: 4),
      Location(x: 28, y: 5),
      Location(x: 28, y: 6),
      Location(x: 28, y: 7),
      Location(x: 28, y: 8),
      Location(x: 28, y: 9),
      Location(x: 28, y: 10),
      Location(x: 28, y: 11),
      Location(x: 28, y: 12),
      Location(x: 28, y: 13),
      Location(x: 28, y: 14),
      Location(x: 28, y: 15),
      Location(x: 28, y: 16),
      Location(x: 28, y: 17),
      Location(x: 29, y: 1),
      Location(x: 29, y: 2),
      Location(x: 29, y: 3),
      Location(x: 29, y: 4),
      Location(x: 29, y: 5),
      Location(x: 29, y: 6),
      Location(x: 29, y: 7),
      Location(x: 29, y: 8),
      Location(x: 29, y: 9),
      Location(x: 29, y: 10),
      Location(x: 29, y: 11),
      Location(x: 29, y: 12),
      Location(x: 29, y: 13),
      Location(x: 29, y: 14),
      Location(x: 29, y: 15),
      Location(x: 29, y: 16),
      Location(x: 29, y: 17),
      Location(x: 30, y: 1),
      Location(x: 30, y: 2),
      Location(x: 30, y: 3),
      Location(x: 30, y: 4),
      Location(x: 30, y: 5),
      Location(x: 30, y: 6),
      Location(x: 30, y: 7),
      Location(x: 30, y: 8),
      Location(x: 30, y: 9),
      Location(x: 30, y: 10),
      Location(x: 30, y: 11),
      Location(x: 30, y: 12),
      Location(x: 30, y: 13),
      Location(x: 30, y: 14),
      Location(x: 30, y: 15),
      Location(x: 30, y: 16),
      Location(x: 31, y: 2),
      Location(x: 31, y: 3),
      Location(x: 31, y: 4),
      Location(x: 31, y: 5),
      Location(x: 31, y: 6),
      Location(x: 31, y: 7),
      Location(x: 31, y: 8),
      Location(x: 31, y: 9),
      Location(x: 31, y: 10),
      Location(x: 31, y: 11),
      Location(x: 31, y: 12),
      Location(x: 31, y: 13),
      Location(x: 31, y: 14),
      Location(x: 31, y: 15),
      Location(x: 32, y: 4),
      Location(x: 32, y: 5),
      Location(x: 32, y: 6),
      Location(x: 32, y: 7),
      Location(x: 32, y: 8),
      Location(x: 32, y: 9),
      Location(x: 32, y: 10),
      Location(x: 32, y: 11),
      Location(x: 32, y: 12),
      Location(x: 33, y: 4),
      Location(x: 33, y: 5)
    ]
  )
  static let IS: Country = Country(
    code: "IS",
    name: "Iceland",
    locations: [
      Location(x: 32, y: 18),
      Location(x: 33, y: 18)
    ]
  )
  static let RU: Country = Country(
    code: "RU",
    name: "Russian Federation",
    locations: [
      Location(x: 43, y: 20),
      Location(x: 43, y: 21),
      Location(x: 43, y: 22),
      Location(x: 44, y: 16),
      Location(x: 44, y: 17),
      Location(x: 44, y: 18),
      Location(x: 44, y: 19),
      Location(x: 44, y: 20),
      Location(x: 44, y: 21),
      Location(x: 44, y: 22),
      Location(x: 44, y: 23),
      Location(x: 45, y: 16),
      Location(x: 45, y: 17),
      Location(x: 45, y: 18),
      Location(x: 45, y: 19),
      Location(x: 45, y: 20),
      Location(x: 45, y: 21),
      Location(x: 45, y: 22),
      Location(x: 45, y: 23),
      Location(x: 46, y: 17),
      Location(x: 46, y: 18),
      Location(x: 46, y: 19),
      Location(x: 46, y: 20),
      Location(x: 46, y: 21),
      Location(x: 46, y: 22),
      Location(x: 46, y: 23),
      Location(x: 46, y: 24),
      Location(x: 46, y: 25),
      Location(x: 47, y: 6),
      Location(x: 47, y: 17),
      Location(x: 47, y: 18),
      Location(x: 47, y: 19),
      Location(x: 47, y: 20),
      Location(x: 47, y: 21),
      Location(x: 47, y: 22),
      Location(x: 47, y: 23),
      Location(x: 48, y: 13),
      Location(x: 48, y: 14),
      Location(x: 48, y: 16),
      Location(x: 48, y: 17),
      Location(x: 48, y: 18),
      Location(x: 48, y: 19),
      Location(x: 48, y: 20),
      Location(x: 48, y: 21),
      Location(x: 48, y: 22),
      Location(x: 48, y: 23),
      Location(x: 49, y: 6),
      Location(x: 49, y: 11),
      Location(x: 49, y: 12),
      Location(x: 49, y: 13),
      Location(x: 49, y: 16),
      Location(x: 49, y: 17),
      Location(x: 49, y: 18),
      Location(x: 49, y: 19),
      Location(x: 49, y: 20),
      Location(x: 49, y: 21),
      Location(x: 49, y: 22),
      Location(x: 49, y: 23),
      Location(x: 50, y: 5),
      Location(x: 50, y: 6),
      Location(x: 50, y: 10),
      Location(x: 50, y: 11),
      Location(x: 50, y: 15),
      Location(x: 50, y: 16),
      Location(x: 50, y: 17),
      Location(x: 50, y: 18),
      Location(x: 50, y: 19),
      Location(x: 50, y: 20),
      Location(x: 50, y: 21),
      Location(x: 50, y: 22),
      Location(x: 51, y: 5),
      Location(x: 51, y: 10),
      Location(x: 51, y: 14),
      Location(x: 51, y: 15),
      Location(x: 51, y: 16),
      Location(x: 51, y: 17),
      Location(x: 51, y: 18),
      Location(x: 51, y: 19),
      Location(x: 51, y: 20),
      Location(x: 51, y: 21),
      Location(x: 51, y: 22),
      Location(x: 52, y: 13),
      Location(x: 52, y: 14),
      Location(x: 52, y: 15),
      Location(x: 52, y: 16),
      Location(x: 52, y: 17),
      Location(x: 52, y: 18),
      Location(x: 52, y: 19),
      Location(x: 52, y: 20),
      Location(x: 52, y: 21),
      Location(x: 52, y: 22),
      Location(x: 53, y: 14),
      Location(x: 53, y: 15),
      Location(x: 53, y: 16),
      Location(x: 53, y: 17),
      Location(x: 53, y: 18),
      Location(x: 53, y: 19),
      Location(x: 53, y: 20),
      Location(x: 53, y: 21),
      Location(x: 53, y: 22),
      Location(x: 54, y: 13),
      Location(x: 54, y: 14),
      Location(x: 54, y: 15),
      Location(x: 54, y: 16),
      Location(x: 54, y: 17),
      Location(x: 54, y: 18),
      Location(x: 54, y: 19),
      Location(x: 54, y: 20),
      Location(x: 54, y: 21),
      Location(x: 54, y: 22),
      Location(x: 54, y: 23),
      Location(x: 55, y: 13),
      Location(x: 55, y: 14),
      Location(x: 55, y: 15),
      Location(x: 55, y: 16),
      Location(x: 55, y: 17),
      Location(x: 55, y: 18),
      Location(x: 55, y: 19),
      Location(x: 55, y: 20),
      Location(x: 55, y: 21),
      Location(x: 55, y: 22),
      Location(x: 55, y: 23),
      Location(x: 56, y: 11),
      Location(x: 56, y: 12),
      Location(x: 56, y: 13),
      Location(x: 56, y: 14),
      Location(x: 56, y: 15),
      Location(x: 56, y: 16),
      Location(x: 56, y: 17),
      Location(x: 56, y: 18),
      Location(x: 56, y: 19),
      Location(x: 56, y: 20),
      Location(x: 56, y: 21),
      Location(x: 56, y: 22),
      Location(x: 56, y: 23),
      Location(x: 57, y: 5),
      Location(x: 57, y: 6),
      Location(x: 57, y: 7),
      Location(x: 57, y: 11),
      Location(x: 57, y: 12),
      Location(x: 57, y: 13),
      Location(x: 57, y: 14),
      Location(x: 57, y: 15),
      Location(x: 57, y: 16),
      Location(x: 57, y: 17),
      Location(x: 57, y: 18),
      Location(x: 57, y: 19),
      Location(x: 57, y: 20),
      Location(x: 57, y: 21),
      Location(x: 57, y: 22),
      Location(x: 57, y: 23),
      Location(x: 58, y: 7),
      Location(x: 58, y: 8),
      Location(x: 58, y: 11),
      Location(x: 58, y: 12),
      Location(x: 58, y: 13),
      Location(x: 58, y: 14),
      Location(x: 58, y: 15),
      Location(x: 58, y: 16),
      Location(x: 58, y: 17),
      Location(x: 58, y: 18),
      Location(x: 58, y: 19),
      Location(x: 58, y: 20),
      Location(x: 58, y: 21),
      Location(x: 58, y: 22),
      Location(x: 58, y: 23),
      Location(x: 59, y: 8),
      Location(x: 59, y: 9),
      Location(x: 59, y: 10),
      Location(x: 59, y: 11),
      Location(x: 59, y: 12),
      Location(x: 59, y: 13),
      Location(x: 59, y: 14),
      Location(x: 59, y: 15),
      Location(x: 59, y: 16),
      Location(x: 59, y: 17),
      Location(x: 59, y: 18),
      Location(x: 59, y: 19),
      Location(x: 59, y: 20),
      Location(x: 59, y: 21),
      Location(x: 59, y: 22),
      Location(x: 59, y: 23),
      Location(x: 60, y: 10),
      Location(x: 60, y: 11),
      Location(x: 60, y: 12),
      Location(x: 60, y: 13),
      Location(x: 60, y: 14),
      Location(x: 60, y: 15),
      Location(x: 60, y: 16),
      Location(x: 60, y: 17),
      Location(x: 60, y: 18),
      Location(x: 60, y: 19),
      Location(x: 60, y: 20),
      Location(x: 60, y: 21),
      Location(x: 60, y: 22),
      Location(x: 60, y: 23),
      Location(x: 61, y: 10),
      Location(x: 61, y: 11),
      Location(x: 61, y: 13),
      Location(x: 61, y: 14),
      Location(x: 61, y: 15),
      Location(x: 61, y: 16),
      Location(x: 61, y: 17),
      Location(x: 61, y: 18),
      Location(x: 61, y: 19),
      Location(x: 61, y: 20),
      Location(x: 61, y: 21),
      Location(x: 61, y: 22),
      Location(x: 61, y: 23),
      Location(x: 61, y: 24),
      Location(x: 62, y: 13),
      Location(x: 62, y: 14),
      Location(x: 62, y: 15),
      Location(x: 62, y: 16),
      Location(x: 62, y: 17),
      Location(x: 62, y: 18),
      Location(x: 62, y: 19),
      Location(x: 62, y: 20),
      Location(x: 62, y: 21),
      Location(x: 62, y: 22),
      Location(x: 62, y: 23),
      Location(x: 62, y: 24),
      Location(x: 63, y: 13),
      Location(x: 63, y: 14),
      Location(x: 63, y: 15),
      Location(x: 63, y: 16),
      Location(x: 63, y: 17),
      Location(x: 63, y: 18),
      Location(x: 63, y: 19),
      Location(x: 63, y: 20),
      Location(x: 63, y: 21),
      Location(x: 63, y: 22),
      Location(x: 64, y: 13),
      Location(x: 64, y: 14),
      Location(x: 64, y: 15),
      Location(x: 64, y: 16),
      Location(x: 64, y: 17),
      Location(x: 64, y: 18),
      Location(x: 64, y: 19),
      Location(x: 64, y: 20),
      Location(x: 64, y: 21),
      Location(x: 64, y: 22),
      Location(x: 65, y: 15),
      Location(x: 65, y: 16),
      Location(x: 65, y: 17),
      Location(x: 65, y: 18),
      Location(x: 65, y: 19),
      Location(x: 65, y: 20),
      Location(x: 65, y: 21),
      Location(x: 65, y: 22),
      Location(x: 65, y: 23),
      Location(x: 65, y: 24),
      Location(x: 66, y: 11),
      Location(x: 66, y: 15),
      Location(x: 66, y: 16),
      Location(x: 66, y: 17),
      Location(x: 66, y: 18),
      Location(x: 66, y: 19),
      Location(x: 66, y: 20),
      Location(x: 66, y: 21),
      Location(x: 66, y: 22),
      Location(x: 66, y: 23),
      Location(x: 66, y: 24),
      Location(x: 66, y: 25),
      Location(x: 67, y: 11),
      Location(x: 67, y: 13),
      Location(x: 67, y: 14),
      Location(x: 67, y: 15),
      Location(x: 67, y: 16),
      Location(x: 67, y: 17),
      Location(x: 67, y: 18),
      Location(x: 67, y: 19),
      Location(x: 67, y: 20),
      Location(x: 67, y: 21),
      Location(x: 67, y: 23),
      Location(x: 67, y: 24),
      Location(x: 68, y: 11),
      Location(x: 68, y: 14),
      Location(x: 68, y: 15),
      Location(x: 68, y: 16),
      Location(x: 68, y: 17),
      Location(x: 68, y: 18),
      Location(x: 68, y: 19),
      Location(x: 68, y: 20),
      Location(x: 69, y: 14),
      Location(x: 69, y: 15),
      Location(x: 69, y: 16),
      Location(x: 69, y: 17),
      Location(x: 69, y: 18),
      Location(x: 69, y: 19),
      Location(x: 69, y: 20),
      Location(x: 70, y: 15),
      Location(x: 70, y: 16),
      Location(x: 70, y: 17),
      Location(x: 70, y: 18),
      Location(x: 70, y: 19),
      Location(x: 70, y: 20),
      Location(x: 71, y: 15),
      Location(x: 71, y: 16),
      Location(x: 71, y: 17),
      Location(x: 71, y: 18),
      Location(x: 71, y: 19),
      Location(x: 71, y: 21),
      Location(x: 71, y: 22),
      Location(x: 71, y: 23),
      Location(x: 72, y: 16),
      Location(x: 72, y: 17),
      Location(x: 72, y: 18),
      Location(x: 72, y: 19),
      Location(x: 72, y: 20),
      Location(x: 73, y: 16),
      Location(x: 73, y: 17),
      Location(x: 73, y: 18),
      Location(x: 73, y: 19),
      Location(x: 73, y: 20),
      Location(x: 74, y: 15),
      Location(x: 74, y: 16),
      Location(x: 74, y: 17),
      Location(x: 74, y: 18),
      Location(x: 74, y: 19),
      Location(x: 74, y: 20),
      Location(x: 75, y: 16),
      Location(x: 75, y: 17),
      Location(x: 75, y: 18),
      Location(x: 75, y: 19),
      Location(x: 76, y: 14),
      Location(x: 76, y: 16),
      Location(x: 76, y: 17),
      Location(x: 77, y: 17),
      Location(x: 77, y: 18),
    ]
  )
  static let NO: Country = Country(
    code: "NO",
    name: "Norway",
    locations: [
      Location(x: 38, y: 19),
      Location(x: 38, y: 20),
      Location(x: 38, y: 21),
      Location(x: 39, y: 7),
      Location(x: 39, y: 18),
      Location(x: 39, y: 19),
      Location(x: 39, y: 20),
      Location(x: 40, y: 7),
      Location(x: 40, y: 8),
      Location(x: 40, y: 9),
      Location(x: 40, y: 16),
      Location(x: 41, y: 7),
      Location(x: 41, y: 8),
      Location(x: 41, y: 15),
      Location(x: 42, y: 6),
      Location(x: 42, y: 7),
      Location(x: 42, y: 9),
      Location(x: 42, y: 15),
    ]
  )
  static let SE: Country = Country(
    code: "SE",
    name: "Sweden",
    locations: [
      Location(x: 40, y: 17),
      Location(x: 40, y: 18),
      Location(x: 40, y: 19),
      Location(x: 40, y: 20),
      Location(x: 40, y: 21),
      Location(x: 41, y: 16),
      Location(x: 41, y: 17),
      Location(x: 41, y: 18),
    ]
  )
  static let FI: Country = Country(
    code: "FI",
    name: "Finland",
    locations: [
      Location(x: 42, y: 16),
      Location(x: 42, y: 17),
      Location(x: 42, y: 18),
      Location(x: 42, y: 19),
      Location(x: 43, y: 15),
      Location(x: 43, y: 16),
      Location(x: 43, y: 17),
      Location(x: 43, y: 18),
      Location(x: 43, y: 19),
    ]
  )
  static let EE: Country = Country(
    code: "EE",
    name: "Estonia",
    locations: [
      Location(x: 42, y: 20)
    ]
  )
  static let LV: Country = Country(
    code: "LV",
    name: "Latvia",
    locations: [
      Location(x: 42, y: 21)
    ]
  )
  static let LT: Country = Country(
    code: "LT",
    name: "Lithuania",
    locations: [
      Location(x: 41, y: 22),
      Location(x: 42, y: 22)
    ]
  )
  static let BY: Country = Country(
    code: "BY",
    name: "Belarus",
    locations: [
      Location(x: 42, y: 23),
      Location(x: 43, y: 23)
    ]
  )
  static let MD: Country = Country(
    code: "MD",
    name: "Moldova",
    locations: [
      Location(x: 43, y: 25)
    ]
  )
  static let UA: Country = Country(
    code: "UA",
    name: "Ukraine",
    locations: [
      Location(x: 42, y: 24),
      Location(x: 43, y: 24),
      Location(x: 44, y: 24),
      Location(x: 45, y: 24),
      Location(x: 44, y: 25)
    ]
  )
  static let RO: Country = Country(
    code: "RO",
    name: "Romania",
    locations: [
      Location(x: 42, y: 25)
    ]
  )
  static let GB: Country = Country(
    code: "GB",
    name: "United Kingdom",
    locations: [
      Location(x: 35, y: 22),
      Location(x: 36, y: 21),
      Location(x: 36, y: 22),
      Location(x: 36, y: 23)
    ]
  )
  static let IE: Country = Country(
    code: "IE",
    name: "Ireland",
    locations: [
      Location(x: 35, y: 23)
    ]
  )
  static let PT: Country = Country(
    code: "PT",
    name: "Portugal",
    locations: [
      Location(x: 35, y: 26),
      Location(x: 35, y: 27)
    ]
  )
  static let ES: Country = Country(
    code: "PT",
    name: "Spain",
    locations: [
      Location(x: 36, y: 26),
      Location(x: 36, y: 27)
    ]
  )
  static let FR: Country = Country(
    code: "FR",
    name: "France",
    locations: [
      Location(x: 36, y: 25),
      Location(x: 37, y: 25)
    ]
  )
  static let AD: Country = Country(
    code: "AD",
    name: "Andorra",
    locations: [
      Location(x: 37, y: 26)
    ]
  )
  static let IT: Country = Country(
    code: "IT",
    name: "Italy",
    locations: [
      Location(x: 39, y: 27),
      Location(x: 40, y: 27)
    ]
  )
  static let MC: Country = Country(
    code: "MC",
    name: "Monaco",
    locations: [
      Location(x: 38, y: 26)
    ]
  )
  static let SM: Country = Country(
    code: "SM",
    name: "San Marino",
    locations: [
      Location(x: 39, y: 26)
    ]
  )
  static let DE: Country = Country(
    code: "DE",
    name: "Germany",
    locations: [
      Location(x: 39, y: 23)
    ]
  )
  static let NL: Country = Country(
    code: "NL",
    name: "Netherlands",
    locations: [
      Location(x: 38, y: 23)
    ]
  )
  static let BE: Country = Country(
    code: "BE",
    name: "Belgium",
    locations: [
      Location(x: 37, y: 24)
    ]
  )
  static let LU: Country = Country(
    code: "LU",
    name: "Luxembourg",
    locations: [
      Location(x: 38, y: 24)
    ]
  )
  static let LI: Country = Country(
    code: "LI",
    name: "Liechtenstein",
    locations: [
      Location(x: 39, y: 24)
    ]
  )
  static let PL: Country = Country(
    code: "PL",
    name: "Poland",
    locations: [
      Location(x: 41, y: 23)
    ]
  )
  static let SK: Country = Country(
    code: "SK",
    name: "Slovakia",
    locations: [
      Location(x: 41, y: 24)
    ]
  )
  static let HU: Country = Country(
    code: "HU",
    name: "Hungary",
    locations: [
      Location(x: 41, y: 25)
    ]
  )
  static let CZ: Country = Country(
    code: "CZ",
    name: "Czech Republic",
    locations: [
      Location(x: 40, y: 23)
    ]
  )
  static let AT: Country = Country(
    code: "AT",
    name: "Austria",
    locations: [
      Location(x: 40, y: 24)
    ]
  )
  static let CH: Country = Country(
    code: "CH",
    name: "Switzerland",
    locations: [
      Location(x: 38, y: 25)
    ]
  )
  static let SI: Country = Country(
    code: "SI",
    name: "Slovenia",
    locations: [
      Location(x: 39, y: 25)
    ]
  )
  static let HR: Country = Country(
    code: "HR",
    name: "Croatia",
    locations: [
      Location(x: 40, y: 25)
    ]
  )
  static let BA: Country = Country(
    code: "BA",
    name: "Bosnia",
    locations: [
      Location(x: 40, y: 26)
    ]
  )
  static let CS: Country = Country(
    code: "CS",
    name: "Serbia",
    locations: [
      Location(x: 41, y: 26)
    ]
  )
  static let MK: Country = Country(
    code: "MK",
    name: "Macedonia",
    locations: [
      Location(x: 42, y: 27)
    ]
  )
  static let AL: Country = Country(
    code: "AL",
    name: "Albania",
    locations: [
      Location(x: 41, y: 27)
    ]
  )
  static let GR: Country = Country(
    code: "GR",
    name: "Greece",
    locations: [
      Location(x: 41, y: 28)
    ]
  )
  static let BG: Country = Country(
    code: "BG",
    name: "Bulgaria",
    locations: [
      Location(x: 42, y: 26)
    ]
  )
  static let GE: Country = Country(
    code: "GE",
    name: "Georgia",
    locations: [
      Location(x: 46, y: 26)
    ]
  )
  static let AM: Country = Country(
    code: "AM",
    name: "Armenia",
    locations: [
      Location(x: 46, y: 27)
    ]
  )
  static let AZ: Country = Country(
    code: "AZ",
    name: "Azerbaijan",
    locations: [
      Location(x: 47, y: 27)
    ]
  )
  static let TR: Country = Country(
    code: "TR",
    name: "Turkey",
    locations: [
      Location(x: 44, y: 27),
      Location(x: 45, y: 27)
    ]
  )
  static let SY: Country = Country(
    code: "SY",
    name: "Syrian Arab Republic",
    locations: [
      Location(x: 45, y: 28)
    ]
  )
  static let CY: Country = Country(
    code: "CY",
    name: "Cyprus",
    locations: [
      Location(x: 43, y: 28)
    ]
  )
  static let LB: Country = Country(
    code: "LB",
    name: "Lebanon",
    locations: [
      Location(x: 44, y: 28)
    ]
  )
  static let VC: Country = Country(
    code: "VC",
    name: "Cyprus",
    locations: [
      Location(x: 44, y: 29)
    ]
  )
  static let JO: Country = Country(
    code: "JO",
    name: "Jordan",
    locations: [
      Location(x: 45, y: 29)
    ]
  )
  static let BH: Country = Country(
    code: "BH",
    name: "Bahrain",
    locations: [
      Location(x: 46, y: 30)
    ]
  )
  static let QA: Country = Country(
    code: "QA",
    name: "Qatar",
    locations: [
      Location(x: 47, y: 31)
    ]
  )
  static let KW: Country = Country(
    code: "KW",
    name: "Kuwait",
    locations: [
      Location(x: 47, y: 30)
    ]
  )
  static let SA: Country = Country(
    code: "SA",
    name: "Saudi Arabia",
    locations: [
      Location(x: 45, y: 30),
      Location(x: 45, y: 31),
      Location(x: 46, y: 31),
      Location(x: 46, y: 32),
      Location(x: 47, y: 32),
      Location(x: 48, y: 32)
    ]
  )
  static let IQ: Country = Country(
    code: "IQ",
    name: "Iraq",
    locations: [
      Location(x: 46, y: 28),
      Location(x: 46, y: 29)
    ]
  )
  static let AE: Country = Country(
    code: "AE",
    name: "United Arab Emirates",
    locations: [
      Location(x: 48, y: 31)
    ]
  )
  static let OM: Country = Country(
    code: "OM",
    name: "Oman",
    locations: [
      Location(x: 49, y: 32),
      Location(x: 48, y: 33)
    ]
  )
  static let YE: Country = Country(
    code: "YE",
    name: "Yemen",
    locations: [
      Location(x: 46, y: 33),
      Location(x: 47, y: 33)
    ]
  )
  static let IR: Country = Country(
    code: "IR",
    name: "Iran",
    locations: [
      Location(x: 47, y: 28),
      Location(x: 47, y: 29),
      Location(x: 48, y: 28),
      Location(x: 48, y: 29),
      Location(x: 48, y: 30),
      Location(x: 49, y: 28),
      Location(x: 49, y: 29),
      Location(x: 49, y: 30),
      Location(x: 50, y: 30)
    ]
  )
  static let PK: Country = Country(
    code: "PK",
    name: "Pakistan",
    locations: [
      Location(x: 51, y: 30),
      Location(x: 51, y: 31),
      Location(x: 52, y: 29),
      Location(x: 52, y: 30),
      Location(x: 52, y: 31),
    ]
  )
  static let AF: Country = Country(
    code: "AF",
    name: "Afghanistan",
    locations: [
      Location(x: 50, y: 29),
      Location(x: 51, y: 29),
      Location(x: 51, y: 28),
      Location(x: 52, y: 28)
    ]
  )
  static let TM: Country = Country(
    code: "TM",
    name: "Turkmenistan",
    locations: [
      Location(x: 50, y: 28),
      Location(x: 50, y: 27),
      Location(x: 49, y: 27)
    ]
  )
  static let UZ: Country = Country(
    code: "UZ",
    name: "Uzbekistan",
    locations: [
      Location(x: 49, y: 26),
      Location(x: 50, y: 26),
      Location(x: 51, y: 26),
      Location(x: 51, y: 27)
    ]
  )
  static let TJ: Country = Country(
    code: "TJ",
    name: "Tajikistan",
    locations: [
      Location(x: 52, y: 27)
    ]
  )
  static let KG: Country = Country(
    code: "KG",
    name: "Kyrgyzstan",
    locations: [
      Location(x: 53, y: 27)
    ]
  )
  static let KZ: Country = Country(
    code: "KZ",
    name: "Kazakhstan",
    locations: [
      Location(x: 47, y: 24),
      Location(x: 47, y: 25),
      Location(x: 48, y: 24),
      Location(x: 48, y: 25),
      Location(x: 48, y: 26),
      Location(x: 49, y: 24),
      Location(x: 49, y: 25),
      Location(x: 50, y: 23),
      Location(x: 50, y: 24),
      Location(x: 50, y: 25),
      Location(x: 51, y: 23),
      Location(x: 51, y: 24),
      Location(x: 51, y: 25),
      Location(x: 52, y: 23),
      Location(x: 52, y: 24),
      Location(x: 52, y: 25),
      Location(x: 52, y: 26),
      Location(x: 53, y: 23),
      Location(x: 53, y: 24),
      Location(x: 53, y: 25),
      Location(x: 53, y: 26),
      Location(x: 54, y: 24),
      Location(x: 54, y: 25),
      Location(x: 54, y: 26),
      Location(x: 55, y: 24),
      Location(x: 55, y: 25)
    ]
  )
  static let MN: Country = Country(
    code: "MN",
    name: "Mongolia",
    locations: [
      Location(x: 56, y: 24),
      Location(x: 56, y: 25),
      Location(x: 57, y: 24),
      Location(x: 57, y: 25),
      Location(x: 58, y: 24),
      Location(x: 58, y: 25),
      Location(x: 58, y: 26),
      Location(x: 59, y: 24),
      Location(x: 59, y: 25),
      Location(x: 59, y: 26),
      Location(x: 60, y: 24),
      Location(x: 60, y: 25),
      Location(x: 60, y: 26),
      Location(x: 61, y: 25),
      Location(x: 62, y: 25),
    ]
  )
  static let KP: Country = Country(
    code: "KP",
    name: "Korea, Democratic Peoples Republic",
    locations: [
      Location(x: 64, y: 27)
    ]
  )
  static let KR: Country = Country(
    code: "KR",
    name: "Korea, Republic",
    locations: [ Location(x: 64, y: 28)
    ]
  )
  static let BT: Country = Country(
    code: "BT",
    name: "Bhutan",
    locations: [
      Location(x: 56, y: 30)
    ]
  )
  static let BD: Country = Country(
    code: "BD",
    name: "Bangladesh",
    locations: [
      Location(x: 56, y: 31)
    ]
  )
  static let MM: Country = Country(
    code: "MM",
    name: "Myanmar",
    locations: [
      Location(x: 57, y: 30),
      Location(x: 57, y: 31),
      Location(x: 57, y: 32),
      Location(x: 58, y: 32)
    ]
  )
  static let LA: Country = Country(
    code: "LA",
    name: "Laos",
    locations: [
      Location(x: 59, y: 32)
    ]
  )
  static let KH: Country = Country(
    code: "KH",
    name: "Cambodia",
    locations: [
      Location(x: 59, y: 34)
    ]
  )
  static let VT: Country = Country(
    code: "VT",
    name: "Vietnam",
    locations: [
      Location(x: 60, y: 33),
      Location(x: 60, y: 34),
    ]
  )
  static let TW: Country = Country(
    code: "TW",
    name: "Thailand",
    locations: [
      Location(x: 58, y: 33),
      Location(x: 58, y: 34),
      Location(x: 59, y: 33),
    ]
  )
  static let MY: Country = Country(
    code: "MY",
    name: "Malaysia",
    locations: [
      Location(x: 58, y: 35)
    ]
  )
  static let NP: Country = Country(
    code: "NP",
    name: "Nepal",
    locations: [
      Location(x: 54, y: 30),
      Location(x: 55, y: 30),
    ]
  )
  static let LK: Country = Country(
    code: "LK",
    name: "Sri Lanka",
    locations: [
      Location(x: 54, y: 35)
    ]
  )
  static let IN: Country = Country(
    code: "IN",
    name: "India",
    locations: [
      Location(x: 53, y: 28),
      Location(x: 53, y: 29),
      Location(x: 54, y: 29),
      Location(x: 53, y: 30),
      Location(x: 53, y: 31),
      Location(x: 54, y: 31),
      Location(x: 55, y: 31),
      Location(x: 52, y: 32),
      Location(x: 53, y: 32),
      Location(x: 54, y: 32),
      Location(x: 55, y: 32),
      Location(x: 53, y: 33),
      Location(x: 54, y: 33),
      Location(x: 53, y: 34)
    ]
  )
  static let SG: Country = Country(
    code: "SG",
    name: "Singapore",
    locations: [
      Location(x: 59, y: 36)
    ]
  )
  static let BN: Country = Country(
    code: "BN",
    name: "Brunei Darussalam",
    locations:
      [
        Location(x: 61, y: 36)
      ]
  )
  static let ID: Country = Country(
    code: "ID",
    name: "Indonesia",
    locations: [
      Location(x: 58, y: 36),
      Location(x: 59, y: 37),
      Location(x: 60, y: 38),
      Location(x: 61, y: 38),
      Location(x: 61, y: 37),
      Location(x: 62, y: 37),
      Location(x: 62, y: 36),
      Location(x: 62, y: 35),
      Location(x: 63, y: 37),
      Location(x: 65, y: 37),
      Location(x: 66, y: 37),
      Location(x: 67, y: 37),
      Location(x: 67, y: 38)
    ]
  )
  static let PG: Country = Country(
    code: "PG",
    name: "Papua New Guinea",
    locations: [
      Location(x: 68, y: 38),
      Location(x: 68, y: 37)
    ]
  )
  static let PH: Country = Country(
    code: "PH",
    name: "Philippine",
    locations: [
      Location(x: 63, y: 34),
      Location(x: 63, y: 33),
      Location(x: 64, y: 35)
    ]
  )
  static let TL: Country = Country(
    code: "TL",
    name: "East Timor",
    locations: [
      Location(x: 65, y: 38)
    ]
  )
  static let PW: Country = Country(
    code: "PW",
    name: "Palau",
    locations: [
      Location(x: 67, y: 35)
    ]
  )
  static let GU: Country = Country(
    code: "GU",
    name: "Guam",
    locations: [
      Location(x: 67, y: 34)
    ]
  )
  static let MP: Country = Country(
    code: "MP",
    name: "Commonwealth of the Northern Mariana Islands",
    locations: [
      Location(x: 69, y: 33)
    ]
  )
  static let MH: Country = Country(
    code: "MH",
    name: "Marshall Islands",
    locations: [
      Location(x: 74, y: 34)
    ]
  )
  static let NR: Country = Country(
    code: "NR",
    name: "Nauru",
    locations: [
      Location(x: 72, y: 37)
    ]
  )
  static let SB: Country = Country(
    code: "SB",
    name: "Solomon Islands",
    locations: [
      Location(x: 70, y: 38),
      Location(x: 71, y: 38)
    ]
  )
  static let VU: Country = Country(
    code: "VU",
    name: "Vanuatu",
    locations: [
      Location(x: 73, y: 40)
    ]
  )
  static let NC: Country = Country(
    code: "NC",
    name: "New Caledonia",
    locations: [
      Location(x: 72, y: 41),
      Location(x: 73, y: 42)
    ]
  )
  static let FJ: Country = Country(
    code: "FJ",
    name: "Fiji",
    locations: [
      Location(x: 75, y: 40)
    ]
  )
  static let WS: Country = Country(
    code: "WS",
    name: "Samoa",
    locations: [
      Location(x: 77, y: 40)
    ]
  )
  static let TO: Country = Country(
    code: "TO",
    name: "Tonga",
    locations: [
      Location(x: 77, y: 42)
    ]
  )
  static let WF: Country = Country(
    code: "WF",
    name: "Wallis and Futuna",
    locations: [
      Location(x: 75, y: 39)
    ]
  )
  static let KI: Country = Country(
    code: "KI",
    name: "Kiribati",
    locations: [
      Location(x: 77, y: 36)
    ]
  )
  static let TV: Country = Country(
    code: "TV",
    name: "Tuvaluv",
    locations: [
      Location(x: 75, y: 37)
    ]
  )
  static let NZ: Country = Country(
    code: "NZ",
    name: "New Zealand",
    locations: [
      Location(x: 75, y: 45),
      Location(x: 75, y: 46),
      Location(x: 74, y: 47),
      Location(x: 73, y: 47),
      Location(x: 73, y: 48)
    ]
  )
  static let AU: Country = Country(
    code: "AU",
    name: "Australia",
    locations: [
      Location(x: 68, y: 47),
      Location(x: 69, y: 45),
      Location(x: 69, y: 44),
      Location(x: 69, y: 43),
      Location(x: 69, y: 42),
      Location(x: 68, y: 45),
      Location(x: 68, y: 44),
      Location(x: 68, y: 43),
      Location(x: 68, y: 42),
      Location(x: 68, y: 41),
      Location(x: 68, y: 40),
      Location(x: 67, y: 45),
      Location(x: 67, y: 44),
      Location(x: 67, y: 43),
      Location(x: 67, y: 42),
      Location(x: 67, y: 41),
      Location(x: 67, y: 40),
      Location(x: 66, y: 44),
      Location(x: 66, y: 43),
      Location(x: 66, y: 42),
      Location(x: 66, y: 41),
      Location(x: 66, y: 40),
      Location(x: 65, y: 43),
      Location(x: 65, y: 42),
      Location(x: 65, y: 41),
      Location(x: 65, y: 40),
      Location(x: 64, y: 44),
      Location(x: 64, y: 43),
      Location(x: 64, y: 42),
      Location(x: 64, y: 41),
      Location(x: 64, y: 40),
      Location(x: 63, y: 44),
      Location(x: 63, y: 43),
      Location(x: 63, y: 42),
      Location(x: 63, y: 41),
      Location(x: 62, y: 44),
      Location(x: 62, y: 43),
      Location(x: 62, y: 42),
      Location(x: 62, y: 41),
      Location(x: 61, y: 42)
    ]
  )
  static let JP: Country = Country(
    code: "JP",
    name: "Japan",
    locations: [
      Location(x: 65, y: 29),
      Location(x: 66, y: 29),
      Location(x: 66, y: 28),
      Location(x: 67, y: 28),
      Location(x: 67, y: 27),
      Location(x: 67, y: 26),
      Location(x: 68, y: 26)
    ]
  )
  static let CN: Country = Country(
    code: "CN",
    name: "China",
    locations: [
      Location(x: 54, y: 27),
      Location(x: 54, y: 28),
      Location(x: 55, y: 26),
      Location(x: 55, y: 27),
      Location(x: 55, y: 28),
      Location(x: 55, y: 29),
      Location(x: 56, y: 26),
      Location(x: 56, y: 27),
      Location(x: 56, y: 28),
      Location(x: 56, y: 29),
      Location(x: 57, y: 26),
      Location(x: 57, y: 27),
      Location(x: 57, y: 28),
      Location(x: 57, y: 29),
      Location(x: 58, y: 27),
      Location(x: 58, y: 28),
      Location(x: 58, y: 29),
      Location(x: 58, y: 30),
      Location(x: 58, y: 31),
      Location(x: 59, y: 27),
      Location(x: 59, y: 28),
      Location(x: 59, y: 29),
      Location(x: 59, y: 30),
      Location(x: 59, y: 31),
      Location(x: 60, y: 27),
      Location(x: 60, y: 28),
      Location(x: 60, y: 29),
      Location(x: 60, y: 30),
      Location(x: 60, y: 31),
      Location(x: 61, y: 26),
      Location(x: 61, y: 27),
      Location(x: 61, y: 28),
      Location(x: 61, y: 29),
      Location(x: 61, y: 30),
      Location(x: 61, y: 31),
      Location(x: 62, y: 26),
      Location(x: 62, y: 27),
      Location(x: 62, y: 28),
      Location(x: 62, y: 29),
      Location(x: 62, y: 30),
      Location(x: 62, y: 31),
      Location(x: 63, y: 23),
      Location(x: 63, y: 24),
      Location(x: 63, y: 25),
      Location(x: 63, y: 26),
      Location(x: 64, y: 23),
      Location(x: 64, y: 24),
      Location(x: 64, y: 25),
      Location(x: 64, y: 26),
      Location(x: 65, y: 25),
      Location(x: 65, y: 26)
    ]
  )
  static let EG: Country = Country(
    code: "EG",
    name: "Egypt",
    locations: [
      Location(x: 42, y: 30),
      Location(x: 42, y: 31),
      Location(x: 43, y: 31),
      Location(x: 44, y: 31)
    ]
  )
  static let LY: Country = Country(
    code: "LY",
    name: "Libya",
    locations: [
      Location(x: 39, y: 30),
      Location(x: 39, y: 31),
      Location(x: 40, y: 30),
      Location(x: 40, y: 31),
      Location(x: 41, y: 30),
      Location(x: 41, y: 31)
    ]
  )
  static let TN: Country = Country(
    code: "TN",
    name: "Tunisia",
    locations: [
      Location(x: 39, y: 29)
    ]
  )
  static let DZ: Country = Country(
    code: "DZ",
    name: "Algeria",
    locations: [
      Location(x: 35, y: 30),
      Location(x: 36, y: 30),
      Location(x: 36, y: 31),
      Location(x: 37, y: 29),
      Location(x: 37, y: 30),
      Location(x: 37, y: 31),
      Location(x: 37, y: 32),
      Location(x: 38, y: 29),
      Location(x: 38, y: 30),
      Location(x: 38, y: 31),
      Location(x: 38, y: 32)
    ]
  )
  static let MA: Country = Country(
    code: "MA",
    name: "Morocco",
    locations: [
      Location(x: 35, y: 29),
      Location(x: 36, y: 29)
    ]
  )
  static let GW: Country = Country(
    code: "GN",
    name: "Guinea Bissau",
    locations: [
      Location(x: 33, y: 34)
    ]
  )
  static let SN: Country = Country(
    code: "SN",
    name: "Senegal",
    locations: [
      Location(x: 33, y: 33)
    ]
  )
  static let GN: Country = Country(
    code: "GN",
    name: "Guinea",
    locations: [
      Location(x: 34, y: 34)
    ]
  )
  static let SL: Country = Country(
    code: "SL",
    name: "Sierra Leone",
    locations: [
      Location(x: 33, y: 35)
    ]
  )
  static let LR: Country = Country(
    code: "LR",
    name: "Liberia",
    locations: [
      Location(x: 34, y: 35)
    ]
  )
  static let CI: Country = Country(
    code: "CI",
    name: "Cote DIvoire",
    locations: [
      Location(x: 35, y: 35)
    ]
  )
  static let GH: Country = Country(
    code: "GH",
    name: "Ghana",
    locations: [
      Location(x: 36, y: 35)
    ]
  )
  static let TG: Country = Country(
    code: "TG",
    name: "Togo",
    locations: [
      Location(x: 37, y: 35)
    ]
  )
  static let BJ: Country = Country(
    code: "BJ",
    name: "Benin",
    locations: [
      Location(x: 37, y: 34)
    ]
  )
  static let BF: Country = Country(
    code: "BF",
    name: "Burkina Faso",
    locations: [
      Location(x: 36, y: 34)
    ]
  )
  static let EH: Country = Country(
    code: "EH",
    name: "Western Sahara",
    locations: [
      Location(x: 33, y: 32),
      Location(x: 34, y: 31)
    ]
  )
  static let ML: Country = Country(
    code: "ML",
    name: "Mali",
    locations: [
      Location(x: 35, y: 34),
      Location(x: 36, y: 33),
      Location(x: 36, y: 32),
      Location(x: 37, y: 33)
    ]
  )
  static let MR: Country = Country(
    code: "MR",
    name: "Mauritania",
    locations: [
      Location(x: 34, y: 32),
      Location(x: 34, y: 33),
      Location(x: 35, y: 31),
      Location(x: 35, y: 32),
      Location(x: 35, y: 33)
    ]
  )
  static let CM: Country = Country(
    code: "CM",
    name: "Cameroon",
    locations: [
      Location(x: 39, y: 35)
    ]
  )
  static let CQ: Country = Country(
    code: "CQ",
    name: "Equatorial Guinea",
    locations: [
      Location(x: 39, y: 36)
    ]
  )
  static let GA: Country = Country(
    code: "GA",
    name: "Gabon",
    locations: [
      Location(x: 39, y: 37)
    ]
  )
  static let ST: Country = Country(
    code: "ST",
    name: "Sao Tome and Principe",
    locations: [
      Location(x: 38, y: 37)
    ]
  )
  static let CG: Country = Country(
    code: "CG",
    name: "Congo",
    locations: [
      Location(x: 40, y: 37),
      Location(x: 40, y: 36)
    ]
  )
  static let CF: Country = Country(
    code: "CF",
    name: "Central African Republic",
    locations: [
      Location(x: 40, y: 35),
      Location(x: 41, y: 35)
    ]
  )
  static let SS: Country = Country(
    code: "SS",
    name: "South Sudan",
    locations: [
      Location(x: 42, y: 35),
      Location(x: 43, y: 35)
    ]
  )
  static let UG: Country = Country(
    code: "UG",
    name: "Uganda",
    locations: [
      Location(x: 44, y: 36)
    ]
  )
  static let SO: Country = Country(
    code: "SO",
    name: "Somalia",
    locations: [
      Location(x: 46, y: 36),
      Location(x: 47, y: 35)
    ]
  )
  static let DJ: Country = Country(
    code: "DJ",
    name: "Djibouti",
    locations: [
      Location(x: 46, y: 34)
    ]
  )
  static let ER: Country = Country(
    code: "ER",
    name: "Eritrea",
    locations: [
      Location(x: 45, y: 33)
    ]
  )
  static let SD: Country = Country(
    code: "SD",
    name: "Sudan",
    locations: [
      Location(x: 42, y: 32),
      Location(x: 42, y: 33),
      Location(x: 42, y: 34),
      Location(x: 43, y: 32),
      Location(x: 43, y: 33),
      Location(x: 43, y: 34),
      Location(x: 44, y: 32),
      Location(x: 44, y: 33),
      Location(x: 44, y: 34)
    ]
  )
  static let NE: Country = Country(
    code: "NE",
    name: "Niger",
    locations: [
      Location(x: 39, y: 32),
      Location(x: 39, y: 33),
      Location(x: 38, y: 33)
    ]
  )
  static let TD: Country = Country(
    code: "TD",
    name: "Chad",
    locations: [
      Location(x: 40, y: 32),
      Location(x: 40, y: 33),
      Location(x: 40, y: 34),
      Location(x: 41, y: 32),
      Location(x: 41, y: 33),
      Location(x: 41, y: 34)
    ]
  )
  static let NG: Country = Country(
    code: "NG",
    name: "Nigeria",
    locations: [
      Location(x: 38, y: 35),
      Location(x: 38, y: 34),
      Location(x: 39, y: 34)
    ]
  )
  static let KE: Country = Country(
    code: "KE",
    name: "Kenya",
    locations: [
      Location(x: 45, y: 36),
      Location(x: 45, y: 37)
    ]
  )
  static let ET: Country = Country(
    code: "ET",
    name: "Ethiopia",
    locations: [
      Location(x: 44, y: 35),
      Location(x: 45, y: 35),
      Location(x: 45, y: 34),
      Location(x: 46, y: 35)
    ]
  )
  static let RW: Country = Country(
    code: "RW",
    name: "Rwanda",
    locations: [
      Location(x: 43, y: 36)
    ]
  )
  static let BI: Country = Country(
    code: "BI",
    name: "Burundi",
    locations: [
      Location(x: 43, y: 37)
    ]
  )
  static let TZ: Country = Country(
    code: "TZ",
    name: "Tanzania",
    locations: [
      Location(x: 44, y: 37),
      Location(x: 44, y: 38),
      Location(x: 45, y: 38)
    ]
  )
  static let MZ: Country = Country(
    code: "MZ",
    name: "Mozambique",
    locations: [
      Location(x: 45, y: 39),
      Location(x: 45, y: 40),
      Location(x: 44, y: 40),
      Location(x: 44, y: 41)
    ]
  )
  static let ZW: Country = Country(
    code: "ZW",
    name: "Zimbabwe",
    locations: [
      Location(x: 43, y: 41)
    ]
  )
  static let ZM: Country = Country(
    code: "ZM",
    name: "Zambia",
    locations: [
      Location(x: 43, y: 40),
      Location(x: 43, y: 39),
      Location(x: 42, y: 40)
    ]
  )
  static let SZ: Country = Country(
    code: "SZ",
    name: "Swaziland",
    locations: [
      Location(x: 44, y: 42)
    ]
  )
  static let LS: Country = Country(
    code: "LS",
    name: "Lesotho",
    locations: [
      Location(x: 43, y: 43)
    ]
  )
  static let BW: Country = Country(
    code: "BW",
    name: "Botswana",
    locations: [
      Location(x: 42, y: 42),
      Location(x: 42, y: 41),
      Location(x: 41, y: 42)
    ]
  )
  static let ZA: Country = Country(
    code: "ZA",
    name: "South Africa",
    locations: [
      Location(x: 43, y: 42),
      Location(x: 42, y: 43),
      Location(x: 42, y: 44),
      Location(x: 41, y: 43),
      Location(x: 41, y: 44)
    ]
  )
  static let NA: Country = Country(
    code: "NA",
    name: "Namibia",
    locations: [
      Location(x: 40, y: 42),
      Location(x: 40, y: 41),
      Location(x: 41, y: 41)
    ]
  )
  static let AO: Country = Country(
    code: "AO",
    name: "Angola",
    locations: [
      Location(x: 40, y: 40),
      Location(x: 40, y: 39),
      Location(x: 40, y: 38),
      Location(x: 41, y: 40),
      Location(x: 41, y: 39)
    ]
  )
  static let CD: Country = Country(
    code: "CD",
    name: "Democratic Republic of the Congo",
    locations: [
      Location(x: 41, y: 38),
      Location(x: 41, y: 37),
      Location(x: 41, y: 36),
      Location(x: 42, y: 39),
      Location(x: 42, y: 38),
      Location(x: 42, y: 37),
      Location(x: 42, y: 36),
      Location(x: 43, y: 38)
    ]
  )
  static let MG: Country = Country(
    code: "MG",
    name: "Madagascar",
    locations: [
      Location(x: 46, y: 42),
      Location(x: 47, y: 41),
      Location(x: 47, y: 40)
    ]
  )
  static let KM: Country = Country(
    code: "KM",
    name: "Comoros",
    locations: [
      Location(x: 46, y: 39)
    ]
  )
  static let YT: Country = Country(
    code: "YT",
    name: "Mayotte",
    locations: [
      Location(x: 47, y: 39)
    ]
  )
  static let SC: Country = Country(
    code: "SC",
    name: "Seychelles",
    locations: [
      Location(x: 48, y: 38)
    ]
  )
  static let MV: Country = Country(
    code: "MV",
    name: "Maldives",
    locations: [
      Location(x: 52, y: 35)
    ]
  )
  static let MW: Country = Country(
    code: "MW",
    name: "Malawi",
    locations: [
      Location(x: 44, y: 39)
    ]
  )
}
extension WorldMap.Model {
  static let all: [String: Country] = [
    "US": US,
    "CA": CA,
    "MX": MX,
    "GT": GT,
    "SV": SV,
    "BZ": BZ,
    "HN": HN,
    "NI": NI,
    "CR": CR,
    "PA": PA,
    "CO": CO,
    "BS": BS,
    "CU": CU,
    "JM": JM,
    "HT": HT,
    "DO": DO,
    "PR": PR,
    "DM": DM,
    "GD": GD,
    "TT": TT,
    "AG": AG,
    "LC": LC,
    "BB": BB,
    "VE": VE,
    "EC": EC,
    "PE": PE,
    "BR": BR,
    "GY": GY,
    "SR": SR,
    "GF": GF,
    "BO": BO,
    "CL": CL,
    "AR": AR,
    "PY": PY,
    "UY": UY,
    "GL": GL,
    "IS": IS,
    "RU": RU,
    "NO": NO,
    "SE": SE,
    "FI": FI,
    "EE": EE,
    "LV": LV,
    "LT": LT,
    "BY": BY,
    "MD": MD,
    "UA": UA,
    "RO": RO,
    "GB": GB,
    "IE": IE,
    "PT": PT,
    "ES": ES,
    "FR": FR,
    "AD": AD,
    "IT": IT,
    "MC": MC,
    "SM": SM,
    "DE": DE,
    "NL": NL,
    "BE": BE,
    "LU": LU,
    "LI": LI,
    "PL": PL,
    "SK": SK,
    "HU": HU,
    "CZ": CZ,
    "AT": AT,
    "CH": CH,
    "SI": SI,
    "HR": HR,
    "BA": BA,
    "CS": CS,
    "MK": MK,
    "AL": AL,
    "GR": GR,
    "BG": BG,
    "GE": GE,
    "AM": AM,
    "AZ": AZ,
    "TR": TR,
    "SY": SY,
    "CY": CY,
    "LB": LB,
    "VC": VC,
    "JO": JO,
    "BH": BH,
    "QA": QA,
    "KW": KW,
    "SA": SA,
    "IQ": IQ,
    "AE": AE,
    "OM": OM,
    "YE": YE,
    "IR": IR,
    "PK": PK,
    "AF": AF,
    "TM": TM,
    "UZ": UZ,
    "TJ": TJ,
    "KG": KG,
    "KZ": KZ,
    "MN": MN,
    "KP": KP,
    "KR": KR,
    "BT": BT,
    "BD": BD,
    "MM": MM,
    "LA": LA,
    "KH": KH,
    "VT": VT,
    "TW": TW,
    "MY": MY,
    "NP": NP,
    "LK": LK,
    "IN": IN,
    "SG": SG,
    "BN": BN,
    "ID": ID,
    "PG": PG,
    "PH": PH,
    "TL": TL,
    "PW": PW,
    "GU": GU,
    "MP": MP,
    "MH": MH,
    "NR": NR,
    "SB": SB,
    "VU": VU,
    "NC": NC,
    "FJ": FJ,
    "WS": WS,
    "TO": TO,
    "WF": WF,
    "KI": KI,
    "TV": TV,
    "NZ": NZ,
    "AU": AU,
    "JP": JP,
    "CN": CN,
    "EG": EG,
    "LY": LY,
    "TN": TN,
    "DZ": DZ,
    "MA": MA,
    "GW": GW,
    "SN": SN,
    "GN": GN,
    "SL": SL,
    "LR": LR,
    "CI": CI,
    "GH": GH,
    "TG": TG,
    "BJ": BJ,
    "BF": BF,
    "EH": EH,
    "ML": ML,
    "MR": MR,
    "CM": CM,
    "CQ": CQ,
    "GA": GA,
    "ST": ST,
    "CG": CG,
    "CF": CF,
    "SS": SS,
    "UG": UG,
    "SO": SO,
    "DJ": DJ,
    "ER": ER,
    "SD": SD,
    "NE": NE,
    "TD": TD,
    "NG": NG,
    "KE": KE,
    "ET": ET,
    "RW": RW,
    "BI": BI,
    "TZ": TZ,
    "MZ": MZ,
    "ZW": ZW,
    "ZM": ZM,
    "SZ": SZ,
    "LS": LS,
    "BW": BW,
    "ZA": ZA,
    "NA": NA,
    "AO": AO,
    "CD": CD,
    "MG": MG,
    "KM": KM,
    "YT": YT,
    "SC": SC,
    "MV": MV,
    "MW": MW
  ]
}
