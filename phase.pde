
/* phase variable
 * determines what we should be doing at the moment
 * 0 => waiting for user to decide generate or play
 		* finishes when user makes a choice
 		0 -> 1 if generate
 		0 -> 4 if play
 * 1 => generating music
 		* finishes when generateMusic returns
 		1 -> 2
 * 2 => play music
 		* finishes when song is done playing
 		2 -> 3
 * 3 => wait for user to judge and learn from it
 		* finishes when user makes a choice and call musician.learn
 		3 -> 0
 * 4 => player input music
 		* finishes with fish learning the song
 	 	4 -> 0
 */
void phaseDecision()
{
	switch(phase)
	{
		case 0:		// waits for response
			//TODO
			if(player_voted)
			{
				println("==User chose phase "+player_judgement);
				phase = player_judgement;
				player_voted = false;

				// update fish pose depending on what it is doing
				if(player_judgement == 1)
					fish.updateState(Fish.IDLE);
				else if(player_judgement == 4)
					fish.updateState(Fish.WATCH);
				fish.makeSplashSound();
			}
			break;
		case 1:		// generates music
			musician.setCurrentMusic(generateMusic());	// generate an acceptable music

			// set fish to play music
			fish.updateState(Fish.PLAY);

			// move to phase 2
			phase = 2;

			break;
		case 2:		// plays music
			boolean isdone = musicianPlaysMusic();
			if(isdone && millis() - fish.fish_last_millis > 1000.0)	// delay 1s before fish reset
			{
				println("==Finished playing music. Moving to phase 3");
				println("Waiting for user vote:");

				// put fish back, made a sound
				fish.resetPosition();
				fish.updateState(Fish.IDLE);
				fish.makeSplashSound();
				
				// reset so we can play music correctly next time
				musician.resetcurrentMusicIndex();

				// move to phase 3
				phase = 3;
			}
			break;
		case 3:		// waits for user judgement of generated music
			if(player_voted)
			{
				println("==User voted "+player_judgement+". Moving back to phase 0\n");

				// learn from player's vote
				player_voted = false;
				musician.learnCurrentMusic(player_judgement);

				// update fish to sad or happy depending on judgement
				if(player_judgement == 0)
					fish.updateState(Fish.SAD);
				else if(player_judgement == 1)
					fish.updateState(Fish.HAPPY);

				phase = 0;
			}
			break;
		case 4:		// user inputs music
			if(musician.isDonePlaying())
			{
				println("==User finished playing. User vote:");
				musician.resetcurrentMusicIndex();
				phase = 3;
				fish.updateState(Fish.IDLE);
			}
			break;
		default:
			break;
	}
}