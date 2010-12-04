<<< "Defining OptionPage class." >>>;
public class OptionPage
{
	false => int inFocus;

	fun void focus()
	{
		<<< getName(), me, "focus!" >>>;
	}

	fun void unFocus()
	{
		<<< getName(), me, "unfocus :-(" >>>;
	}

	fun string getName()
	{
		return "OptionPage_Base";
	}

	fun void receive(MidiMsg m)
	{
		<<< getName(), me, " hears ", m.data1, m.data2, m.data3 >>>;
	}
}
<<< "Finished OptionPage definition." >>>;
