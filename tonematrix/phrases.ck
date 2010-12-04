<<< "Defining ToneMatrix OptionPage: Phrases" >>>;
public class Phrase extends OptionPage
{
	int velocities[8][8];

	for(0 => int i; i < velocities.size(); i++)
		for(0 => int j; j < velocities[0].size(); j++)
			0 => velocities[i][j];
	
	fun void receive(MidiMsg m)
	{
		<<< "Phrase heard MidiMsg", m.data1, m.data2, m.data3 >>>;
	}
	fun string getName()
	{
		return "Phrase";
	}

	fun int[][] getVelocities()
	{
		return velocities;
	}

	fun void setVelocities(int value[][])
	{
		value @=> velocities;
	}

	fun void setVelocity(int row, int column, int velocity)
	{
		velocity => velocities[row][column];
	}
}
<<< "Finished Phrases definition." >>>;
