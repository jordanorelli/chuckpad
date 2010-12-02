<<< "Defining OptionPage class." >>>;
public class OptionPage
{
	false => int inFocus;

	fun void focus()
	{
		<<< "OptionPage", me, "focus!" >>>;
	}

	fun void unFocus()
	{
		<<< "OptionPage", me, "unfocus :-(" >>>;
	}

	fun string getName()
	{
		return "OptionPage_Base";
	}

	fun void receive(MidiMsg m)
	{
		<<< "OptionPage", me, " hears ", m.data1, m.data2, m.data3 >>>;
	}
}
<<< "Finished OptionPage definition." >>>;
