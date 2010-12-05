<<< "Defining class SetLight." >>>;
public class SetLight extends Event
{
    int col;
    int row;
    int vel;

	fun static SetLight make(int col, int row, int vel)
	{
		SetLight setLight;
		col => setLight.col;
		row => setLight.row;
		vel => setLight.vel;
		return setLight;
	}

	fun static MidiMsg toM(SetLight orig)
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

	fun static SetLight fromM(MidiMsg orig)
	{
		SetLight setLight;
		if(orig.data1 == 176)
		{
			orig.data2 - 104 => setLight.col;
			8 => setLight.row;
		}
		else
		{
			orig.data2 % 16 => setLight.col;
			if(setLight.col == 8)
				orig.data2 / 16 => setLight.row;
			else
				7 - (orig.data2 / 16) => setLight.row;
		}
		orig.data3 => setLight.vel;
		return setLight;
	}
}
<<< "Finished with SetLight definition." >>>;
