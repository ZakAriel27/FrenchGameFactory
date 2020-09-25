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
	let space		= String(repeating: " ", count: 41)

	// Properties converted to fixed-length strings
	let t1Name		= Team.current == 0 ? String(String(space + "▉▉▉▶ TEAM \(teams[0].name) PLAYING ◀▉▉▉     ").suffix(41)) : String(String(Game.lastAction + space).prefix(41))
	let t2Name		= Team.current == 1 ? String(String("     ▉▉▉▶ TEAM \(teams[1].name) PLAYING ◀▉▉▉" + space).prefix(41)) : String(String(space +
		Game.lastAction).suffix(41))
	let round		= String(String(String(Round.current) + "  ").prefix(3))
	let infos		= Game.mode == 0 ? "􀂡ame 􀂸imulator" : "􀂠ame 􀂹imulator"
	let avatarList = teams[0].teamAvatarsNWDCList() + teams[1].teamAvatarsNWDCList() // Avatars description
	let lifeList	= teams[0].teamLifeList() + teams[1].teamLifeList()

	screenRefresh()
	print()
	print(" 􀂒────────────────────────────────────────────────────────────────────────────────────────􀂒" )
	print(" │ 􀂴uit    │ Round \(round)│          │ Mode: \(infos) │            │view 􀂪og│    􀂢elp │")
	print(" 􀂒────────────────────────────────────────────────────────────────────────────────────────􀂒")
	print(" │ \(t1Name) │􀝶│\(t2Name) │")
	print(" 􀂒────────────────────────────────────────────────────────────────────────────────────────􀂒")
	print(" │ 􀂒 Avatars                          Lives │  │ 􀂒 Avatars                          Lives │")
	print(" │ 􀃊 \(avatarList[0]) │  \(lifeList[0])  │  │ 􀃊 \(avatarList[3]) │  \(lifeList[3])  │")
	print(" │ 􀃌 \(avatarList[1]) │  \(lifeList[1])  │  │ 􀃌 \(avatarList[4]) │  \(lifeList[4])  │")
	print(" │ 􀃎 \(avatarList[2]) │  \(lifeList[2])  │  │ 􀃎 \(avatarList[5]) │  \(lifeList[5])  │")
	print(" 􀂒────────────────────────────────────────────────────────────────────────────────────────􀂒")
	if helpMode {
		helps.helpDisplay(2)
	}
}

//┌────────────────────────────────────────────────────┐
//│                 Game Initialization                │
//└────────────────────────────────────────────────────┘

