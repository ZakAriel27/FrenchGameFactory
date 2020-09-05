//
//  ClassWeapon.swift
//  FrenchGameFactory
//
//  Created by Pascal Diamand on 28/08/2020.
//  Copyright © 2020 Pascal Diamand. All rights reserved.
//

struct Weapon {
	var name: String
	
	init(_ name: String) {
		self.name = name
	}
}


struct Weapons {
	var weapon = [Weapon("BattleAxe"),
					  Weapon("Bolas"),
					  Weapon("Club"),
					  Weapon("Sword"),
					  Weapon("GreatClub"),
					  Weapon("GreatSword"),
					  Weapon("Hammer"),
					  Weapon("Hatchet"),
					  Weapon("Khopesh"),
					  Weapon("Mace"),
					  Weapon("MorningStar"),
					  Weapon("Nunchaku"),
					  Weapon("Spikedchain"),
					  Weapon("Staff"),
					  Weapon("StarKnife"),
					  Weapon("Trident")]

	// This function return an array of formated string for the display : weapons names of the armoury
	func weaponsList(_ lenght: Int) -> [String]{
	
		let space			= String(repeating: " ", count: 12)	// lenght for formated strings
		var weaponsList	= [String]()
		if lenght == 0 {
			for weapon in self.weapon {
					weaponsList.append(String(String(weapon.name + space).prefix(12)))
				}
		} else {
			let indexW = weaponsIndex
			for index in indexW...(min(self.weapon.count, indexW+lenght - 1)) {
				weaponsList.append(String(String(self.weapon[index].name + space).prefix(12)))
			}
			weaponsCountDisplayed = weaponsList.count	// Memorise number of weapons in the list
			weaponsNextIndex = ((weaponsIndex + weaponsList.count) % (self.weapon.count))
			let modulo = weaponsList.count % lenght
			if modulo != 0 {
				for _ in 1...modulo {
					weaponsList.append(space)
				}
			}
		}
		return weaponsList
	}
}

