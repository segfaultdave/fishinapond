/**
 * star, with position.
 * can make pulse of sphere wave thing
 */
class Star
{
	int px, py;
	color play_color;
	int progress;
	int pulse_opacity;
	final int max_pulse_opacity = 200;
	int star_opacity;
	int max_star_opacity;
	int star_opacity_direction;

	Star(int x, int y, color c)
	{
		px = x;
		py = y;
		play_color = c;
		progress = 0;
		pulse_opacity = 0;

		// if in water
		if(py > height/2)
			max_star_opacity = 150;
		else
			max_star_opacity = 230;

		// random starting opacity and opacity changing direction
		star_opacity = (int)(random(max_star_opacity/2, max_star_opacity));
		star_opacity_direction = randONEorNEGATIVEONE();

	}

	/*
	 * Let us show visuals of the star
	 */
	void playStar()
	{
		pulse_opacity = max_pulse_opacity;
	}
	
	/**
	 * Update position and opacity of stars
	 */
	void update()
	{
		// reverse star shiningness
		if(star_opacity + star_opacity_direction < max_star_opacity/2 ||
		   star_opacity + star_opacity_direction > max_star_opacity)
			star_opacity_direction *= -1;
		star_opacity += star_opacity_direction;

		// if no pulse, don't even bother updating it
		if(pulse_opacity < 0)
			return;

		// decrease pulse power
		pulse_opacity -= 4;
	}

	/**
	 * Draw the star
	 */
	void display()
	{
		// draw the star
		stroke(255, star_opacity);
		strokeWeight(4);
		ellipse(px, py, 4, 4);

		// if no pulse, don't even bother drawing it
		if(pulse_opacity < 0)
			return;

		// make pulse size increase as opacity decrease
		int diameter = max_pulse_opacity + 10 - pulse_opacity;
		
		// draw the pulse
		for(int i = 0; i < 10; i++)
		{
			stroke(play_color, max(pulse_opacity - 25*i, 0));
			ellipse(px, py, max((diameter - 8*i)/2, 0), 
							max((diameter - 8*i)/2, 0));
		}
		
	}
}


/**
 * Hardcoded positions of the stars
 * because computers got nothin on me
 * in determining the position of stars
 */
void starsInit()
{
	stars = new Star[8];
	stars[0] = new Star(0,   0,   color(0,0,0));
	stars[1] = new Star(168, 148, color(13,34,161));
	stars[2] = new Star(271, 81,  color(92,157,218));
	stars[3] = new Star(421, 108, color(41,195,34));
	stars[4] = new Star(511, 192, color(233,239,82));
	stars[5] = new Star(616, 130, color(244,182,14));
	stars[6] = new Star(713, 204, color(239,45,30));
	stars[7] = new Star(805, 106, color(219,102,179));

	reflected_stars = new Star[8];
	reflected_stars[0] = new Star(0,   0,   color(0,0,0));
	reflected_stars[1] = new Star(162, 546, color(13,34,161));
	reflected_stars[2] = new Star(264, 611,  color(92,157,218));
	reflected_stars[3] = new Star(417, 581, color(41,195,34));
	reflected_stars[4] = new Star(504, 498, color(233,239,82));
	reflected_stars[5] = new Star(609, 565, color(244,182,14));
	reflected_stars[6] = new Star(710, 491, color(239,45,30));
	reflected_stars[7] = new Star(795, 586, color(219,102,179));

}