func newGameInit()
{
	// Game Initialization
	Game.playable		= 0			//	Indicator to know if the game is still playable
	Game.lastAction	= String(repeating: " ", count: 40) // Contains the last action to inform players during the game
	rounds				= [Round]()	// Clear rounds log
	Round.current		= 1			// Current round
	Team.current		= 0			// Current team playing
	Team.player			= [2,2]		// Avatar to play for each team (dead avatars taken into account)
	Team.health			= [9,9]		// Avatars' health for each team (dead avatars taken into account)
	
	// Teams & rounds Initialization
	teams[0].teamPointsInit(game)			// Team points and avatars points initialization
	teams[1].teamPointsInit(game)			// Idem
	rounds.append(Round(0,-1,0,0,0,0,0,0,teams[0].teamLives(),teams[1].teamLives()))
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
		if Game.playable			<= 1 {				// The team can play
			if Avatar.playing		== -1 {				// Need to choose the avatar to play
				choiceAvatarPlaying()
				if Avatar.playing	== -1	{				// Input has been canceled
					Game.playable	= 5					// To manage the endgame
					break
				}
			}

			initAction()
			if Avatar.action		== -1 {				// Need to choose the action
				choiceAction()
				if Avatar.action	== -1 {				// Input has been canceled
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
		
		roundRecord()
		if Game.playable	<= 1 {						// Game can be continued
			Round.current	+=	1							// New round
			Team.current	= (Team.current+1) % 2	// Change team playing
			visible 			= false
		} else {
			break
		}
	}
	// Exit loop -> game finished
	displayGamePlay()
	displayRoundsLog()
	gameEnd()
}

//┌────────────────────────────────────────────────────┐
//│                  Game Play Functions               │
//└────────────────────────────────────────────────────┘

// This function analyzes the possibilities of choice for the playing avatar and records the answer if it can be deduced.
func initAvatarPlaying()
{
	Avatar.playing			= -1																	// Initialization to avoid a parasitic value
	Avatar.receiving		= -1																	// Idem
	Avatar.action			= -1																	// Idem
	Game.extraOffer		= 0
	Game.choiceOffer		= -1
	Game.message			= ""
	if [1,3,5].contains(Team.health[Team.current]) {									// The current team has only one avatar left -> no choice
		Avatar.playing		= Team.health[Team.current] == 1 ? 0 : (Team.health[Team.current] == 3 ? 1 : 2)
		if teams[Team.current].avatars[Avatar.playing].points[1] == 0 {			// This avatar heals only -> no possible action
			Avatar.action	= 0
			Avatar.receiving	= Avatar.playing
		} else {
			Avatar.action	= 1
		}
	} else if game.turnMode {																	// Rotation mode
		// Change the avatar who plays for the team with checking that he's still alive.
		Team.player[Team.current] 		= (Team.player[Team.current] + 1) % 3
		while !keyGroup.contains(String(Team.player[Team.current])+String(Team.health[Team.current])) {
			Team.player[Team.current] 	= (Team.player[Team.current] + 1) % 3
		}
		Avatar.playing = Team.player[Team.current]
		if teams[Team.current].avatars[Avatar.playing].points[1] == 0 {			// This avatar heals only -> only care action
			Avatar.action	=	2
		} else if teams[Team.current].avatars[Avatar.playing].points[2] == 0 {	// This avatar attacks only -> only attack action
			Avatar.action	=	1
		}
	}
}

// This function asks to choose the playing avatar and records the player's response.
func choiceAvatarPlaying()
{
	var status	=	true
	while status {
		print("\n Team \(teams[Team.current].name) plays: Press the key corresponding to the avatar to play (\(keyDisplay[Team.health[Team.current]])): ", terminator:"")
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
				case 104:			// Help
					helpMode	= !helpMode
					displayGamePlay()
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
						roundsLog()
						displayGamePlay()
				case 115:			// Simulator mode -> displays full details
					Game.mode		= 1
					displayGamePlay()
				default:				// Quit
						status		= gameCancel()
			}
		} else {
			print(" Wrong answer !")
		}
	}
}

func initAction()
{
	if Avatar.action == -1 {																		// Action has not yet been choosen
		if teams[Team.current].avatars[Avatar.playing].points[1] == 0 {				// This avatar heals only -> only care action
			Avatar.action	=	2
		} else if teams[Team.current].avatars[Avatar.playing].points[2] == 0 {	// This avatar attacks only -> only attack action
			Avatar.action	=	1
		}
	}
}

