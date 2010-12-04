<<< "BEGIN\tLaunchpadController definition.", "" >>>;
public class LaunchpadController
{
	MidiOut padOut;
	int gridLights[8][8];
	int LPIlights[8];
	int modeLights[8];

	127 => static int maxVelocity;

	<<< "BEGIN\tLaunchpadController preconstructor.", "" >>>;
	<<< "END\tLaunchpadController preconstructor.", "" >>>;

	fun void init()
	{
		<<< "BEGIN\tLaunchpadController init()." >>>;
		Utils.setArray(gridLights, -1);
		Utils.setArray(LPIlights, -1);
		Utils.setArray(modeLights, -1);
		clearAll();
		<<< "END\tLaunchpadController init()." >>>;
	}

	fun void poo()
	{
		Utils.setArray(LPIlights, -1);
	}

	fun void setChannel(int value)
	{
		<<< "setChannel" >>>;
		//if(!padOut.open(value))
		//{
		//	<<< "ERROR: couldn't open channel", value, "for MIDI out." >>>;
		//	me.exit();
		//}
	}

	fun void clearAll()
	{
		for(0 => int col; col < 8; col++)
			for(0 => int row; row < 8; row++)
				setGridLight(col, row, 127);
	}

	fun void setGridLight(int col, int row, int vel)
	{
		if(col < 0 || col > gridLights.size())
		{
			<<< "ERROR\tcol out of range in setGridLight with input", col >>>;
			return;
		}

		if(row < 0 || row > gridLights[0].size())
		{
			<<< "ERROR\trow out of range in setGridLight with input", row >>>;
			return;
		}

		if(vel < 0 || vel > maxVelocity)
		{
			<<< "ERROR\tvel out of range in setGridLight with input", vel >>>;
			return;
		}

		if(gridLights[col][row] != vel)
		{
			MidiMsg m;
			144 => m.data1;
			pairToM(col, row) => m.data2;
			vel => m.data3;
			padOut.send(m);
			<<< "SEND\t", padOut, "\t", m.data1, "\t", m.data2, "\t", m.data3 >>>;
			vel => gridLights[col][row];
		}
	}

	fun static int pairToM(int col, int row)
	{
		if(row < 0 || row > 8 || col < 0 || col > 8 || (col == 8 && row == 8))
		{
			<<< "ERROR\tout of bounds in pairToM.  Input: row:", row, "col:", col >>>;
			return -1;
		}
		return 16 * (7 - row) + col;
	}

	fun static int mToCol(int midiNum)
	{
		if(midiNum < 0 || midiNum > 120)
		{
			<<< "ERROR\tout of bounds in mToCol.  Input:", midiNum >>>;
			return -1;
		}
		return midiNum % 16;
	}

	fun static int mToRow(int midiNum)
	{
		if(midiNum < 0 || midiNum > 120)
		{
			<<< "ERROR\tout of bounds in mToRow.  Input:", midiNum >>>;
			return -1;
		}
		return 7 - (midiNum / 16);
	}
}
<<< "END\tLaunchpadController definition.", "" >>>;
