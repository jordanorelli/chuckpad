<<< "Defining TouchPad class." >>>;
public class TouchPad extends Instrument
{
	"TouchPad" => name;

	// <<< "TouchPad preconstructor start." >>>;
	// calculateToneStep(12);
	// <<< "TouchPad preconstructor end." >>>;

	// fun void unFocus()
	// {
	// 	false => inFocus;
	// 	for(0 => int i; i < out.size(); i++)
	// 		for(0 => int j; j < out[0].size(); j++)
	// 			if(out[i][j] != null)
	// 				0 => out[i][j].gain;
	// }

	// fun void setLowestFreq(int value)
	// {
	// 	value => lowestFreq;
	// 	calculateToneMap();
	// }

	fun void init()
	{
		[Colors.lightRed, Colors.red, Colors.lightOrange, Colors.orange,
			Colors.lightYellow, Colors.yellow, Colors.lightGreen, Colors.green]
			@=> int colors[];
		for(0 => int i; i < 8; i++)
		{
			addMode(i, "momentary", colors[i]);
		}
	}


	fun void addMode(int index, string modeName, int color)
	{
		modeFactory(modeName) @=> Mode mode;
		
		mode.init();
		color => mode.color;
		mode @=> modes[index];
		spork ~ device.listen(modes[index].press);

		me.yield();
	}

	fun Mode modeFactory(string modeName)
	{
		if (modeName == "momentary")
		{
			return new MomentaryTouchPad;
		}
		else
		{
			return new MomentaryTouchPad;
		}
	}

	//fun void addMode()
	//{


		/*
		for(0 => int i; i < 8; i++)
		{
			MomentaryTouchPad mode;
			mode.init();
			colors[i] => mode.color;
			mode @=> modes[i];
			spork ~ device.listen(modes[i].press);
		}
		*/

	//}


	// fun void gridReceive(MidiMsg m)
	// {
	// 	if(m.data1 != 144)
	// 		return;
	// 	else if (mToCol(m.data2) == 8) 
	// 	{
	// 	}
	// 	else
	// 	{
	// 		setNote(mToRow(m.data2), mToCol(m.data2), m.data3);
	// 		bounce(m);
	// 	}
	// }

	// fun void setNote(int row, int column, int velocity)
	// {
	// 	if (row < 0 || row > 7 || column < 0 || column > 7)
	// 	{
	// 		<<< "ERROR: out of bounds in setNote with input row:", row, " column:", column >>>;
	// 		return;
	// 	}
	// 	if(out[row][column] == null)
	// 	{
	// 		SinOsc o;
	// 		toneMap[row][column] => o.freq;
	// 		o => dac;
	// 		o @=> out[row][column];
	// 	}
	// 	velocity / 127.0 => out[row][column].gain;
	// }

	// fun void bounce(MidiMsg m)
	// {
	// 	padOut.send(m);
	// }
}
<<< "Done with TouchPad class definition." >>>;
