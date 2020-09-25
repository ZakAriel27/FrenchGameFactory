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
	print(" 􀂒──────────────────────────────────────────────────────􀂒")
	print(" │ 􀂴uit                  Main Menu                 􀂢elp │")
	print(" 􀂒──────────────────────────────────────────────────────􀂒")
	print(" │                    􀃊 􀄫 Introduction                  │")
	print(" │                    􀃌 􀄫 Settings                      │")
	print(" │                    􀃎 􀄫 Game                          │")
	print(" 􀂒──────────────────────────────────────────────────────􀂒")
	if helpMode {
		helps.helpDisplay(3)
	}
}

//┌────────────────────────────────────────────────────┐
//│                      mainMenu                      │
//└────────────────────────────────────────────────────┘

func mainMenu()
{
	var status		= true	// Flag to quit the loo
	var visible		= false	// Flag to refresh the display
	while status {
		while functionLink != .none {			// Manages redirection requests at the end of an action (settings or play)
			if functionLink == .play {
				gamePlay()
			} else if functionLink == .settings {
				gameSettings()
			}
		}
		if !visible {
			displayMainMenu()
			visible	= true
		}
		print("\n Press the key corresponding to your choice (􀃊 􀃌 􀃎 􀂢 􀂴): ", terminator:"")
		let choiceNum = getKeyPress()
		if [1,2,3,104,113].contains(choiceNum) {
			switch choiceNum {
				case 1: 				// Introduction
					introduction()
				case 2: 				// Setting
					gameSettings()
				case 3: 				// Game
					gamePlay()
				case 104: 			// Help
					helpMode	= !helpMode
				case 113: 			// Quit
					screenRefresh()
					print("\n See you soon to the French Game Factory!")
					print()
					status	= false
				default:
					break
			}
			visible 			= false
		} else {
			print()
		}
	}
}
