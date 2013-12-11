void keyPressed()
{
    if(phase == 0)
    {
        if(key == '1')
        {
            player_voted = true;
            player_judgement = 4;
        }
        else if(key == '2')
        {
            player_voted = true;
            player_judgement = 1;
        }
    }

	if(phase == 3)	// only if voting
	{
		if(key == '9')	       // vote good
		{
			player_voted = true;
			player_judgement = 1;
		}
        else if(key == '0')    // vote bad
        {
            player_voted = true;
            player_judgement = 0;
        }
	}

    if(phase == 4)  // plays the piano
    {
        int n = 0;
        switch(key){
            case 'z':
                n = 1;
                break;
            case 'x':
                n = 2;
                break;
            case 'c':
                n = 3;
                break;
            case 'v':
                n = 4;
                break;
            case 'b':
                n = 5;
                break;
            case 'n':
                n = 6;
                break;
            case 'm':
                n = 7;
                break;
            default:
                break;
        }
        userPlaysNote(n);
    }

	if(key == 's')		// s saves the data
		saveMusicData();
	if(key == 'l')		// l loads the data
		loadMusicData();
}

/**
 * User plays the nth note, play the animation too
 */
void userPlaysNote(int n)
{
    // this prevents the user from spamming notes
    if(millis() - last_millis < 200.0)
            return;
    last_millis = millis();

    // record and play what the user played
    musician.setcurrentMusicNote(n);
    musician.increaseCurrentMusicIndex();
    playNote(n);
    
    // pulses the star visually
    stars[n].playStar();

}
/**
 * Saves musician.
 musicData.Instances to file so we keep progress
 */
void saveMusicData() {
    try {

        ObjectOutputStream oos = new ObjectOutputStream(
                    new FileOutputStream("D:/US_Computer/CMU/year_3_semester_1/60210/homeworks/final/final_project/data/music_data/musican_musicData.data"));
        
        oos.writeObject(musician.musicData.myInstances);
        oos.flush();
        oos.close();

        println("==Exporting data successful");

    } catch (Exception e){
    	println("==Exporting data failed");
    }
}

/**
 * attempt to load the progress so far
 * return whether successful or not
 */
boolean loadMusicData() {
	if(musician != null)
    try {
        
        ObjectInputStream ois = new ObjectInputStream(
                    new FileInputStream("D:/US_Computer/CMU/year_3_semester_1/60210/homeworks/final/final_project/data/music_data/musican_musicData.data"));
        
        musician.musicData.myInstances = (Instances) ois.readObject();
        musician.musicClassifier.Build(musician.musicData);

        ois.close();

        println("==Importing data successful");

        return true;

    } catch (Exception e){
    	println("==Importing data failed");
    }
    return false;
}
