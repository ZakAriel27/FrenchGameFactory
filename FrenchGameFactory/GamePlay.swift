//
//  GamePlay.swift
//  FrenchGameFactory
//
//  Created by Pascal Diamand on 28/08/2020.
//  Copyright © 2020 Pascal Diamand. All rights reserved.
//
import Foundation

//┌────────────────────────────────────────────────────┐
//│                  Display Game Play                 │
//└────────────────────────────────────────────────────┘

func displayGamePlay()
{
	// As displayed in monospaced font, all values must be formated in fixed lenght
	let space		= String(repeating: " ", count: 16)

	// Properties converted to fixed-length strings
	let t1Name		= Team.current == 0 ? String(String(space + "▉▉▉▶ TEAM \(teams[0].name) PLAYING ◀▉▉▉").suffix(39)) : String(repeating: " ", count: 39)
	let t2Name		= Team.current == 1 ? String(String("▉▉▉▶ TEAM \(teams[1].name) PLAYING ◀▉▉▉" + space).prefix(39)) : String(repeating: " ", count: 39)
	let round		= String(String(String(Round.current) + "  ").prefix(3))
	let infos		= Game.mode == 0 ? "􀂡ame 􀂸imulator" : "􀂠ame 􀂹imulator"
	// Array of fixed lenght avatars's names + information for the current team
	let t1A 			= teams[0].teamAvatarsNWDCList()
	let t2A 			= teams[1].teamAvatarsNWDCList()
	let t1L			= teams[0].teamAvatarsLifeList()
	let t2L			= teams[1].teamAvatarsLifeList()

	screenRefresh()
	print()
	print(" 􀂒────────────────────────────────────────────────────────────────────────────────────────􀂒" )
	print(" │ 􀂴uit    │ Round \(round)│          │ Mode: \(infos) │            │view 􀂪og│    􀂢elp │")
	print(" 􀂒────────────────────────────────────────────────────────────────────────────────────────􀂒")
	print(" │  \(t1Name)  │􀝶│  \(t2Name) │")
	print(" 􀂒────────────────────────────────────────────────────────────────────────────────────────􀂒")
	print(" │ 􀂒 Avatars                          Lives │  │ 􀂒 Avatars                          Lives │")
	print(" │ 􀃊 \(t1A[0]) │  \(t1L[0])  │  │ 􀃊 \(t2A[0]) │  \(t2L[0])  │")
	print(" │ 􀃌 \(t1A[1]) │  \(t1L[1])  │  │ 􀃌 \(t2A[1]) │  \(t2L[1])  │")
	print(" │ 􀃎 \(t1A[2]) │  \(t1L[2])  │  │ 􀃎 \(t2A[2]) │  \(t2L[2])  │")
	print(" 􀂒────────────────────────────────────────────────────────────────────────────────────────􀂒")
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
	Game.mode			= 0			//	Informations displayed during the game
	Game.playable		= 0			//	Indicator to know if the game is still playable
	rounds				= [Round]()	// Clear rounds log
	Round.current		= 1			// Current round
	Team.current		= 0			// Current team playing
	Team.player			= [2,2]		// Avatar to play for each team (dead avatars taken into account)
	Team.health			= [9,9]		// Avatars' health for each team (dead avatars taken into account)
}

//┌────────────────────────────────────────────────────┐
//│                      Game Play                     │
//└────────────────────────────────────────────────────┘

