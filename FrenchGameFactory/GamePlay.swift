//
//  GamePlay.swift
//  FrenchGameFactory
//
//  Created by Pascal Diamand on 28/08/2020.
//  Copyright © 2020 Pascal Diamand. All rights reserved.
//

//┌────────────────────────────────────────────────────┐
//│                  Display Game Play                 │
//└────────────────────────────────────────────────────┘

func displayGamePlay()
{
	// As display is in monospaced font, all values must be formated in fixed lenght
	let space		= String(repeating: " ", count: 16)

	// Properties converted to fixed-length strings
	let t1Play		= (Team.current == 0 ? "▉▉▉▶ TEAM PLAYING ◀▉▉▉" : "                      ")
	let t2Play		= (Team.current == 1 ? "▉▉▉▶ TEAM PLAYING ◀▉▉▉" : "                      ")
	let t1Name		= String(String(teams[0].name + space).prefix(12))
	let t2Name		= String(String(teams[1].name + space).prefix(12))
	let t1Life		= String(String(String(teams[0].lifePoints) + space).prefix(3))
	let t2Life		= String(String(String(teams[1].lifePoints) + space).prefix(3))
	let round		= String(String(String(Round.current) + "  ").prefix(3))

	// Array of fixed lenght avatars's names + information for the current team
	let t1A 			= teams[0].teamAvatarsNWDCList()
	let t2A 			= teams[1].teamAvatarsNWDCList()

	// Array of avatars's life points remaining in fixed lenght
	let t1L			= teams[0].teamAvatarsLifeList()
	let t2L			= teams[1].teamAvatarsLifeList()

	screenRefresh()
	print()
	print("􀂒────────────────────────────────────────────────────────────────────────────────────────􀂒" )
	print("│ 􀂴uit  \(t1Play)    │ Round \(round)│ view 􀂪og │  \(t2Play)  􀂢elp │")
	print("􀂒────────────────────────────────────────────────────────────────────────────────────────􀂒")
	print("│ Team1: \(t1Name)                  \(t1Life) │ 􀝶 │ Team 2: \(t2Name)               \(t2Life)  │")
	print("􀂒────────────────────────────────────────────────────────────────────────────────────────􀂒")
	print("│ 􀂒 Avatars                          Lives │  │ 􀂒 Avatars                          Lives │")
	print("│ 􀃊 \(t1A[0]) │  \(t1L[0])  │  │ 􀃊 \(t2A[0]) │  \(t2L[0])  │")
	print("│ 􀃌 \(t1A[1]) │  \(t1L[1])  │  │ 􀃌 \(t2A[1]) │  \(t2L[1])  │")
	print("│ 􀃎 \(t1A[2]) │  \(t1L[2])  │  │ 􀃎 \(t2A[2]) │  \(t2L[2])  │")
	print("􀂒────────────────────────────────────────────────────────────────────────────────────────􀂒")
}

//┌────────────────────────────────────────────────────┐
//│                 Game Initialization                │
//└────────────────────────────────────────────────────┘

func newGameInit()
{
	// Teams Initialization
	teams[0].teamPointsInit(game)			// Team points and avatars points initialization
	teams[1].teamPointsInit(game)			// Idem
	
	// Game Initialization
	rounds						= [Round]()	// Clear rounds log
	Round.current				= 1			// Current round
	Avatar.playing				= 0			// Current avatar playing
	Team.current				= 0			// Current team playing
	teamTurn						= [0,0]		// Avatar to play for each team (dead avatars taken into account)
	teamHealth					= [9,9]		// Avatars' health number

	
}

//┌────────────────────────────────────────────────────┐
//│                      Game Play                     │
//└────────────────────────────────────────────────────┘

