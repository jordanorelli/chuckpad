public class LPDriver
{
    MidiOut padOut;
	int lightStatus[9][9];

    127 => static int maxVelocity;

    fun void init(int midiChannel)
    {
		<<< "init\tdriver\t", padOut >>>;
        if(!padOut.open(midiChannel))
        {
            <<< "ERROR: couldn't open channel", midiChannel, "for MIDI out." >>>;
            me.exit();
        }
		Utils.setArray(lightStatus, -1);
    }

    fun void listen(Press press)
    {
        <<< "listen\tPress\tdriver\t", padOut >>>;
        while(true)
        {
            press => now;
            <<< "receive\tdriver\t", me, "\t", press.col, "\t", press.row, "\t", press.vel >>>;
			send(press);
        }
    }

	fun void send(Press press)
	{
		if(lightStatus[press.col][press.row] != press.vel)
		{
			press.vel => lightStatus[press.col][press.row];
			Press.toM(press) @=> MidiMsg m;
			reportSend(m, padOut);
			padOut.send(m);
		}
	}

	fun void send(int col, int row, int vel)
	{
		send(Press.make(col, row, vel));
	}

	fun void reportSend(MidiMsg m, MidiOut padOut)
	{
		<<< "send\tpad\t", padOut, "\t", m.data1, "\t", m.data2, "\t", m.data3, "\n\n\n\n" >>>;
	}
}
