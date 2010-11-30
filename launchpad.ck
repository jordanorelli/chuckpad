<<< "Defining class Launchpad." >>>;
public class Launchpad
{
	MidiIn padIn;
	MidiOut padOut;
	-1 => int selected;
	int midiChannel;
	LPI @ rack[8];

	fun void setChannel(int value)
	{
		<<< "Setting Launchpad midi channel to ", value >>>;
		value => midiChannel;

		if(!padIn.open(midiChannel))
			me.exit();
		if(!padOut.open(midiChannel))
			me.exit();

		for(0 => int i; i < rack.size(); i++)
			if(rack[i] != null)
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
		<<< "Launchpad addInstrument\t", instrumentId, "\t", index >>>;
		LPI @ instrument;

		if(instrumentId == "")
			return;
		else if(instrumentId == "touchpad")
			new TouchPad @=> instrument;
		else if(instrumentId == "tonematrix")
			new ToneMatrix @=> instrument;
		else if(instrumentId == "optionmaster")
			new OptionMaster @=> instrument;
		else
		{
			<<< "ERROR: Attempt to add unrecognized LPI ", instrumentId,
			" to Launchpad ", me >>>;
			new LPI @=> instrument;
		}

		<<< "Adding", instrument.getName(), instrument, "to Launchpad", me, "in slot", index >>>;

		padOut @=> instrument.padOut;
		if(selected == index)
			true => instrument.inFocus;
		spork ~ instrument.start();
		instrument @=> rack[index];
	}

	fun void setSelected(int value)
	{
		if(value != selected && rack[value] != null)
		{
			<<< "SELECT", "Launchpad", me, midiChannel, value, rack[value].getName(),rack[value] >>>;
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