func gamePlay()
{
	// Main loop
	newGameInit()
	var status			=	true		// Flag for first while loop
	var visible			=	false		// Flag need to refresh the display
	var inputCount		=	0			// Number of runs required in the while loop to collect all data
	var context			=	0			// Defines the context to ask only the necessary question(s)
	while status {
		if teams[0].lifePoints == 0 || teams[1].lifePoints == 0 {
			break
		}
		if !visible {
			displayGamePlay()
			visible 		= true
		}
		let teamName		= teams[Team.current].name		// To be more readable
		let playContext	= inputContext()					// Init the context
		inputCount 			= playContext[0]
		context				= playContext[1]
		
		while inputCount != 3 {
			if inputCount == 0 {
				print("\nTeam \(teamName) to play: choose your avatar (\(keyDisplay[teamHealth[Team.current]])): ", terminator:"")
			} else if inputCount	== 1 {						// Need to choose action and opponent/fellow
				print("\nIt's up to the avatar \(teams[Team.current].avatars[Avatar.playing].nickName) from \(teamName) to play:")
				print("\nChoose your action key (􀂔/􀂘) and opponent (\(keyDisplay[teamHealth[(Team.current+1) % 2]])) or fellow (\(keyDisplay[teamHealth[Team.current]-(1+(2*Avatar.playing))])): ", terminator:"")
						// Need to subtract the playing avatar from the avatars available for care
			} else if inputCount == 2 && context == 1 {	// Just need to choose the opponent
				print("\nIt's up to the avatar \(teams[Team.current].avatars[Avatar.playing].nickName) from \(teamName) to play:")
				print("\nChoose the opponent to attack (\(keyDisplay[teamHealth[(Team.current+1) % 2]])): ", terminator:"")
			}else if inputCount == 4 {														// No input needed
				print("\nAvatar \(teams[Team.current].avatars[Avatar.playing].nickName) from \(teamName) can just attack the last opponent. Press any key to continue: ", terminator:"")
				gamePlay2()
				visible		= false
				break
			}
			
			let choiceNum = getKeyPress()
			if [1,2,3,97,99,104,108,113].contains(choiceNum) {
				switch choiceNum {
					case 1,2,3:		// Avatar choice
						if inputCount == 0  && keyGroup.contains(String(choiceNum-1)+String(teamHealth[Team.current])) {
							Avatar.playing 	= choiceNum - 1
							inputCount			+= 1
						} else if inputCount == 2 && keyGroup.contains(String(choiceNum-1)+String(teamHealth[Game.action == .attack ? (Team.current+1)%2 : Team.current])) {
							Avatar.receiving 	= choiceNum - 1
							inputCount	+= 1
							gamePlay2()
							visible		= false
						}
					case 97:			// Action Attack
						if inputCount == 1 {
							Game.action	= Actions.attack
							inputCount		+= 1
						}
					case 99:			// Action Care
						if inputCount == 1 {
							Game.action	= Actions.care
							inputCount 		+= 1
						}
					case 104:		// Help
						displayGamePlay()
						helps.helpDisplay(2)
					case 108:		// Display Log
						roundsLog()
						visible			= false
						inputCount		= 3
					case 113:		// Quit
							status		= false
							inputCount	= 3
					default:
						break
				}
			} else {					// Wrong input -> init loop of questions before asking again
				let playContext	= inputContext()
				inputCount 			= playContext[0]
				context				= playContext[1]
				
			}
		}
	}
	// Exit of the input loop -> game finished or canceled
	displayGamePlay()
	displayRoundsLog()
	gameEnd()
}

//┌────────────────────────────────────────────────────┐
//│                  Game Play Functions               │
//└────────────────────────────────────────────────────┘

func inputContext() -> [Int] {
	var playContext		= [game.turnMode == true ? 1 : 0,0]
	
	if [1,3,5].contains(teamHealth[Team.current]) {		// The current team has only one avatar left
		playContext[0]	=	2									// Choice of avatar and action are deducted
		playContext[1]	+=	1
		Avatar.playing 			=	teamHealth[Team.current] == 1 ? 0 : (teamHealth[Team.current] == 3 ? 1 : 2)
		Game.action		=	.attack
	}
	if [1,3,5].contains(teamHealth[(Team.current+1) % 2]) {	// The opponent team has only one avatar left
		playContext[1]		+=	3
	}
	if playContext[1] 	== 4 {							// Opponent is deducted too
		playContext[0]		=	4
		Avatar.receiving =	teamHealth[(Team.current+1)%2] == 1 ? 0 : (teamHealth[(Team.current+1)%2] == 3 ? 1 : 2)
	}
	return playContext
}


