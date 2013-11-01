#include <complex>
#include <math_defines.h>

//the size of the spatial decompositions
#define	xSliceSize (5)
#define	ySliceSize (5)

//the size of the full image
#define xImageSize (2592)
#define yImageSize (1944)

#define xSlices (xImageSize / xSliceSize)
#define ySlices (yImageSize / ySliceSize)

//how many samples to keep
#define bufferSize (14)
#define frameRate (8)

#define amplitudeThreshold (15)
#define minimumHeartRate (60)
#define maximumHeartRate (130)
#define minimumBin (minimumHeartRate / 60 / frameRate * bufferSize)
#define maximumBin (maximumHeartRate / 60 / frameRate * bufferSize)

int main(int argc, char** argv)
{
	//the current frame in the wrapping buffer
	int frameIndex = 0;
	//wrapping buffer itself, initialized to all zeros
	long samples[xSlices][ySlices][bufferSize] = {};
	int freqs[xSlices][ySlices][bufferSize + 1] = {};

	//precompute the exponentials used in DFT
	complex coefficients[bufferSize] = {};
	for (int i = 0; i < bufferSize; ++i) {
        double a = -2.0 * PI * i  / double(bufferSize);
        coefficients[i] = complex(cos(a), sin(a));
    }
	
	while(true)
	{	
		for(int x = 0; x < xImageSize; x += xSliceSize)
		{
			for(int y = 0; y < yImageSize; y += ySliceSize)
			{
				//sum the red over a spatial block
				long total = 0;
				for(Row_Start = y; Row_Start < y + ySliceSize; Row_Start++)
				{
					for(Column_Start = x; Column_Start < x + xSliceSize; Column_Start++)
					{
						total += Red_Gain;
					}
				}
				
				//store the value
				long previous = samples[x / xSliceSize][y / ySliceSize][frameIndex];
				samples[x / xSliceSize][y / ySliceSize][frameIndex] = total;
				
				//compute the sliding DFT
				total -= previous;
				int ci = 0;
				for (int i = 0; i < bufferSize; i++) {
					freqs[i] += total * coefficients[x / xSliceSize][y / ySliceSize][ci];
					if ((ci += frameIndex) >= bufferSize)
						ci -= bufferSize;
				}
			}
		}
		
		int strongestFreq = 0;
		int strongestAmp = 0;
		for(int x = 0; x < xSlices; x++)
		{
			for(int y = 0; y < ySlices; y++)
			{
				for(int i = minimumBin; i < maximumBin + 1; i++)
				{
					int amplitude = freqs[x][y][i];
					if(amplitude > amplitudeThreshold && amplitude > strongestAmp)
					{
						strongestFreq = (float)i /(float) bufferSize * frameRate * 60;
						strongestAmp = amplitude;
					}
				}
			}
		}
		strongestFreq;//do whatever reporting we might want
		
		frameIndex = (frameIndex + 1) % bufferSize;
	} 
}