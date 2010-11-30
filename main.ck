/*----------------------------------------------------------
-
- Configure these things to your liking.
-
----------------------------------------------------------*/

// starting tempo.
120 => int bpm;

// semitonesPerOctave defines the base tuning.  The standard
// western tuning is 12 semitones per octave, but you can
// change this as you see fit.
12 => int semitonesPerOctave;

// the Midi channels that correspond to your Launchpads.
// e.g. if you have three Launchpads on channels 1, 3, and
// 9, you would set this as follows:
// [1, 3, 9] @=> int launchpadChannels[];
[0] @=> int launchpadChannels[];

// don't touch this.
string instruments[launchpadChannels.size()][8];

// one array per Launchpad.  Arrays are 0 indexed, so remember
// that if you're going off the previous example of having
// three Launchpads on channels 1, 3, and 9, you would use
// 0 to reference the Launchpad on channel 1, 1 to reference
// the Launchpad on channel 3, and 2 to reference the Launchpad
// on channel 9.
["touchpad", "tonematrix", "", "", "", "", "", "optionmaster"] @=> instruments[0];

/*----------------------------------------------------------
-
- Don't touch the rest.
-
----------------------------------------------------------*/
Math.pow(2, 1.0/semitonesPerOctave) => float toneStep;
<<< "Defining launchpadCollection..." >>>;
Launchpad launchpadCollection[launchpadChannels.size()];
bpm => LPI.bpm;

for(0 => int i; i < launchpadChannels.size(); i++)
{
	<<< "Setting up Launchpad", i, "on MIDI channel", launchpadChannels[i] >>>;
	new Launchpad @=> launchpadCollection[i];
	launchpadCollection[i].setChannel(launchpadChannels[i]);
	for(0 => int j; j < instruments[i].size(); j++)
		launchpadCollection[i].addInstrument(instruments[i][j], j);
	spork ~ launchpadCollection[i].listen();
}

// Without this, ChucK will exit and kill all child shreds.
while(true)
{
	1::second => now;
}


