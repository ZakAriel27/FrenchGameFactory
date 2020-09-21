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
	// As displayed in monospaced font, all values must be formated in fixed lenght
	// Display
	print(" 􀂒────────────────────────────────────────────────────────────────────────────────────────􀂒")
	print(" │ Rnd │A/C│Av.│     │Av.│ Pts │ Extra │ │ T.1   A.1   A.2   A.3 │ │ T.2   A.1   A.2   A.3 │")
	print(" 􀂒────────────────────────────────────────────────────────────────────────────────────────􀂒")
	print(rounds[0].roundLine(0))
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
	print("        If nessessary, scrool in you console.    Press any key to return to the game: ", terminator:"")
	let _ 	= getKeyPress()
}


	
