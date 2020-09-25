//
//  Team.swift
//  FrenchGameFactory
//
//  Created by Pascal Diamand on 28/08/2020.
//  Copyright © 2020 Pascal Diamand. All rights reserved.
//

// The game plays with 2 teans wich are instanciated at program lauch with default values
class Team
{
	static var current	= 0				// Index of current team playing
	static var player		= [0,0]			// In rotation mode, allows to know the living avatar to play for each team
	static var health		= [9,9]			// Allows to quickly find out which avatars are alive for each team.
	
	var name: 				String			// Must be unique for the game
	var avatars 			= [Avatar]()	// Array of team avatars
	var initialLives		= [Int]()		// Initial values of avatars lives
													
	init(_ name: String) {
		self.name 	= name
	}
	
	func teamNameUpdate(_ name: String) {
		self.name	=	name
	}
		
	// This method initialises a team with its 3 avatars
	func teamInit(_ aNames: [String],_ indexArmory: Int)
	{
		var indexW		= indexArmory
		for aName in aNames {						// Add avatars to the team
			self.avatars.append(Avatar(aName, indexW))
			indexW	= (indexW == weapons.weapon.count ? 0 : indexW + 1) // If end of list is reached -> indexW reset
		}
	}
	
	// This method initialises avatars's points (life, damage, care) for a new game
	func teamPointsInit(_ game: Game)
	{
		// Defines the random order of the points sets to be awarded
		var random					= [Int]()
		while random.count 		!= 3 {
			let randomValue 		= Int.random(in:0...2)
			if random.count 		== 0 {
				random.append(randomValue)
			} else if random[0]	!= randomValue {
				random.append(randomValue)
				random.append(3-random.reduce(0, +))
			}
		}
		// Allocates sets of points to team avatars -> Team1's Avatar1 may not have the same points set as Team2's Avatar1
		var initalLives		= [Int]()
		for index in 0..<random.count {
			self.avatars[index].avatarPointsInit(game.pointsShared[random[index]])
			initalLives.append(self.avatars[index].points[0])
		}
		self.initialLives	= initalLives
	}
	
	// This method provides an array of formatted strings for display : avatar's nickName + weapon
	func teamAvatarsNWList() -> [String]
	{
		let space			= String(repeating: " ", count: 12)
		var teamAvatarsNW	= [String]()
		for avatar in self.avatars {
			let part1 		= String(String(avatar.nickName + space).prefix(12)) + "      "
			let part2 		= String(String(weapons.weapon[avatar.weapon] + space).prefix(12))
				teamAvatarsNW.append(part1+part2)
		}
		return teamAvatarsNW
	}
	
	// This method provides an array of formatted strings for display : avatar's nickName + weapon + damage + care
	func teamAvatarsNWDCList() -> [String]
	{
		let space				= String(repeating: " ", count: 30)
		var teamAvatarsNWDC	= [String]()
		for avatar in self.avatars {
			switch Game.mode {
				case 0:
					teamAvatarsNWDC.append(String(String("\(avatar.nickName)/\(weapons.weapon[avatar.weapon])" + space).prefix(30)))
				case 10:	// Display only for a brief time for the current team
					if teams[Team.current] === self {
						teamAvatarsNWDC.append(String(String("\(avatar.nickName)/\(weapons.weapon[avatar.weapon])(-\(avatar.points[1])/+\(avatar.points[2]))" + space).prefix(30)))
					} else {
						teamAvatarsNWDC.append(String(String("\(avatar.nickName)/\(weapons.weapon[avatar.weapon])" + space).prefix(30)))
					}
				default:
					teamAvatarsNWDC.append(String(String("\(avatar.nickName)/\(weapons.weapon[avatar.weapon])(-\(avatar.points[1])/+\(avatar.points[2]))" + space).prefix(30)))
			}
		}
		return teamAvatarsNWDC
	}
	
	// This method provides the list of avatar's points (life, damage, care) and the sum for the team in an array
	func teamLives() -> [Int]
	{
		var teamLives	=	[Int]()
		for index in 0...2 {
			teamLives.append(self.avatars[index].points[0])
		}
		teamLives.append(teamLives.reduce(0, +))
		return teamLives
	}

	// This method provides an array of formatted strings for display: avatars & team's life points
	func teamLifeList(_ full: Bool = false) -> [String]
	{
		let space				= 	String(repeating: " ", count: 3)	// 3 is the lenght for theses formated strings
		var teamLifeList	=	[String]()
		var teamLife			= 0
		for index in 0...2 {
			if self.avatars[index].points[0] > 0 {
				switch Game.mode {
					case 0:		// Game
						// PointSplig allows to manage the indirection between the avatars and their reference point profile.
						let ratio	= Float(self.avatars[index].points[0]) / Float(self.initialLives[index])
						let text		= String(String(space + String(repeating: "", count: ratio <= 0.3334 ? 1 : (ratio <= 0.6667 ? 2 : 3))).suffix(3))
						teamLifeList.append(text)
					case 10:		// Display only for a brief time for the current team
						if teams[Team.current] === self {
							teamLifeList.append(String(String(space + String(self.avatars[index].points[0])).suffix(3)))
						} else {
							let ratio = Float(self.avatars[index].points[0]) / Float(self.initialLives[index])
							let text = String(String(space + String(repeating: "", count: ratio <= 0.3334 ? 1 : (ratio <= 0.6667 ? 2 : 3))).suffix(3))
							teamLifeList.append(text)
						}
					default:		// Simulator
						teamLifeList.append(String(String(space + String(self.avatars[index].points[0])).suffix(3)))
				}
				teamLife	+= self.avatars[index].points[0]
			} else {
				teamLifeList.append(" † ")
			}
		}
		full == true ?	teamLifeList.append(String(String(space + String(teamLife)).suffix(3))) : nilFunc()
		return teamLifeList
	}
	
	// This method checks that the new name doesn't already exist in both teams (teams & avatars name) and returns the index if found
	func nameDouble(_ name: String) -> (Int, Int)
	{
		for indexT in 0...1 {
			for indexA in 0...teams[indexT].avatars.count - 1 {
				if teams[indexT].avatars[indexA].nickName.uppercased() == name.uppercased() {
					return (indexT,indexA)
				}
			}
			if teams[indexT].name == name {
				return (indexT, 3)
			}
		}
		return (-1, -1)
	}
}


