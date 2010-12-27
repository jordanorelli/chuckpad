public class WubWub extends Instrument
{
	"wubwub" => name;

	fun void init()
	{
		[Colors.lightRed, Colors.red, Colors.lightOrange, Colors.orange,
			Colors.lightYellow, Colors.yellow, Colors.lightGreen, Colors.green]
			@=> int colors[];

		for(0 => int i; i < colors.size(); i++)
		{
			WubWubMain mode;
			mode.init();
			colors[i] => mode.color;
			mode @=> modes[i];
			spork ~ device.listen(modes[i].press);
		}

		me.yield();
	}


	fun void focus()
	{
		<<< "focus\tinst\t", getName() >>>;
		true => inFocus;
		//setModeLight();
		//modes[selected].focus();
	}
}