// Main loop of the game
func gamePlay()
{
	newGameInit()
	let status		=	true		// Flag for first while loop
	var visible		=	false		// Flag need to refresh the display
	while status {
		if !visible {
			displayGamePlay()
			visible 	= true
		}
		
		initAvatarPlaying()
		if Game.playable			== 0 {				// The team can play
			if Avatar.playing		== -1 {				// Need to choose the avatar to play
				choiceAvatarPlaying()
				if Avatar.playing	== -1	{				// Input has been canceled
					Game.playable	= 5					// To manage the endgame
					break
				}
			}
			displayAvatarPlaying()						// Display avatar who plays before asking one or more questions

			initAction()
			if Avatar.action		== .none {			// Need to choose the action
				choiceAction()
				if Avatar.action	== .none {			// Input has been canceled
					Game.playable	= 5					// To manage the endgame
					break
				}
			}
			
			initAvatarReceiving()
			if Avatar.receiving 		== -1 {			// Need to choose the opponent / fellow
				choiceAvatarReceiving()
				if Avatar.receiving	== -1 {			// Input has been canceled
					Game.playable		= 5				// To manage the endgame
					break
				}
			}
			choiceExtra()
		}
		
		gameRecord()
		if Game.playable	<= 1 {						// Game can be continued
			Round.current	+=	1							// New round
			Team.current	= (Team.current+1) % 2	// Change team playing
			visible 			= false
		} else {
			break
		}
	}
	// Exit loop -> game finished
	if rounds.count > 0 {
		displayGamePlay()
		displayRoundsLog()
	}
	gameEnd()
}

//┌────────────────────────────────────────────────────┐
//│                  Game Play Functions               │
//└────────────────────────────────────────────────────┘

// This function analyzes the possibilities of choice for the playing avatar and records the answer if it can be deduced.
func initAvatarPlaying()
{
	Avatar.playing			= -1									// Initialization to avoid a parasitic value
	Avatar.receiving		= -1									// Idem
	Avatar.action			= .none								// Idem
	if [1,3,5].contains(Team.health[Team.current]) {	// The current team has only one avatar left -> no choice
		Avatar.playing = Team.health[Team.current] == 1 ? 0 : (Team.health[Team.current] == 3 ? 1 : 2)
		if teams[Team.current].avatars[Avatar.playing].points[1] == 0 {	// This avatar heals only -> no possible action
			Game.playable	+= 1									// The avatar can't play. The team must let its turn pass
		} else {
			Avatar.action	= .attack
			Game.playable	= 0
		}
	} else if game.turnMode {									// Rotation mode
		// Change the avatar who plays for the team with checking that he's still alive.
		Team.player[Team.current] 		= (Team.player[Team.current] + 1) % 3
		while !keyGroup.contains(String(Team.player[Team.current])+String(Team.health[Team.current])) {
			Team.player[Team.current] 	= (Team.player[Team.current] + 1) % 3
		}
		Avatar.playing = Team.player[Team.current]
		if teams[Team.current].avatars[Avatar.playing].points[1] == 0 {			// This avatar heals only -> only care action
			Avatar.action	=	.care
		} else if teams[Team.current].avatars[Avatar.playing].points[2] == 0 {	// This avatar attacks only -> only attack action
			Avatar.action	=	.attack
		}
	}
}

// This function asks to choose the playing avatar and records the player's response.
func choiceAvatarPlaying()
{
	var status	=	true
	while status {
		print("\n Team \(teams[Team.current].name) to play: Press the key corresponding to the avatar to play (\(keyDisplay[Team.health[Team.current]])): ", terminator:"")
		let choiceNum = getKeyPress()
		print(choiceNum)
		if [1,2,3,103,104,105,108,113,115].contains(choiceNum) {
			switch choiceNum {
				case 1,2,3:		// Avatar choice
					if keyGroup.contains(String(choiceNum-1)+String(Team.health[Team.current])) {
						Avatar.playing 	= choiceNum - 1
						status = false
					} else {
						print(" Wrong answer !")
					}
				case 103:			// Game mode -> displays only information needed (game mode)
					Game.mode 		= 0
					displayGamePlay()
					displayAvatarPlaying()
				case 104:			// Help
					displayGamePlay()
					Game.helpMode	= !Game.helpMode
					if Game.helpMode {
						helps.helpDisplay(2)
					}
				case 105:			// Information from current team
					if Game.mode	== 0 {
						Game.mode	+= 10
						displayGamePlay()
						do { sleep(5) }
						Game.mode	-= 10
						displayGamePlay()
					} else {
						print(" You already have all the information !")
					}
				case 108:			// Display Log
					if rounds.count != 0 {
						roundsLog()
						displayGamePlay()
					} else {
						print(" There's no round for the moment!")
					}
				case 115:			// Simulator mode -> displays full details
					Game.mode = 1
					displayGamePlay()
					displayAvatarPlaying()
				default:
					if choiceNum == 113 {
						print(" Input canceled !")
						status	= false
					}
			}
		} else {
			print(" Wrong answer !")
		}
	}
}