// This function asks to choose the action and records the player's response.
func choiceAction()
{
	var status	=	true
	while status {
		print("\n Avatar \(teams[Team.current].avatars[Avatar.playing].nickName) plays: Press the key corresponding to the action (􀂔/􀂘): ", terminator:"")
		let choiceNum = getKeyPress()
		if [97,99,103,104,105,108,113,115].contains(choiceNum) {
			switch choiceNum {
				case 97:				// Action Attack
					Avatar.action	= 1
					status			= false
				case 99:				// Action Care
					Avatar.action	= 2
					status			= false
				case 103:			// Game mode -> displays only information needed (game mode)
					Game.mode		= 0
					displayGamePlay()
				case 104:			// Help
					helpMode	= !helpMode
					displayGamePlay()
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
					roundsLog()
					displayGamePlay()
				case 115:			// Simulator mode -> displays full details
					Game.mode		= 1
					displayGamePlay()
				default:				// Quit
					status			= gameCancel()
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
		if Avatar.action == 1 {
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
		if Avatar.action 				== 1 {
			print("\n Avatar \(teams[Team.current].avatars[Avatar.playing].nickName) attacks: Press the key corresponding to his opponent (\(keyDisplay[Team.health[(Team.current+1) % 2]])): ", terminator:"")
		} else {
			let healthRemaining 		= (Team.health[Team.current]-(1+(2*Avatar.playing)))	// Avatars remaining coded in Team.health
			print("\n Avatar \(teams[Team.current].avatars[Avatar.playing].nickName) heals: Press the key corresponding to his fellow to be treated (\(keyDisplay[healthRemaining])): ", terminator:"")
		}
		let choiceNum = getKeyPress()
		if [1,2,3,103,104,105,108,113,115].contains(choiceNum) {
			switch choiceNum {
				case 1,2,3:			// Avatar choice
					if Avatar.action	== 1 {
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
					Game.mode		= 0
					displayGamePlay()
				case 104:			// Help
					helpMode	= !helpMode
					displayGamePlay()
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
					roundsLog()
					displayGamePlay()
				case 115:			// Simulator mode -> displays full details
					Game.mode		= 1
					displayGamePlay()
				default:				// Quit
					status			= gameCancel()
			}
		} else {
			print(" Wrong answer !")
		}
	}
}

// This function offers or not the possibility of extra points and records the player's answer.
func choiceExtra()
{
	if Avatar.action			== 1 {
		let randomValue 		= Int.random(in:1...100)
		if randomValue 		<= game.extraChance {
			Game.extraOffer	= Int.random(in: game.extraMin...game.extraMax) * (Int.random(in: 1...2) == 1 ? 1 : -1)
			if Game.extraOffer < 0 && -Game.extraOffer > teams[Team.current].avatars[Avatar.playing].points[1] {
				Game.extraOffer	= -teams[Team.current].avatars[Avatar.playing].points[1]	// Can't be less than damage points
			}
			var status 			= true
			while status {
				print("\n Avatar \(teams[Team.current].avatars[Avatar.playing].nickName): You have an offer to change the power of your weapon. Do you accept it? (􀃄 or 􀂮): ", terminator:"")
				let choiceNum 	= getKeyPress()
				if [110,121].contains(choiceNum) {
					if choiceNum == 121 {			// Yes
						Game.choiceOffer	= 1
						Game.message	= "\n \(Game.extraOffer > 0 ? "Great!" : "Damn!") Your weapon has \(Game.extraOffer > 0 ? "gained" : "lost") \(Game.extraOffer) points."
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
func roundRecord() {
	let team1 			= teams[Team.current]												// To be more readable
	let team2 			= Avatar.action == 0 || Avatar.action == 2 ? teams[(Team.current)] : teams[(Team.current+1) % 2]	// Idem
	let avatar1			= team1.avatars[Avatar.playing]									// Idem
	let avatar2			= team2.avatars[Avatar.receiving]								// Idem
	var engagedPoints	= 0																		// Points engaged for the round
	if Game.playable	<= 1 {
		Game.playable 	= 0																		//	An action reset playable
		if Avatar.action	== 1 {
			engagedPoints 	= 	avatar1.points[1] + (Game.extraOffer != 0 && Game.choiceOffer == 1 ? Game.extraOffer : 0)
			engagedPoints 	= 	min(avatar2.points[0],engagedPoints)					// Can't subtract more than the life points remaining
			avatar2.avatarLifeUpdate(-engagedPoints)
			if avatar2.points[0] == 0 {
				Avatar.action = 3
				Team.health[(Team.current+1) % 2] -= 2 * Avatar.receiving + 1		// Deducts the prime number linked to the avatar
				Game.message	+= "\n\n \(String(repeating: "† ", count: 40))\n \(avatar2.nickName) has no more life points: † R.I.P. †. "
			}
		} else if Avatar.action 	== 2 {	// Care
			if game.careCost > 0 {																// X care points given = Y life points deducted
				let engagePoints2		= min(avatar1.points[0],game.careCost)			// Points deducted can't be > donor's life points
				engagedPoints			= avatar1.points[2]
				avatar2.avatarLifeUpdate(engagedPoints)									// Avatar2 belongs to team1 too -> see above
				avatar1.avatarLifeUpdate(-engagePoints2)
				if avatar1.points[0] == 0 {
					Team.health[Team.current]	-= 2 * Avatar.playing + 1				// Deducts the prime number linked to the avatar
					Game.message	+= "\n\n \(String(repeating: "† ", count: 40))\n \(avatar1.nickName) has no more life points: † R.I.P.†."
				}
			} else {
				avatar2.avatarLifeUpdate(engagedPoints)									// Avatar2 belongs to team1 too -> see above
			}
		} else {
			Game.playable	= 1																	// No action means possible blocking next round
			Game.message	+= "\n Turn: \(Round.current) - Team \(teams[Team.current].name) must pass. It has no more avatars to attack."
		}
		// Recording round data
		rounds.append(Round(Round.current, Team.current, (Team.current == 0 ? Avatar.playing : Avatar.receiving), (Team.current == 1 ? Avatar.playing : Avatar.receiving), Avatar.action, engagedPoints, Game.extraOffer, Game.choiceOffer, teams[0].teamLives(), teams[1].teamLives()))

		Game.playable		= Team.health[0] == 0 ? 4 : (Team.health[1] == 0 ? 3 : Game.playable)	// Game.playable updated if one team has no more avatars
		Game.lastAction	= "-Last round \(avatar1.nickName) \(actions[0][Avatar.action]) \(avatar2.nickName !=  avatar1.nickName ? avatar2.nickName : "")-"
		if Game.message.count == 0 {
			Game.message	+= "\n \(avatar1.nickName) \(actions[0][Avatar.action]) \(avatar2.nickName !=  avatar1.nickName ? avatar2.nickName : "")"
		}
		print("\(Game.message) Press any key to end your turn: ", terminator:"")
		let _	= getKeyPress()
	}
}

// This function manages the endgame according to different situations
func gameEnd()
{
	let space	= String(repeating: " ", count: 80)	// lenght for formated strings
	var status	=	true										// Flag to exit the loop
	print("\n\(String(repeating: "• ", count: 46))")
	switch Game.playable {
		case 2:						//Both teams can't play
			print(" \(String(space + "Both teams have no more avatars to fight. Game cancelled !").suffix(90))")
		case 3,4:					// Team wins
			print(" \(String(space + "Team " + teams[Game.playable - 3].name + " wins. Congratulations!").suffix(90))")
		default:						// Game canceled
			print(" \(String(space + "Game cancelled!").suffix(90))")
	}
	print(" \(String(repeating: "• ", count: 46))\n")
	while status {
		print("\n Press the key of your choice: play 􀂔gain, 􀂸ettings or 􀂴uit: ", terminator:"")
		let choiceNum = getKeyPress()
		if [97,113,115].contains(choiceNum) {
			switch choiceNum {
				case 97:				// Play again
					functionLink	= .play
				case 115:			// Game setting
					functionLink	= .settings
				case 113:			// Quit
					functionLink	= .none
				default:
					break
			}
			status	= false
		}
	}
}

func gameCancel() -> Bool {
	let status 			= true
	while status {
		print("\n Are you shure to quit the game? (􀃄 or 􀂮): ", terminator:"")
		let choiceNum 		= getKeyPress()
		if [110,121].contains(choiceNum) {
			if choiceNum	== 121 {	// Yes
				return false
			} else {
				return true
			}
		} else {
			print(" Wrong answer !")
		}
	}
}
