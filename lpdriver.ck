<<< "BEGIN\tLPDriver definition.", "" >>>;
public class LPDriver
{
    MidiOut padOut;
    int gridLights[8][8];
    int instrumentLights[8];
    int modeLights[8];

    127 => static int maxVelocity;

    fun void init(int midiChannel)
    {
        if(!padOut.open(midiChannel))
        {
            <<< "ERROR: couldn't open channel", midiChannel, "for MIDI out." >>>;
            me.exit();
        }
    }

    fun void listen(Press press)
    {
        <<< "LPDriver listening..." >>>;
        while(true)
        {
            press => now;
            <<< "receive\tlpc\t", me, "\t", press.row, "\t", press.col, "\t", press.vel >>>;
			send(press, padOut);
        }
    }

	fun void send(Press press, MidiOut padOut)
	{
		Press.toM(press) @=> MidiMsg m;
		reportSend(m);
		padOut.send(m);
	}

	fun void send(int col, int row, int vel, MidiOut padOut)
	{
		Press.toM(col, row, vel) @=> MidiMsg m;
		reportSend(m);
		padOut.send(m);
	}

	fun void reportSend(MidiMsg m)
	{
		<<< "send\tpad\t", padOut, "\t", m.data1, "\t", m.data2, "\t", m.data3, "\n" >>>;
	}
}
<<< "END\tLPDriver definition.", "" >>>;