// This function simply displays the playing avatar before asking one or more questions.
func displayAvatarPlaying()
{
	print("\n It's up to the avatar \(teams[Team.current].avatars[Avatar.playing].nickName) from \(teams[Team.current].name) to play:")
}

// This function analyzes the possibilities of choice for the action and records the answer if it can be deduced.
func initAction()
{
	if Avatar.action == .none {																// Action has not yet been choosen
		if teams[Team.current].avatars[Avatar.playing].points[1] == 0 {			// This avatar heals only -> only care action
			Avatar.action	=	.care
		} else if teams[Team.current].avatars[Avatar.playing].points[2] == 0 {	// This avatar attacks only -> only attack action
			Avatar.action	=	.attack
		}
	}
}

// This function asks to choose the action and records the player's response.
func choiceAction()
{
	var status	=	true
	while status {
		print("\n Press the key corresponding to your action (􀂔/􀂘): ", terminator:"")
		let choiceNum = getKeyPress()
		if [97,99,103,104,105,108,113,115].contains(choiceNum) {
			switch choiceNum {
				case 97:				// Action Attack
					Avatar.action	= Actions.attack
					status			= false
				case 99:				// Action Care
					Avatar.action	= Actions.care
					status			= false
				case 103:			// Game mode -> displays only information needed (game mode)
					Game.mode		= 0
					displayGamePlay()
					displayAvatarPlaying()
				case 104:			// Help
					displayGamePlay()
					Game.helpMode	= !Game.helpMode
					if Game.helpMode {
						helps.helpDisplay(2)
					}
				case 105:			// Information from current team
					if Game.mode	== 0 {
						Game.mode	+= 10
						displayGamePlay()
						do { sleep(5) }
						Game.mode	-= 10
						displayGamePlay()
					} else {
						print("\n You already have all the information !")
					}
				case 108:			// Display Log
					if rounds.count != 0 {
						roundsLog()
						displayGamePlay()
					} else {
						print(" There's no round for the moment!")
					}
				case 115:			// Simulator mode -> displays full details
					Game.mode		= 1
					displayGamePlay()
					displayAvatarPlaying()
				default:				// Input canceled
					print(" Input canceled !")
					status			= false
			}
		} else {
			print(" Wrong answer !")
		}
	}
}

// This function analyzes the possibilities of choice for the receiving avatar and records the answer if it can be deduced.
func initAvatarReceiving()
{
	if Avatar.receiving == -1 {
		if Avatar.action == .attack {
			if [1,3,5].contains(Team.health[(Team.current+1) % 2]) {	// The opponent team has only one avatar left -> no choice
				Avatar.receiving = Team.health[(Team.current+1) % 2] == 1 ? 0 : (Team.health[(Team.current+1) % 2] == 3 ? 1 : 2)
			}
		} else {	// Action care -> test if current team has only 2 avatars included the one who's playing -> no choice
			if !(["09","19","29"].contains(String(Team.player[Team.current])+String(Team.health[Team.current]))) {
				let healthRemaining = (Team.health[Team.current]-(1+(2*Avatar.playing)))		// Avatars remaining coded in Team.health
				Avatar.receiving = healthRemaining == 1 ? 0 : (healthRemaining == 3 ? 1 : 2)	// And decoded in avatar index
			}
		}
	}
}

