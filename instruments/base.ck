<<< "BEGIN: Instrument definition." >>>;
public class Instrument 
{
	LPDriver @ device;
	string name;
	false => int inFocus;
	Press press;

	Mode @ modes[8];
	int selected;
	int prevSelected;

	"base" => name;

	fun string getName()
	{
		return name;
	}

	fun void focus()
	{
		<<< "focus\tinst\t", getName() >>>;
		true => inFocus;
		setModeLight();
		modes[selected].focus();
	}

	fun void unfocus()
	{
		false => inFocus;
	}

	fun void readPress(Press press)
	{
		reportReceive(press);
		if(press.col == 8)
		{
			if(press.vel == 127)
				selectMode(press.row);
		}
		else
			modes[selected].readPress(press);
	}

	fun void reportReceive(Press press)
	{
		<<< "receive\tinst\t", getName(), "\t", press.col, "\t", press.row, "\t", press.vel >>>;
	}

	fun void addMode()
	{
		for(0 => int i; i < 8; i++)
		{
			if(i % 2 == 0)
				new Toggle @=> modes[i];
			else
				new Momentary @=> modes[i];
			spork ~ device.listen(modes[i].press);
		}
		me.yield();
	}

	fun void selectMode(int index)
	{
		<<< "select\tmode\t", index, "\t", modes[index].getName() >>>;
		modes[prevSelected].unfocus();
		modes[index].focus();
		index => selected;
		setModeLight();
	}

	fun void setModeLight()
	{
		for(0 => int i; i < 8; i++)
		{
			if(i == selected)
			{
				Press.fill(8, i, 127, press);
				press.signal();
				me.yield();
			}
			else
			{
				Press.fill(8, i, 0, press);
				press.signal();
				me.yield();
			}
		}
	}

	fun void unselectMode(int index)
	{
	}


//  0.15::second => dur peekTime;

//  string name;
//  0 => int selected;
//  time peekStart;
//  int prevSelected;
//  -1 => static int bpm;
//  static dur whole;
//  static dur half;
//  static dur quarter;
//  static dur eighth;
//
//  -1 => int semitonesPerOctave;
//  110.0 => float lowestFreq;
//  false => int inFocus;
//  float toneStep;
//	MidiOut padOut;
//
//  <<< "BEGIN: " + getName() + " preconstructor." >>>;
//  if(bpm == -1)
//  	setBpm(120);
//  if(semitonesPerOctave == -1)
//  	setSemitonesPerOctave(12);
//  <<< "END: " + getName() + " preconstructor." >>>;
//
//  fun void receive(MidiMsg m)
//	{
//		if(m.data1 != 144)
//		{
//			<<< "ERROR:  Instrument received a Midi message it shouldn't have:", m.data1, m.data2, m.data3 >>>;
//			return;
//		}
//		else if (mToCol(m.data2) == 8)
//		{
//			<<< "Do something here, like switch modes." >>>;
//		}
//		else
//		{
//			<<< getName(), "hears MidiMsg:\t", m.data1, "\t", m.data2, "\t", m.data3, "\tRow:", mToRow(m.data2), "\tCol:", mToCol(m.data2) >>>;
//			gridReceive(m);
//		}
//	}
//
//	fun void gridReceive(MidiMsg m)
//	{
//
//	}
//
//	fun string getName()
//	{
//		if(name == null)
//			"Instrument_Base" => name;
//		return name;
//	}
//
//	fun void start()
//	{
//		<<< getName(), me, "start." >>>;
//	}
//
//	fun void focus()
//	{
//		true => inFocus;
//		clearGrid();
//		setOptionLight();
//	}
//
//	fun void unFocus()
//	{
//		false => inFocus;
//	}
//
//	fun void setOptionLight()
//	{
//		for(0 => int i; i < 8; i++)
//			if(selected == i)
//				setSquare(i, 8, 127);
//			else
//				setSquare(i, 8, 0);
//	}
//
//	fun void clearGrid()
//	{
//		MidiMsg m;
//		144 => m.data1;
//		0 => m.data3;
//		for(0 => int i; i < 64; i++)
//		{
//			numToM(i) => m.data2;
//			padOut.send(m);
//		}
//	}
//
//	/*
//	fun void setSquare(int row, int column, int velocity)
//	{
//		MidiMsg m;
//		144 => m.data1;
//		pairToM(row, column) => m.data2;
//		velocity => m.data3;
//		padOut.send(m);
//	}
//	*/
//
//	fun void setColumn(int column, int velocity)
//	{
//		for(0 => int row; row < 8; row++)
//			setSquare(row, column, velocity);
//	}
//
//	fun void setRow(int row, int velocity)
//	{
//		for(0 => int column; column < 8; column++)
//			setSquare(row, column, velocity);
//	}
//
//	fun static void setBpm(int value)
//	{
//		if(value < 1)
//		{
//			<<< "ERROR: Attempt to lower tempo below 1 bpm.  Input: ", value >>>;
//			return;
//		}
//		<<< "BPM", value >>>;
//		value => bpm;
//		4::minute / bpm @=> whole;
//		whole / 2 @=> half;
//		half / 2 @=> quarter;
//		quarter / 2 @=> eighth;
//	}
//
//	/*
//	fun static int numToM(int keyNum)
//	{
//		if(keyNum < 0 || keyNum > 63)
//		{
//			<<< "ERROR: out of bounds in numToM.  Input:", keyNum >>>;
//			return -1;
//		}
//		return 16 * (7 - (keyNum / 8)) + keyNum % 8;
//	}
//	*/
//
//	fun void setSemitonesPerOctave(int value)
//	{
//		if(value < 1)
//		{
//			<<< "ERROR: out of bounds in setSemitonesPerOctave with input: ", value >>>;
//			return;
//		}
//		Math.pow(2, 1.0/value) => toneStep;
//		value => semitonesPerOctave;
//	}
}
<<< "END: Instrument definition." >>>;