func gamePlay2()
	// Choice processing
{
	let team1 					= teams[Team.current]				// To be more readable
	let team2 					= Game.action == .care ? teams[(Team.current)] : teams[(Team.current+1) % 2]	// Idem
	let avatar1					= team1.avatars[Avatar.playing]		// Idem
	let avatar2					= team2.avatars[Avatar.receiving]		// Idem
	var extraAnswer			= -1									// -1: no offer, 0: No, 1: Yes
	var extraPoints			= 0									// Number of points to add or remove
	var engagedPoints			= 0									// Points engaged for the round
	if Game.action == .attack {
		let randomValue 		= Int.random(in:1...100)
		if randomValue <= game.extraChance {
			extraPoints			= game.extraPoints * (Int.random(in: 0...1) == 1 ? 1 : -1)
			var status 			= true
			while status {
				print("\n\nYou have an offer to change the power of your weapon. Do you accept it? (􀃄 or 􀂮): ", terminator:"")
				let choiceNum 	= getKeyPress()
				if [110,121].contains(choiceNum) {
					if choiceNum == 121 {			// Yes
						extraAnswer		= 1
						print("\n\(extraPoints>0 ? "Great!" : "Damn!") Your weapon has \(extraPoints>0 ? "gained" : "lost") \(extraPoints) points. It has now \(avatar1.aPoints[1]+extraPoints) points of destruction. Press any key to continue: ", terminator:"")
						let _	= getKeyPress()
					} else {
						extraAnswer	= 0
					}
					status = false
				}
			}
		}
		// Points to be deducted can't be more than opponent life points
		engagedPoints 	= 	min(avatar2.aPoints[0],avatar1.aPoints[1]+(extraAnswer == 1 ? extraPoints : 0))
		avatar2.avatarLifeUpdate(-engagedPoints)
		team2.teamLifeUpdate(-engagedPoints)
		if avatar2.aPoints[0] == 0 {
			teamHealth[(Team.current+1) % 2] -= 2 * Avatar.receiving + 1	// Deducts the prime number linked to the avatar
			print("\n\n\(String(repeating: "† ", count: 40))")
			print("\n\(avatar2.nickName) has no more life points: † R.I.P. †. Press any key to continue: ", terminator:"")
			let _						= getKeyPress()
		}
		if team2.lifePoints 		<= 0 {
			team2.lifePoints 		= 0
		}
	} else {	// Care
		if game.careMode {
			engagedPoints			= min(avatar1.aPoints[0],avatar1.aPoints[2] ) // Gained points can't be > donnor's life points
			avatar2.avatarLifeUpdate(engagedPoints)								// Avatar2 belongs to team1 too -> see above
			avatar1.avatarLifeUpdate(-engagedPoints)								//	Avatar's points decreases -> team's points equal
			if avatar1.aPoints[0] == 0 {
				teamHealth[Team.current]	-= 2 * Avatar.playing + 1						// Deducts the prime number linked to the avatar
				print("\n\n\(String(repeating: "† ", count: 40))")
				print("\n\(avatar1.nickName) has no more life points: † R.I.P.†. Press any key to continue: ", terminator:"")
				let _					= getKeyPress()
			}
		} else {
			avatar2.avatarLifeUpdate(engagedPoints)								// Avatar2 belongs to team1 too -> see above
			team1.teamLifeUpdate(engagedPoints)										// In this case team's life points increases
		}
	}
	// Recording of round data
	let avatarT1	= (Team.current == 0 ? Avatar.playing : Avatar.receiving)
	let avatarT2	= (Team.current == 1 ? Avatar.playing : Avatar.receiving)
	let t1Life		=	teams[0].lifePoints
	let t2Life		=	teams[1].lifePoints
	let t1ALife:	[Int]	= teams[0].teamAvatarsLife()
	let t2ALife:	[Int]	= teams[1].teamAvatarsLife()
	
	rounds.append(Round(Round.current, Team.current, avatarT1, avatarT2, Game.action, engagedPoints, extraPoints, extraAnswer, t1Life, t2Life, t1ALife, t2ALife))
	
	if teams[0].lifePoints != 0 && teams[1].lifePoints != 0 {
		// Initialization for the next round
		Round.current			+=	1							// Init for the next round
		Team.current			= (Team.current+1) % 2	// Swap current team
		if game.turnMode {									// Rotation mode
			if (Team.current == 0) {						// Again team1 -> need to change Avatars to play
				teamTurn[0] 			= (teamTurn[0] + 1) % 3		// Updates teamTurn for team1
				while !keyGroup.contains(String(teamTurn[0])+String(teamHealth[0])) {
					teamTurn[0] 		= (teamTurn[0] + 1) % 3
				}
				Avatar.playing = teamTurn[0]									// Update currentA1 with new teamTurn[0]
				teamTurn[1] 			= (teamTurn[1] + 1) % 3		// Updates teamTurn for team2
				while !keyGroup.contains(String(teamTurn[1])+String(teamHealth[1])) {
					teamTurn[1] 		= (teamTurn[1] + 1) % 3
				}
			} else {
				//The avatar to be played may have died during the previous turn.
				while !keyGroup.contains(String(teamTurn[Team.current])+String(teamHealth[Team.current])) {
					teamTurn[Team.current]	=	(teamTurn[Team.current] + 1) % 3
				}
				Avatar.playing = teamTurn[1]
			}
		}
	}
}

func gameEnd()
{
	// This function manages the endgame according to different situations
	let space		= String(repeating: " ", count: 80)	// lenght for formated strings
	var status	=	true		// Flag to exit the loop
	print("\n\(String(repeating: "• ", count: 46))")
	if teams[0].lifePoints != 0 && teams[1].lifePoints != 0 {	// None of the team lost -> game canceled
		print("\n\(String(space + "Game cancelled!").suffix(90))")
	} else {
		print("\n\(String(space + "Team " + teams[Team.current].name + " wins. Congratulations!").suffix(90))")
	}
	print("\n\(String(repeating: "• ", count: 46))\n")
	while status {
		print("\nPress the key of your choice: 􀂲lay a new game, change the game 􀂸ettings or 􀂴uit: ", terminator:"")
		let choiceNum = getKeyPress()
		if [112,113,115].contains(choiceNum) {
			switch choiceNum {
				case 112:		// New game
					functionLink	= "Play"
				case 115:		// Game setting
					functionLink	= "Setting"
				case 113:		// Quit
					functionLink	= ""
				default:
					break
			}
			status	= false
		}
	}
}

