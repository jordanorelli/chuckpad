<<< "Defining class Launchpad." >>>;
public class Rack
{
	LaunchpadController @ device;
	MidiIn padIn;
	Press press;
	
	Instrument @ rack[8];

	// 0.15::second => static dur peekTime;
	// time peekStart;
	//8 => static int gridRows;
	//8 => static int gridCols;

	//int lastLPI;
	//MidiIn padIn;

	//int selected;
	//LPI @ rack[8];

	<<< "Launchpad Preconstructor Start." >>>;
	//setSelected(0);
	<<< "Launchpad Preconstructor End." >>>;

	fun void init(int midiChannel)
	{
		if(!padIn.open(midiChannel))
		{
			<<< "ERROR: couldn't open channel", midiChannel, "for MIDI in." >>>;
			me.exit();
		}
		new LaunchpadController @=> device;
		spork ~ midiHandler(padIn);
		spork ~ device.listen(press);
		me.yield();
		device.init(0);
	}

	fun void midiHandler(MidiIn midiIn)
	{
		<<< "MidiHandler listening..." >>>;
		MidiMsg m;
		while(true)
		{
			midiIn => now;
			while(midiIn.recv(m))
			{
				Press.fromM(m) @=> Press msgOut;
				msgOut.col => press.col;
				msgOut.row => press.row;
				msgOut.vel => press.vel;
				<<< "receive\track\t", me, "\t", m.data1, "\t", m.data2, "\t", m.data3 >>>;
				<<< "signal\track\t", me, "\t", press.col, "\t", press.row, "\t", press.vel >>>;
				press.signal();
				me.yield();
			}
		}
	}

//	fun void setChannel(int value)
//	{
//		if(!padIn.open(value))
//			me.exit();
//
//		new LaunchpadController @=> device;
//		device.setChannel(value);
//
//		/*
//		for(0 => int i; i < rack.size(); i++)
//			if(rack[i] != null)
//				padOut @=> rack[i].padOut;
//				*/
//	}
//
//	fun void listen()
//	{
//		rack[0].clearGrid();
//		<<< "Launchpad ", me, " listening..." >>>;
//		MidiMsg msg;
//		while(true)
//		{
//			padIn => now;
//			while(padIn.recv(msg))
//			{
//				if(msg.data1 != 176)
//				{
//					rack[selected].receive(msg);
//				}
//				else if (msg.data3 == 127)
//				{
//					// control row button press
//					selected => lastLPI;
//					now => peekStart;
//					setSelected(Math.abs(104 - msg.data2));
//				}
//				else if (msg.data3 == 0)
//				{
//					if(now - peekStart > peekTime)
//						setSelected(lastLPI);
//					// this is an implied control row button release.
//					// risks of a false positive here.
//				}
//				else
//					<<< "ERROR: dropped Launchpad Midi message:", me, msg.data1, msg.data2, msg.data3 >>>;
//			}
//		}
//	}
//
//	fun void addInstrument(string instrumentId, int index)
//	{
//		<<< "Launchpad addInstrument\t", instrumentId, "\t", index >>>;
//		LPI @ instrument;
//
//		if(instrumentId == "")
//			return;
//		else if(instrumentId == "touchpad")
//			new TouchPad @=> instrument;
//		else if(instrumentId == "tonematrix")
//			new ToneMatrix @=> instrument;
//		else if(instrumentId == "optionmaster")
//			new OptionMaster @=> instrument;
//		else
//		{
//			<<< "ERROR: Attempt to add unrecognized LPI ", instrumentId,
//			" to Launchpad ", me >>>;
//			new LPI @=> instrument;
//		}
//
//		<<< "Adding", instrument.getName(), instrument, "to Launchpad", me, "in slot", index >>>;
//
//		padOut @=> instrument.padOut;
//		if(selected == index)
//			true => instrument.inFocus;
//		spork ~ instrument.start();
//		instrument @=> rack[index];
//	}
//
//	fun void setSelected(int value)
//	{
//		if(rack[value] != null)
//		{
//			<<< "SELECT", "Launchpad", me, midiChannel, value, rack[value].getName(),rack[value] >>>;
//			MidiMsg m;
//			176 => m.data1;
//			104 + selected => m.data2;
//			0 => m.data3;
//			padOut.send(m);
//
//			if(selected != -1)
//				rack[selected].unFocus();
//			value => selected;
//
//			rack[selected].focus();
//
//			104 + selected => m.data2;
//			127 => m.data3;
//			padOut.send(m);
//		}
//		else
//			<<< "ERROR:  tried to select null LPI in setSelected.  Input:", value >>>;
//	}
//
//	fun void clearSelection()
//	{
//		MidiMsg m;
//		176 => m.data1;
//		0 => m.data3;
//		for(104 => int i; i < 112; i++)
//		{
//			i => m.data2;
//			padOut.send(m);
//		}
//	}

}
<<< "Done with Launchpad class definition." >>>;
