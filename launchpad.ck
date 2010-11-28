<<< "Defining class Launchpad." >>>;
public class Launchpad
{
	MidiIn padIn;
	MidiOut padOut;
	-1 => int selected;
	int midiChannel;
	LPI rack[8];

	fun void setChannel(int value)
	{
		<<< "Setting Launchpad midi channel to ", value >>>;
		value => midiChannel;

		if(!padIn.open(midiChannel))
			me.exit();
		if(!padOut.open(midiChannel))
			me.exit();

		for(0 => int i; i < rack.size(); i++)
			padOut @=> rack[i].padOut;
	}

	fun void listen()
	{
		clearSelection();
		setSelected(0);
		rack[0].clearGrid();
		<<< "Launchpad ", me, " listening..." >>>;
		MidiMsg msg;
		while(true)
		{
			padIn => now;
			while(padIn.recv(msg))
			{
				if(msg.data1 != 176)
				{
					rack[selected].receive(msg);
				}
				else if (msg.data3 == 127)
				{
					setSelected(Math.abs(104 - msg.data2));
				}
			}
		}
	}

	fun void addInstrument(string instrumentId, int index)
	{
		LPI instrument;
		if(instrumentId == "touchpad")
			new TouchPad @=> instrument;
		else if(instrumentId == "tonematrix")
			new ToneMatrix @=> instrument;
		else
			<<< "ERROR: Attempt to add unrecognized LPI ", instrumentId,
			" to Launchpad ", me >>>;

		padOut @=> instrument.padOut;
		if(selected == index)
			true => instrument.inFocus;
		spork ~ instrument.start();
		instrument @=> rack[index];
	}

	fun void setSelected(int value)
	{
		if(value != selected)
		{
			<<< "SELECT", "Launchpad", midiChannel, "slot", value, rack[value].getName(),rack[value] >>>;
			MidiMsg m;
			176 => m.data1;
			104 + selected => m.data2;
			0 => m.data3;
			padOut.send(m);

			if(selected != -1)
				rack[selected].unFocus();
			value => selected;
			rack[selected].focus();

			104 + selected => m.data2;
			127 => m.data3;
			padOut.send(m);
		}
	}

	fun void clearSelection()
	{
		MidiMsg m;
		176 => m.data1;
		0 => m.data3;
		for(104 => int i; i < 112; i++)
		{
			i => m.data2;
			padOut.send(m);
		}
	}

}
<<< "Done with Launchpad class definition." >>>;
