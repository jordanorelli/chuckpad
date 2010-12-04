<<< "Defining ToneMatrix OptionPage: Phrases" >>>;
public class Phrase extends OptionPage
{
	int velocities[8][8];

	<<< "FOO" >>>;
	for(0 => int i; i < velocities.size(); i++)
		for(0 => int j; j < velocities[0].size(); j++)
			0 => velocities[i][j];
	<<< "BAR" >>>;
	
	fun string getName()
	{
		return "Phrase";
	}
	
	
}
<<< "Finished Phrases definition." >>>;
