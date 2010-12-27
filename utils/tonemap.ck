public class ToneMap
{
	fun static float[][] calculate(int width, int height, int columnStep, int rowStep, float baseFreq, float octaveSteps)
	{
		float tones[width][height];
		Math.pow(2, 1.0/octaveSteps) => float toneStep;
		for(0 => int row; row < height; row++)
		{
			baseFreq * Math.pow(toneStep, row * rowStep) => float rowBase;
			for(0 => int col; col < width; col++)
				rowBase * Math.pow(toneStep, col * columnStep) => tones[col][row];
		}
		return tones;
	}


}
