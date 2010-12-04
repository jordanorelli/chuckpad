<<< "Defining OptionPage class." >>>;
public class OptionPage
{
	false => int inFocus;

	fun void focus()
	{
		true => inFocus;
		<<< "OptionPage", me, "focus!" >>>;
	}

	fun void unfocus()
	{
		false => inFocus;
		<<< "OptionPage", me, "unfocus :-(" >>>;
	}

	fun string getName()
	{
		return "OptionPage_Base";
	}

	fun void receive(MidiMsg m)
	{
		<<< "OptionPage", me, " hears ", m.data1, m.data2, m.data3 >>>;
		OptionEvent snd;
		"OPTIONPAGE EVENT LOL" + me.id => snd.Poop;
		snd.signal();
	}
}
<<< "Finished OptionPage definition." >>>;