// This function asks to choose the receiving avatar and records the player's response.
func choiceAvatarReceiving()
{
	var status							=	true
	while status {
		if Avatar.action 				== .attack {
			print("\n Press the key corresponding to the opponent to attack (\(keyDisplay[Team.health[(Team.current+1) % 2]])): ", terminator:"")
		} else {
			let healthRemaining 		= (Team.health[Team.current]-(1+(2*Avatar.playing)))	// Avatars remaining coded in Team.health
			print("\n Press the key corresponding to the fellow to heal (\(keyDisplay[healthRemaining])): ", terminator:"")
		}
		let choiceNum = getKeyPress()
		if [1,2,3,103,104,105,108,113,115].contains(choiceNum) {
			switch choiceNum {
				case 1,2,3:			// Avatar choice
					if Avatar.action	== .attack {
						if keyGroup.contains(String(choiceNum-1)+String(Team.health[(Team.current+1) % 2])) {
							Avatar.receiving 	= choiceNum - 1
							status		= false
						} else {
							print(" Wrong answer !")
						}
					} else {			// Care choice
						if choiceNum - 1 != Avatar.playing  {
							Avatar.receiving 	= choiceNum - 1
							status 		= false
						} else {
							print(" Wrong answer !")
						}
					}
				case 103:			// Game mode -> displays only information needed (game mode)
					Game.mode			= 0
					displayGamePlay()
					displayAvatarPlaying()
				case 104:			// Help
					displayGamePlay()
					Game.helpMode	= !Game.helpMode
					if Game.helpMode {
						helps.helpDisplay(2)
					}
				case 105:			// Information from current team
					if Game.mode		== 0 {
						Game.mode		+= 10
						displayGamePlay()
						do { sleep(5) }
						Game.mode		-= 10
						displayGamePlay()
					} else {
						print("\n You already have all the information !")
					}
				case 108:			// Display Log
					if rounds.count 	!= 0 {
						roundsLog()
						displayGamePlay()
					} else {
						print(" There's no round for the moment!")
					}
				case 115:			// Simulator mode -> displays full details
					Game.mode			= 1
					displayGamePlay()
					displayAvatarPlaying()
				default:
					if choiceNum		== 113 {
						print(" Input canceled !")
						status			= false
					}
			}
		} else {
			print(" Wrong answer !")
		}
	}
}

// This function offers or not the possibility of extra points and records the player's answer.
func choiceExtra()
{
	Game.extraOffer			= 0
	Game.choiceOffer			= -1
	if Avatar.action			== .attack {
		let randomValue 		= Int.random(in:1...100)
		if randomValue 		<= game.extraChance {
			Game.extraOffer	= Int.random(in: game.extraMin...game.extraMax) * (Int.random(in: 1...2) == 1 ? 1 : -1)
			if Game.extraOffer < 0 && -Game.extraOffer > teams[Team.current].avatars[Avatar.playing].points[1] {
				Game.extraOffer	= -teams[Team.current].avatars[Avatar.playing].points[1]	// Can't be less than damage points
			}
			var status 			= true
			while status {
				print("\n You have an offer to change the power of your weapon. Do you accept it? (􀃄 or 􀂮): ", terminator:"")
				let choiceNum 	= getKeyPress()
				if [110,121].contains(choiceNum) {
					if choiceNum == 121 {			// Yes
						Game.choiceOffer	= 1
						print("\n \(Game.extraOffer > 0 ? "Great!" : "Damn!") Your weapon has \(Game.extraOffer > 0 ? "gained" : "lost") \(Game.extraOffer) points.")
					} else {
						Game.choiceOffer	= 0
					}
					status = false
				} else {
					print(" Wrong answer !")
				}
			}
		}
	}
}

