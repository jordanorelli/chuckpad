public class Utils
{

	/*--------------------------------------------------------------------------
	setArray:  sets all elements of a given array to a particular value.
	--------------------------------------------------------------------------*/
	fun static int[] setArray(int target[], int value)
	{
		for(0 => int i; i < target.size(); i++)
			value @=> target[i];
	}

	fun static int[] setArray(int target[][], int value)
	{
		for(0 => int i; i < target.size(); i++)
			for(0 => int j; j < target[0].size(); j++)
				value => target[i][j];
	}

	fun static int[] setArray(int target[][][], int value)
	{
		for(0 => int i; i < target.size(); i++)
			for(0 => int j; j < target[0].size(); j++)
				for(0 => int k; k < target[0][0].size(); k++)
					value => target[i][j][k];
	}

	fun static int[] setArray(int target[][][][], int value)
	{
		for(0 => int i; i < target.size(); i++)
			for(0 => int j; j < target[0].size(); j++)
				for(0 => int k; k < target[0][0].size(); k++)
					for(0 => int l; l < target[0][0][0].size(); l++)
						value => target[i][j][k][l];
	}

}
