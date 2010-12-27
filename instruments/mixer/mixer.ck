public class Mixer extends Instrument
{
	"mixer" => name;

	fun void init()
	{
		for(0 => int i; i < modes.size(); i++)
		{
			new Columns @=> modes[i];
			spork ~ device.listen(modes[i].press);
		}
		me.yield();
	}
}
