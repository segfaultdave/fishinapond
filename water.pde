/**
 * For displaying the water background images
 * cannot use animation class because we need water to fade in and out
 */
class Water
{
	PImage water;
	int opacity;
	int opacity_direction;

	Water(PImage w, int o, int d)
	{
		water = w;
		opacity = o;
		opacity_direction = d;
	}

	/**
	 * updates opacity of sprite
	 */
	void update()
	{
		if(frameCount % 10 == 0)
		{
			if(opacity > 252 || opacity < 4)
				opacity_direction *= -1;
			opacity += opacity_direction * 10;
		}
	}

	void display()
	{
		tint(255, opacity);
  		image(water, 0, 0);
	}

}

void waterInit()
{
  waters = new Water[3];
  waters[0] = new Water(loadImage("water1.png"), 0, 1);
  waters[1] = new Water(loadImage("water2.png"), 153, 1);
  waters[2] = new Water(loadImage("water3.png"), 153, -1);
}