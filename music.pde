/**
 * keep generating music until the musician decides it is good
 * we then return the music and play it
 * music is defined as int[] array, which are the indices 
 * in AudioPlayer[] notes_audio
 */
int[] generateMusic()
{
	println("==Starting to generate music");
	print("==");

	int[] music = new int[music_length];
	int pred = 0;

	// keep looping until musician think it is good
	while(pred == 0)
	{
		// randomly generate a music
		for(int i = 0; i < music.length; i++)
		{
			music[i] = (int)random(1, 8);
		}

		// let musician decide whether the song is good
		if((musician.musicData.myInstances) != null)
			pred = musician.classify(music);
		else
			pred = 1;

		print(".");
	}

	// musician remember this music
	musician.setCurrentMusic(music);

	println("\n==Finished generating music");
	return music;
}


/**
 * play the nth note
 */
void playNote(int n)
{
	AudioPlayer note = notes_audio[n];
	if(!(note.isPlaying()))
	{
		note.rewind();
		note.play();
	}
	else 	// inefficiently deals with rewinding issue cutting off notes
	{
		AudioPlayer tempnote = minim.loadFile("notes/"+(n)+".mp3");
		tempnote.play();
	}
}

/**
 * musician plays the music out loud
 */
boolean musicianPlaysMusic()
{
	// finished playing song
	if(musician.isDonePlaying())
	{
		return true;
	}

	// 500ms delay until the next note can be played
	if( millis() - last_millis < 500.0)
		return false;

	// else we can play a new note
	last_millis = millis();

	// get the index of the note to be played
	int note_index = musician.getCurrentMusic()[musician.currentMusicIndex()];
	
	// play the note sound
	playNote(note_index);
	
	// play the pulse effect on star
	reflected_stars[note_index].playStar();

	// move the fish to play the note, reset its animation
	fish.updatePosition(reflected_stars[note_index].px, 
						reflected_stars[note_index].py);
	fish.resetAnimation();

	// prepare to play the next note
	musician.increaseCurrentMusicIndex();

	// not done playing yet
	return false;
}

/**
 * so we do not infinite loop when classifying
 */
void loadInitialMusic()
{
	int[] marylittlelamb = {5,4,3,4,5,
							5,5,4,4,4};
	musician.setCurrentMusic(marylittlelamb);
	musician.learnCurrentMusic(1);
}