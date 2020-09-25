//
//  Round.swift
//  FrenchGameFactory
//
//  Created by Pascal Diamand on 28/08/2020.
//  Copyright © 2020 Pascal Diamand. All rights reserved.
//

// Each game consists of several rounds, which are stored in order to consult the progress during the game.
class Round
{
	static var current	= 0	// Current round
	
	let order:		Int			// Round order
	let token:		Int			//	Token for the round = team playing
	let indexA1:	Int			// Avatar index (token == 0 ? playing : receiving)
	let indexA2:	Int			// Avatar index (token == 1 ? playing : receiving)
	let action:		Int			// Type of action during the round (0=pass, 1=attack, 2=care 3=kill)
	let points:		Int			// Number of damage or care points engaged during the round
	let xPoints:	Int			// Extra point (potitive or négative value) to add if extra choosen
	let xChoice:	Int			// Player choice if Extra offered during this round (-1= no offer, 0 = no, 1 = yes)
	let livesT1:	[Int]			// Array of remaining health points for avatars(0,1,2,) and team1(3) at the end of the round
	let livesT2:	[Int]			// Array of remaining health points for avatars(0,1,2,) and team2(3) at the end of the round
	
	init(_ order: Int, _ token: Int, _ indexA1: Int, _ indexA2: Int, _ action: Int, _ points: Int, _ xPoints: Int, _ xChoice: Int, _ livesT1: [Int], _ livesT2: [Int])
	{
		self.order		= order
		self.token		= token
		self.indexA1	= indexA1
		self.indexA2	= indexA2
		self.action		= action
		self.points		= points
		self.xPoints	= xPoints
		self.xChoice	= xChoice
		self.livesT1	= livesT1
		self.livesT2	= livesT2
	}
	

	// This method provides a formatted string for display : log for one turn, taking into account the game mode
	func roundLine() -> String
	{
		let livesList	= self.livesList()	// Lives information to display
		var roundInfo	= [String]()			// Round information to display
		if self.order	!= 0 {
			roundInfo.append(String(String("   " + String(self.order)).suffix(3)))
			roundInfo.append(actions[1][self.action])
			roundInfo.append("\(self.indexA1+1)")
			roundInfo.append(actions[self.token+2][self.action])
			roundInfo.append("\(self.indexA2+1)")
			roundInfo.append(String(String("   " + (Game.mode == 1 ? String(self.points) : "")).suffix(3)))
			roundInfo.append(self.xPoints == 0 ? "   " : String(String("   " + (Game.mode == 1 ? String(self.xPoints) : "")).suffix(3)))
			roundInfo.append(self.xChoice == 1 && Game.mode == 1 ? ":Y" : (self.xChoice == 0 && Game.mode == 2 ? ":N" : "  "))
		} else {
			roundInfo	= ["  0", " ", " ", "     ", " ", "   ", "   ", "  "]
		}
			
		return " │ \(roundInfo[0]) │ \(roundInfo[1]) │ \(roundInfo[2]) │\(roundInfo[3])│ \(roundInfo[4]) │ \(roundInfo[5]) │ \(roundInfo[6])\(roundInfo[7]) │ │ \(livesList[3])   \(livesList[0])   \(livesList[1])   \(livesList[2]) │ │ \(livesList[7])   \(livesList[4])   \(livesList[5])   \(livesList[6]) │"
	}
	
	// This method provides an array of formatted strings for display: rounds log
	func livesList() -> [String]
	{
		let space				= 	String(repeating: " ", count: 3)
		var roundLivesList	=	[String]()
		if (self.token == 1 && (self.action == 1 || self.action == 3)) || (self.token == 0 && (self.action == 0 || self.action == 2)) || (self.order == 0) {		// Fill Team1 side
			for index in (0...2) {
				if Game.mode	== 0 {
					let ratio	= Float(livesT1[index]) / Float(teams[0].initialLives[index])
					let text		= self.livesT1[index] > 0 ? (String(String(space + String(repeating: "", count: ratio <= 0.3334 ? 1 : (ratio <= 0.6667 ? 2 : 3))).suffix(3))) : " † "
					roundLivesList.append(text)
				} else {
					roundLivesList.append(self.livesT1[index] > 0 ? String(String(space + String(livesT1[index])).suffix(3)) : " † ")
				}
			}
			roundLivesList.append(String(String(space + String(livesT1[3])).suffix(3)))
			
			roundLivesList		=	self.order != 0 ? roundLivesList + ["   ", "   ", "   ", "   "] : roundLivesList		// Complete the list if not round 0
		}
		if !(self.token == 1 && (self.action == 1 || self.action == 3) || self.token == 0 && (self.action == 0 || self.action == 2)) || (self.order == 0) {	// Fill Team2 side
			roundLivesList		= self.order != 0 ? ["   ", "   ", "   ", "   "] : roundLivesList								// Start the list if not round 0
			for index in (0...2) {
				if Game.mode	== 0 {
					let ratio	= Float(livesT2[index]) / Float(teams[1].initialLives[index])
					let text		=  self.livesT2[index] > 0 ? (String(String(space + String(repeating: "", count: ratio <= 0.3334 ? 1 : (ratio <= 0.6667 ? 2 : 3))).suffix(3))) : " † "
					roundLivesList.append(text)
				} else {
					roundLivesList.append(self.livesT2[index] > 0 ? String(String(space + String(livesT2[index])).suffix(3)) : " † ")
				}
			}
			roundLivesList.append(String(String(space + String(livesT2[3])).suffix(3)))
		}
		return roundLivesList
	}
}




