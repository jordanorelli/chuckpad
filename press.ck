<<< "Defining class Press." >>>;
public class Press extends Event
{
    int col;
    int row;
    int vel;

	fun static Press make(int col, int row, int vel)
	{
		Press press;
		col => press.col;
		row => press.row;
		vel => press.vel;
		return press;
	}

	fun static MidiMsg toM(Press press)
	{
		MidiMsg m;
		if(press.row == 8)
			176 => m.data1;
		else
			144 => m.data1;

		if(press.row == 8)
			104 + press.col => m.data2;
		else if(press.col == 8)
			16 * press.row + press.col => m.data2;
		else
			16 * (7 - press.row) + press.col => m.data2;

		press.vel => m.data3;
		return m;
	}

	fun static MidiMsg toM(int col, int row, int vel)
	{
		return toM(make(col, row, vel));
	}

	fun static Press fromM(MidiMsg m)
	{
		Press press;
		colFromM(m) => press.col;
		rowFromM(m) => press.row;
		m.data3 => press.vel;
		return press;
	}

	fun static int rowFromM(MidiMsg m)
	{
		if(m.data1 == 176)
			return 8;

		if(m.data2 % 16 == 8)
			return m.data2 / 16;
		else
			return 7 - (m.data2 / 16);
	}

	fun static int colFromM(MidiMsg m)
	{
		if(m.data1 == 176)
			return m.data2 - 104;
		else
			return m.data2 % 16;
	}
}
<<< "Finished with Press definition." >>>;
