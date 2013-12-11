/**
 * load the music files so we can play them out loud
 */
void loadAudioFiles()
{
	minim = new Minim (this);
	notes_audio = new AudioPlayer[8];

	// load all the notes
	for(int i = 0; i < notes_audio.length; i++)
	{
		notes_audio[i] = minim.loadFile("notes/"+i+".mp3");
	}

	// load lake background noise
	lake_sound = minim.loadFile("lake.mp3");
}