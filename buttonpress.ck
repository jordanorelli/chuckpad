<<< "Defining class ButtonPress." >>>;
public class ButtonPress extends Event
{
    int col;
    int row;
    int vel;

	fun static ButtonPress make(int col, int row, int vel)
	{
		ButtonPress press;
		col => press.col;
		row => press.row;
		vel => press.vel;
		return press;
	}

	fun static MidiMsg toM(ButtonPress press)
	{
		MidiMsg m;
		if(press.row == 8)
			176 => m.data1;
		else
			144 => m.data1;

		if(press.col == 8)
			16 * press.row + press.col => m.data2;
		else
			16 * (7 - press.row) + press.col => m.data3;

		press.vel => m.data3;
	}

	fun static ButtonPress fromM(MidiMsg m)
	{
		ButtonPress press;
		if(m.data1 == 176)
		{
			m.data2 - 104 => press.col;
			8 => press.row;
		}
		else
		{
			m.data2 % 16 => press.col;
			if(press.col == 8)
				m.data2 / 16 => press.row;
			else
				7 - (m.data2 / 16) => press.row;
		}
		m.data3 => press.vel;
		return press;
	}

	fun static int rowFromM(MidiMsg m)
	{

	}
}
<<< "Finished with ButtonPress definition." >>>;