// This function calculates the points to be added or subtracted, saves the turn and updates the playable value if necessary.
func gameRecord() {
	var engagedPoints		= 0	// Points engaged for the round
	if Game.playable		== 0 {
		print("\n Turn: \(Round.current) - \(teams[Team.current].avatars[Avatar.playing].nickName) from \(teams[Team.current].name) \(Avatar.action.rawValue) \(teams[(Team.current + 1) % 2].avatars[Avatar.receiving].nickName).", terminator:"")
		let team1 			= teams[Team.current]					// To be more readable
		let team2 			= Avatar.action == .care ? teams[(Team.current)] : teams[(Team.current+1) % 2]	// Idem
		let avatar1			= team1.avatars[Avatar.playing]		// Idem
		let avatar2			= team2.avatars[Avatar.receiving]	// Idem
		if Avatar.action	== .attack {	// P
			engagedPoints 	= 	avatar1.points[1] + (Game.extraOffer != 0 && Game.choiceOffer == 1 ? Game.extraOffer : 0)
			engagedPoints 	= 	min(avatar2.points[0],engagedPoints)	// Can't subtract more than the life points remaining
			avatar2.avatarLifeUpdate(-engagedPoints)
			team2.teamLifeUpdate(-engagedPoints)
			if avatar2.points[0] == 0 {
				Team.health[(Team.current+1) % 2] -= 2 * Avatar.receiving + 1		// Deducts the prime number linked to the avatar
				print("\n\n \(String(repeating: "† ", count: 40))")
				print("\n \(avatar2.nickName) has no more life points: † R.I.P. †.", terminator:"")
			}
		} else {	// Care.
			if game.careCost > 0 {																// X care points given = X life points deducted
				engagedPoints			= min(avatar1.points[0],game.careCost) 		// Gained points can't be > donor's life points
				avatar2.avatarLifeUpdate(engagedPoints)									// Avatar2 belongs to team1 too -> see above
				avatar1.avatarLifeUpdate(-engagedPoints)									//	Avatar's points decreases -> team's points equal
				if avatar1.points[0] == 0 {
					Team.health[Team.current]	-= 2 * Avatar.playing + 1				// Deducts the prime number linked to the avatar
					print("\n\n \(String(repeating: "† ", count: 40))")
					print("\n \(avatar1.nickName) has no more life points: † R.I.P.†.", terminator:"")
				}
			} else {
				avatar2.avatarLifeUpdate(engagedPoints)									// Avatar2 belongs to team1 too -> see above
				team1.teamLifeUpdate(engagedPoints)											// In this case team's life points increases
			}
		}
	} else {
		print("\n Turn: \(Round.current) - Team \(teams[Team.current].name) must pass its turn because it has no more avatars with the ability to attack.", terminator:"")
	}
	print(" -> Press any key to continue: ", terminator:"")
	let _	= getKeyPress()
	// Recording round data
	let avatarT1			= (Team.current == 0 ? Avatar.playing : Avatar.receiving)
	let avatarT2			= (Team.current == 1 ? Avatar.playing : Avatar.receiving)
	let t1Life				= teams[0].lifePoints
	let t2Life				= teams[1].lifePoints
	let t1ALife: [Int]	= teams[0].teamAvatarsLife()
	let t2ALife: [Int]	= teams[1].teamAvatarsLife()

	rounds.append(Round(Round.current, Team.current, avatarT1, avatarT2, Avatar.action, engagedPoints, Game.extraOffer, Game.choiceOffer, t1Life, t2Life, t1ALife, t2ALife))

	// Game.playable updated if nessesary
	if teams[1].lifePoints			== 0 {
		Game.playable					= 3
	} else if teams[0].lifePoints	== 0 {
		Game.playable					= 4
	}
}

// This function manages the endgame according to different situations
func gameEnd()
{
	let space	= String(repeating: " ", count: 80)	// lenght for formated strings
	var status	=	true										// Flag to exit the loop
	print("\n\(String(repeating: "• ", count: 46))")
	switch Game.playable {
		case 2:		//Both teams can't play
			print("\n \(String(space + "Both teams have no more avatars to fight. Game cancelled !").suffix(90))")
		case 3,4:	// Team2 wins
			print("\n \(String(space + "Team " + teams[Game.playable - 3].name + " wins. Congratulations!").suffix(90))")
		default:		// Game canceled
			print("\n \(String(space + "Game cancelled!").suffix(90))")
	}
	print("\n \(String(repeating: "• ", count: 46))\n")
	while status {
		print("\n Press the key of your choice: 􀂲lay a new game, change the game 􀂸ettings or 􀂴uit: ", terminator:"")
		let choiceNum = getKeyPress()
		if [112,113,115].contains(choiceNum) {
			switch choiceNum {
				case 112:		// New game
					functionLink	= .play
				case 115:		// Game setting
					functionLink	= .settings
				case 113:		// Quit
					functionLink	= .none
				default:
					break
			}
			status	= false
		}
	}
}

