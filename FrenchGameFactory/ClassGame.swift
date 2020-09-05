//
//  ClassGame.swift
//  FrenchGameFactory
//
//  Created by Pascal Diamand on 28/08/2020.
//  Copyright © 2020 Pascal Diamand. All rights reserved.
//

class Game {
	/*
	*/
	var gPoints			= [100,10,5]	//	Default points values for life, damage and care points for a single avatar
	var allocations	= [[Int]]()		// [A][P] Points [P] allocations of Life, damage and care for team's avatars [A]
	var turnMode		= true			// Turn mode between avatars in a team rotation (true) or free (false).
	var careMode		= true			// X care points given = X life points lost (true) or not life points lost
	var extraChance 	= 0			// Number of chances out of 10 of a proposal for an extra
	var extraPoints	= 0				// Number of points that can be added or deducted from the avatar's damage points
	
	init()
	{
		for _ in 0...2 {
			self.allocations.append(self.gPoints)	// Generation of inferred values
		}
	}
	
	// This function return an array of formated string for the display : current game's parameters
	func gameSettingList() -> [String]
	{
		let space		= String(repeating: " ", count: 13)	// lenght for formated strings
		var teamParam	= [String]()
		let part1		= String(space + String(self.gPoints[0])).suffix(3) + "  "
		let part2 		= String(space + String(self.gPoints[1])).suffix(3) + "  "
		let part3 		= String(space + String(self.gPoints[2])).suffix(2)
		teamParam.append(String(part1 + part2 + part3))
		for index in 0...2 {
			let part1 	= String(space + String(self.allocations[index][0])).suffix(3) + "  "
			let part2 	= String(space + String(self.allocations[index][1])).suffix(3) + "  "
			let part3 	= String(space + String(self.allocations[index][2])).suffix(2)
			teamParam.append(String(part1 + part2 + part3))
		}
		teamParam.append(String(String(space + String(self.extraChance)).suffix(2)))
		teamParam.append(String(String(String(self.extraPoints) + space).prefix(2)))
		teamParam.append((self.careMode == true ? "+C/-L   ":"+C      "))
		teamParam.append((self.turnMode == true ? "Rotation":"Free    "))
		return teamParam
	}
	
	func gameLifePoints() -> [Int]
	{
		var LifePoints = [Int]()
		LifePoints.append(self.gPoints[0] * 3)
		for index in 0...2 {
			LifePoints.append(self.allocations[index][0])
		}
		return LifePoints
	}
	
	func gameExtraUpdate (_ extra: [Int]) {
		self.extraChance = extra[0]
		self.extraPoints = extra[1]
	}
	
	func careModeUpdate() {
		self.careMode = !self.careMode
	}
	
	func turnModeUpdate() {
		self.turnMode = !self.turnMode
	}
	
	func gamePointsUpdate(_ indexP: Int, _ gPoints: Int, _ gAllocations: [Int]) {
		self.gPoints[indexP]	= gPoints
		for index in 0...2 {
			self.allocations[index][indexP] = gAllocations[index]
		}
	}
}

