//
//  ClassGame.swift
//  FrenchGameFactory
//
//  Created by Pascal Diamand on 28/08/2020.
//  Copyright © 2020 Pascal Diamand. All rights reserved.
//

class Game {
	// This class contains the game settings as well as the 2 teams containing 3 avatars.
	var gPoints			= [60,20,10]	//	Default points values for life, damage and care points for a single avatar
	var allocations	= [[Int]]()		// [A][P] Points [P] allocations of Life, damage and care for team's avatars [A]
	var turnMode		= true			// Turn mode between avatars in a team rotation (true) or free (false).
	var careMode		= true			// X care points given = X life points lost (true) or not life points lost
	var extraChance 	= 50				// Percentage change of getting an extra offer
	var extraPoints	= 20				// Number of points that can be added or deducted from the avatar's damage points
	
	init()
	{
		for _ in 0...2 {
			self.allocations.append(self.gPoints)	// Generation of inferred values
		}
	}
	
	func gameSettingList() -> [String]
	{
		// This function returns an array of formatted strings for the display of the game parameters.
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
		teamParam.append(String(String(space + String(self.extraChance) + "%").suffix(3)))
		teamParam.append(String(String(String(self.extraPoints) + "p" + space).prefix(3)))
		teamParam.append((self.careMode == true ? "+C/-Life":"+Care   "))
		teamParam.append((self.turnMode == true ? "Rotation":"Free    "))
		return teamParam
	}
	
	func gamePointsUpdate(_ indexP: Int, _ gPoints: Int, _ gAllocations: [Int])
	{
		// This function update life points for the team and each of the 3 avatars
		self.gPoints[indexP]	= gPoints
		for index in 0...2 {
			self.allocations[index][indexP] = gAllocations[index]
		}
	}
	
	func gameExtraUpdate (_ extra: [Int])
	{
		self.extraChance		= extra[0]
		self.extraPoints		= extra[1]
	}
	
	func careModeUpdate()
	{
		self.careMode			= !self.careMode
	}
	
	func turnModeUpdate()
	{
		self.turnMode			= !self.turnMode
	}
	
	func gameLifePoints() -> [Int]
	{
		// This function returns a table of life points for each avatar position and the team.
		var LifePoints			= [Int]()
		LifePoints.append(self.gPoints[0] * 3)					// For the team (0)
		for index in 0...2 {
			LifePoints.append(self.allocations[index][0])	// The 3 avatars (1, 2, 3)
		}
		return LifePoints
	}
}

