#define _USE_MATH_DEFINES
#include <math.h>

#define PI	M_PI	/* pi to machine precision, defined in math.h */
#define TWOPI	(2.0*PI)

//how many data points to FFT
#define bufferSize (14)

//the size of the full image
#define xImageSize (2592)
#define yImageSize (1944)

//the size of the spatial decompositions
#define	xSliceSize (5)
#define	ySliceSize (5)

//number of slices
#define xSlices (xImageSize / xSliceSize)
#define ySlices (yImageSize / ySliceSize)

//TODO: figure the proper way to assign memory locations in order to get typing and everything
//memory mapped IO locations
#define cameraIO (0xDEADBEEF)
#define serialIO (0xDEADBEEF)

#define frameRate 8

#define amplitudeThreshold (15)
#define minimumHeartRate (60)
#define maximumHeartRate (130)
#define minimumBin ((int)((float)minimumHeartRate / 60 / frameRate * bufferSize + .5))
#define maximumBin ((int)(float)maximumHeartRate / 60 / frameRate * bufferSize)

/*
 this function four1 from http://www-ee.uta.edu/eeweb/ip/Courses/DSP_new/Programs/fft.cpp
 FFT/IFFT routine. (see pages 507-508 of Numerical Recipes in C)

 Inputs:
	data[] : array of complex* data points of size 2*NFFT+1.
		data[0] is unused,
		* the n'th complex number x(n), for 0 <= n <= length(x)-1, is stored as:
			data[2*n+1] = real(x(n))
			data[2*n+2] = imag(x(n))
		if length(Nx) < NFFT, the remainder of the array must be padded with zeros

	nn : FFT order NFFT. This MUST be a power of 2 and >= length(x).
	isign:  if set to 1, 
				computes the forward FFT
			if set to -1, 
				computes Inverse FFT - in this case the output values have
				to be manually normalized by multiplying with 1/NFFT.
 Outputs:
	data[] : The FFT or IFFT results are stored in data, overwriting the input.
*/

void four1(double data[], int nn, int isign)
{
    int n, mmax, m, j, istep, i;
    double wtemp, wr, wpr, wpi, wi, theta;
    double tempr, tempi;
    
    n = nn << 1;
    j = 1;
    for (i = 1; i < n; i += 2) {
	if (j > i) {
	    tempr = data[j];     data[j] = data[i];     data[i] = tempr;
	    tempr = data[j+1]; data[j+1] = data[i+1]; data[i+1] = tempr;
	}
	m = n >> 1;
	while (m >= 2 && j > m) {
	    j -= m;
	    m >>= 1;
	}
	j += m;
    }
    mmax = 2;
    while (n > mmax) {
	istep = 2*mmax;
	theta = TWOPI/(isign*mmax);
	wtemp = sin(0.5*theta);
	wpr = -2.0*wtemp*wtemp;
	wpi = sin(theta);
	wr = 1.0;
	wi = 0.0;
	for (m = 1; m < mmax; m += 2) {
	    for (i = m; i <= n; i += istep) {
		j =i + mmax;
		tempr = wr*data[j]   - wi*data[j+1];
		tempi = wr*data[j+1] + wi*data[j];
		data[j]   = data[i]   - tempr;
		data[j+1] = data[i+1] - tempi;
		data[i] += tempr;
		data[i+1] += tempi;
	    }
	    wr = (wtemp = wr)*wpr - wi*wpi + wr;
	    wi = wi*wpr + wtemp*wpi + wi;
	}
	mmax = istep;
    }
}

int readCoordinates(int x, int y)
{
	return cameraIO[y * xImageSize + x];
}

int main(int argc, char** argv)
{
	double samples[xSlices][ySlices][bufferSize];

	int NFFT = 2;
	while(NFFT < bufferSize)
	{
		NFFT *= 2;
	}

	//run forever
	while(true)
	{
		//load in bufferSize data points
		for(int frameIndex = 0; frameIndex < bufferSize; frameIndex++)
		{
			//TODO: synch with frames properly
			
			//iterate through all parts of the images
			for(int x = 0; x < xImageSize; x += xSliceSize)
			{
				for(int y = 0; y < yImageSize; y += ySliceSize)
				{
					//sum the intensity over a spatial block
					long total = 0;
					for(int blockY = y; blockY < y + ySliceSize; blockY++)
					{
						for(int blockX = x; blockX < x + xSliceSize; blockX++)
						{
							total += readCoordinates(blockX, blockY);
						}
					}
					
					samples[x/xSliceSize][y/ySliceSize][frameIndex] = total;
				}
			}
		}
		
		int strongestFreq = 0;
		double strongestAmp = 0;
		for(int x = 0; x < xSlices; x++)
		{
			for(int y = 0; y < ySlices; y++)
			{
				four1(samples[x][y], NFFT, 1);
				
				for(int i = minimumBin; i <= maximumBin; i++)
				{
					double current = samples[x][y][i];
					if(current > amplitudeThreshold && current > strongestAmp)
					{
						strongestAmp = current;
						strongestFreq = (double)i / bufferSize * frameRate * 60;
					}
				}
			}
		}
		
		*serialIO = strongestFreq;
	}
}