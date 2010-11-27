MidiIn padIn;
MidiOut padOut;
MidiMsg msg;
1.059463094359295 => float toneStep;
240 => int bpm;
8 => int numRows;
8 => int numCols;
TriOsc tehNotes[8][8];



float toneMap[numRows][numCols];
110.0 => float lowestFreq;
8 => int rowStep;	// number of halfsteps between launchpad rows.
					// set to 8 for a chromatic layout.  Anything above
					// 8 and you'll miss notes.  Anything below and
					// notes will have multiple keys.

if(!padIn.open(0))
	me.exit();

if(!padOut.open(0))
	me.exit();


<<< "Set frequency matrix" >>>;
for (0 => int row; row < numRows; row++)
{
	for (0 => int column; column < numCols; column++)
	{

		lowestFreq * max(1, exp(toneStep, ((numRows - row - 1) * rowStep + column))) => float targetFreq;
		//<<< row, "\t", column, "\t", targetFreq>>>;
		targetFreq => tehNotes[row][column].freq;
		tehNotes[row][column] => dac;
		0 => tehNotes[row][column].gain;
	}
}
<<< "Done setting frequency matrix" >>>;

while(true)
{
	padIn => now;
	while(padIn.recv(msg))
	{
		<<< msg.data1, "\t", msg.data2, "\t", msg.data3, "\t", keyToFreq(msg.data2), "\t">>>;
		if(msg.data1 != 176) // If not in the "control row"
		{
			// 0,0 is the top left of the Launchpad's main 64 grid.
			msg.data2 % 16 => int column;
			msg.data2 / 16 => int row;
			if(column == 8) // If in the "control column"
			{
				// bounce(msg);
			}
			else
			{
				//<<< 8 * row + column >>>;
				if(msg.data3 == 127) // note on
				{
					bounce(msg);
					noteOn(row, column, tehNotes);
				}
				else // note off
				{
					bounce(msg);
					noteOff(row, column, tehNotes);
				}
			}
		}
	}
}

fun void printKey(int key)
{
	//<<< key >>>;
}

fun float keyToFreq(int key)
{
	key % 16 => int column;
	key / 16 => int row;
	//<<< "Column:\t", column, "\tRow:\t", row >>>;
	if (column == 8)
		return -1.0;
	else
		return lowestFreq * max(1, exp(toneStep, ((7 - row) * rowStep + column)));
}

fun int keyToNum(int key)
{
	key % 16 => int column;
	key / 16 => int row;
	if(column == 8)
		return -1;
	return (7 - row) * rowStep + column;
}

// converts a number to a frequency.  The number 0 corresponds to
// the lowest frequency as defined above with the global variable
// lowestFreq.  Each successive step multiplies the frequency by
// the global variable toneStep.
fun float numToFreq(int num)
{
	return lowestFreq * max(1, exp(toneStep, num));
}

fun void noteOn(int row, int column, TriOsc demNotes[][])
{
	if (row < demNotes.size() && column < demNotes[0].size())
	{
		0.8 => demNotes[row][column].gain;
		<<< "ON:\t", row, "\t", column, "\t" >>>;
	}
}

fun void noteOff(int row, int column, TriOsc demNotes[][])
{
	if (row < demNotes.size() && column < demNotes[0].size())
	{
		0 => demNotes[row][column].gain;
		<<< "OFF:\t", row, "\t", column, "\t" >>>;
	}
}

fun void bounce(MidiMsg msg)
{
	padOut.send(msg);
}

fun float max(float a, float b)
{
	if (a > b)
		return a;
	else
		return b;
}

// now this is truly awful.
fun float exp(float base, int power)
{
	base => float ret;
	if(power < 0)
		me.exit();
	else if(power == 0)
		return 1.0;
	else
	{
		while(power > 1)
		{
			ret * base => ret;	
			power - 1 => power;
		}
		return ret;
	}
}
