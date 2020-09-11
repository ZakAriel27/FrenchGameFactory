//
//  RoundsLog.swift
//  FrenchGameFactory
//
//  Created by Pascal Diamand on 28/08/2020.
//  Copyright © 2020 Pascal Diamand. All rights reserved.
//

//┌────────────────────────────────────────────────────┐
//│                  Display Rounds Log                │
//└────────────────────────────────────────────────────┘

func displayRoundsLog()
{
	// As display is in monospaced font, all values must be formated in fixed lenght
	// Display
	print("􀂒────────────────────────────────────────────────────────────────────────────────────────􀂒")
	print("│ Rnd │A/C│Av.│     │Av.│ Pts │ Extra │ │ T.1   A.1   A.2   A.3 │ │ T.2   A.1   A.2   A.3 │")
	print("􀂒────────────────────────────────────────────────────────────────────────────────────────􀂒")
	for round in rounds {
		print(round.roundLine(1))	// Values for each round
	}
	print("􀂒────────────────────────────────────────────────────────────────────────────────────────􀂒")
	print()
	
}

//┌────────────────────────────────────────────────────┐
//│                      Rounds Log                    │
//└────────────────────────────────────────────────────┘

func roundsLog()
{
	displayGamePlay()				// Displays the table of current values
	displayRoundsLog()			// Display the log
	var status 			= true	// Flag to exit the loop
	while status {
		print("        If nessessary, scrool in you console.    Press 􀂴 to quit the log display : ", terminator:"")
		let choiceNum 	= getKeyPress()
		if choiceNum	== 113 {
			status		= false
		}
	}
}


	
