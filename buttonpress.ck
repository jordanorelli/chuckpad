<<< "Defining class ButtonPress." >>>;
public class ButtonPress extends Event
{
    int col;
    int row;
    int vel;

	fun static ButtonPress make(int col, int row, int vel)
	{
		ButtonPress buttonPress;
		col => buttonPress.col;
		row => buttonPress.row;
		vel => buttonPress.vel;
		return buttonPress;
	}

	fun static MidiMsg toM(ButtonPress orig)
	{
		MidiMsg m;
		if(orig.row == 8)
			176 => m.data1;
		else
			144 => m.data1;

		if(orig.col == 8)
			16 * orig.row + orig.col => m.data2;
		else
			16 * (7 - orig.row) + orig.col => m.data3;

		orig.vel => m.data3;
	}

	fun static ButtonPress fromM(MidiMsg orig)
	{
		ButtonPress buttonPress;
		if(orig.data1 == 176)
		{
			orig.data2 - 104 => buttonPress.col;
			8 => buttonPress.row;
		}
		else
		{
			orig.data2 % 16 => buttonPress.col;
			if(buttonPress.col == 8)
				orig.data2 / 16 => buttonPress.row;
			else
				7 - (orig.data2 / 16) => buttonPress.row;
		}
		orig.data3 => buttonPress.vel;
		return buttonPress;
	}
}
<<< "Finished with ButtonPress definition." >>>;
