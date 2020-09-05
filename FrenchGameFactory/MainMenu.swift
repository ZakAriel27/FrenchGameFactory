//
//  MainMenu.swift
//  FrenchGameFactory
//
//  Created by Pascal Diamand on 28/08/2020.
//  Copyright © 2020 Pascal Diamand. All rights reserved.
//

//┌────────────────────────────────────────────────────┐
//│                   mainMenu Display                 │
//└────────────────────────────────────────────────────┘

func displayMainMenu()
{
	// Display
	screenRefresh()
	print()
	print("􀂒────────────────────────────────────────􀂒")
	print("│ 􀂴uit            Main Menu         􀂢elp │")
	print("􀂒────────────────────────────────────────􀂒")
	print("│              􀃊 􀄫 Introduction          │")
	print("│              􀃌 􀄫 Game                  │")
	print("􀂒────────────────────────────────────────􀂒")
	print()
}

//┌────────────────────────────────────────────────────┐
//│                      mainMenu                      │
//└────────────────────────────────────────────────────┘

func mainMenu()
{
	var status = true
	var visible = false
	while status {
		if !visible {
			displayMainMenu()
			visible = true
		}
		print("Press the key corresponding to your choice (􀃊 􀃌 􀂢 􀂴): ", terminator:"")
		let choiceNum = getKeyPress()
		if [1,2,104,113].contains(choiceNum) {
			switch choiceNum {
				case 1: // Introduction
					introduction()
					visible = false
				case 2: // Game
					gameParameters()
					if functionLink == "Play" {
						gamePlay()
					}
					visible = false
				case 104: // Help
					helps.helpDisplay(3)
				case 113: // Quit
					screenRefresh()
					print("\nSee you soon to the French Game Factory!")
					print()
					status = false
				default:
					print("Seems we have a bug at mainMenu()")
			}
		} else {
			print()
		}
	}
}
