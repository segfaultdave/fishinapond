/*
 * a musician is implemented via a KStar ML algorithm
 * learns the music, and whether it is good or bad
 *
 * music is defined as int[] array. Each element is an index
 * in AudioPlayer[] notes_audio
 */
class Musician
{
	WekaData musicData;				// Instances data
	WekaClassifier musicClassifier;	// Classifier
	int[] currentMusic;				// music we have stored
	int currentMusicIndex;			// for looping through currentMusic

	Musician()
	{
		Object[] classes = {0,1};

		musicData = new WekaData(); //Initialize a WekaData with empty attributes and dataset

		// play music that is music_length long
		for(int i = 0; i < music_length; i++)
		{
			musicData.AddAttribute("note"+i);
		}

		musicData.AddAttribute("class",classes); //Add class attribute

		// use KStar algorithm
		musicClassifier = new WekaClassifier(WekaClassifier.KSTAR);
		musicClassifier.myClassifier = new ADTree();
		
		currentMusic = new int[music_length];
		currentMusicIndex = 0;
	}

	/**
	 * Set music note one at a time
	 */
	boolean setcurrentMusicNote(int note)
	{
		if(currentMusicIndex >= currentMusic.length)
			return false;

		currentMusic[currentMusicIndex] = note;
		return true;
	}

	/**
	 * returns true if we went through currentMusic completely
	 */
	boolean isDonePlaying()
	{
		return (currentMusicIndex == currentMusic.length);
	}

	/**
	 * returns the index of the note we are playing
	 */
	int currentMusicIndex()
	{
		return currentMusicIndex;
	}

	/**
	 * after playing a note, this goes to next note
	 */
	void increaseCurrentMusicIndex()
	{
		currentMusicIndex++;
	}

	/**
	 * so we can play currentMusic from the beginning
	 */
	void resetcurrentMusicIndex()
	{
		currentMusicIndex = 0;
	}

	/**
	 * set currentMusic to the one we are going to present
	 */
	void setCurrentMusic(int[] m)
	{
		currentMusic = m;
	}

	/**
	 * returns currentMusic so we can play it
	 */
	int[] getCurrentMusic()
	{
		return currentMusic;
	}

	/**
	 * given a new music, learn it to be good or bad
	 */
	void learnCurrentMusic(int judgement)
	{
		int[] pData = makePData(currentMusic, judgement);
		musicData.InsertData(pData);

		int instanceindex = musicData.myInstances.numInstances();
		println("==Learning the "+instanceindex+" instance");
		
		musicClassifier.Build(musicData);
	}

	/**
	 * given a music m, predict its rank
	 * and if it is good, we keep it
	 */
	int classify(int[] m)
	{
		int[] pData = makePData(m, 0);

		int pred = musicClassifier.Classify(pData);
		
		return pred;
	}

	/**
	 * given music m, convert it into something weka can work with
	 */
	int[] makePData(int[] m, int judgement)
	{
		int[] pData = new int[m.length + 1];
		for(int i = 0; i < m.length; i++)
		{
			pData[i] = m[i];
		}
		pData[m.length] = judgement;

		return pData;
	}
}