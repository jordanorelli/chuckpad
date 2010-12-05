<<< "BEGIN: Instrument definition." >>>;
public class Instrument 
{

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
