//
//  Game.swift
//  FrenchGameFactory
//
//  Created by Pascal Diamand on 28/08/2020.
//  Copyright © 2020 Pascal Diamand. All rights reserved.
//

// This class contains the game settings with static var for global information during the game
class Game
{
	static var mode			= 0			// game, avatars life, avatars properties
	static var playable		= 0			// Playbable status (<2: yes, 2: no team can play, 3: Team1 wins, 4: Team2 wins, 5: canceled
	static var extraOffer 	= 0			// Points offered for the current turn
	static var choiceOffer	= 0			// Answer for the offer
	static var helpMode		= false		// Flag to show/hide help functions

	var pointsShared	= [[Int]]()			// [A][P] Points [P] allocations of Life, damage and care for team's avatars [A]
	var turnMode		= true				// Turn mode between avatars in a team rotation (true) or free (false).
	var careCost		= 0					// Number of Life points to be deducted from the donor for each care (0 = no cost)
	var extraChance 	= 40					// Percentage change of getting an extra offer
	var extraMin		= 10					// Minimum points offered
	var extraMax		= 25					// Maximum points offered

	init()
	{
		self.pointsShared.append([65,20,10])	// Generation of inferred values
		self.pointsShared.append([45,25,5])	// Idem
		self.pointsShared.append([85,15,0])	// Idem
	}

	// This method initializes 2 teams of 3 avatars to start playing right away
	func gameInit()
	{
		let tNames	= ["DWARVES", "ORCS"]
		let aNames	= ["Dwalin","Gimli","Bombur","Azog","Bolg","Golfimbul"]
		var tIndex	= 0
		for tName in tNames {
			teams.append(Team(tName))
			teams.last!.teamInit(Array(aNames[tIndex*3...tIndex*3+2]), tIndex*3)
			tIndex	+= 1
		}
	}
	
	// This method updates the points distribution for a defined type
	func gamePointsUpdate(_ indexP: Int, _ Allocation: [Int])
	{
		for index in 0...2 {
			self.pointsShared[index][indexP] = Allocation[index]
		}
	}
	
	// This method updates the extra parameters
	func gameExtraUpdate (_ extra: [Int])
	{
		self.extraChance	= extra[0]
		self.extraMin		= extra[1] < extra[2] ? extra[1] : extra[2]		// Invert input if necessary
		self.extraMax		= extra[1] >= extra[2] ? extra[1] : extra[2]		// Idem
	}
	
	func careCostUpdate(_ cost: Int)
	{
		self.careCost			= cost
	}
	
	func turnModeUpdate()
	{
		self.turnMode			= !self.turnMode
	}
		
	// This method provides an array of life points distribution for a team
	func gameLifePoints() -> [Int]
	{
		var lifePoints			= [Int]()
		var teamPoints			= 0
		for index in 0...2 {
			lifePoints.append(self.pointsShared[index][0])	// The 3 avatars
			teamPoints	+= self.pointsShared[index][0]
		}
		lifePoints.insert(teamPoints, at: 0)					// The team
		return lifePoints
	}
	
	//This method provides an array of formatted strings for display : game's parameters
	func gameSettingList() -> [String]
	{
		let space		= String(repeating: " ", count: 13)
		var teamParam	= [String]()
		var teamPoints	= 0
		for index in 0...2 {
			teamPoints	+= self.pointsShared[index][0]
			let part1 	= String(space + String(self.pointsShared[index][0])).suffix(3) + "  "
			let part2 	= String(space + String(self.pointsShared[index][1])).suffix(3) + "   "
			let part3 	= String(space + String(self.pointsShared[index][2])).suffix(2)
			teamParam.append(String(part1 + part2 + part3))
		}
		teamParam.append(String(String(space + String(self.extraChance) + "%").suffix(3)))
		teamParam.append(String(String(String(self.extraMin) + space).prefix(2)))
		teamParam.append(String(String(space + String(self.extraMax)).suffix(2)))
		teamParam.append((self.careCost > 0 ? "Care=-\(String(String(space + String(self.careCost)).suffix(2))) Life":"  Care free  "))
		teamParam.append((self.turnMode == true ? "Rotation     ":"Free         "))
		return teamParam
	}
}

