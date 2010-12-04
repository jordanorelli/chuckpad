<<< "Defining ToneMatrix OptionPage: Phrases" >>>;
public class Phrase extends OptionPage
{
	int velocities[8][8];

	for(0 => int i; 0 < velocities.size(); i++)
		for(0 => int j; 0 < velocities[0].size(); j++)
			0 => velocities[i][j];
	
	fun string getName()
	{
		return "Phrase";
	}
	
	
}
<<< "Finished Phrases definition." >>>;
