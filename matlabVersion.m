%parameters
cameraFPS = 4;
framesInBuffer = 16;
blockWidth = 30;
blockHeight = 30;
sampleWidth = 8;
sampleHeight = 8;
minimumHeartRate = 60;
maximumHeartRate = 100;

%bins to look in
minimumBin = ceil(minimumHeartRate / 60 / cameraFPS * framesInBuffer);
maximumBin = floor(maximumHeartRate / 60 / cameraFPS * framesInBuffer);

% Load input video and figure length
inputVideo = VideoReader('Adam1.mov');
numFrames = get(inputVideo, 'NumberOfFrames');
frameRate = get(inputVideo, 'FrameRate');
frameOffset = uint8(frameRate / cameraFPS);

[M, N, ~] = size(read(inputVideo, 1));
samples = zeros(ceil(N/blockWidth-1), ceil(M/blockHeight-1), framesInBuffer);
frequencies = zeros(ceil(N/blockWidth-1), ceil(M/blockHeight-1), framesInBuffer);

for i = 1:frameOffset:framesInBuffer * frameOffset
    i
    frame = read(inputVideo, i);
    
    [M, N, ~] = size(frame);
    
    for x = 1:blockWidth:N-blockWidth
        for y = 1:blockHeight:M-blockHeight
            total = 0;
            for blockX = x:x+sampleWidth-1
                for blockY = y:y+sampleHeight-1
                    total = total + int32(frame(blockY, blockX, 1));
                end
            end
            
            samples(ceil(x/blockWidth), ceil(y/blockHeight), ceil(double(i)/double(frameOffset))) = total;
        end
    end
end

[M, N, ~] = size(samples);
    
    for x = 1:N
        for y = 1:M
            frequencies(y, x, :) = abs(fft(samples(y, x, :)));
        end
    end
    
    maxVal = max(max(max(frequencies(:, :, minimumBin:maximumBin))));
    bestIndices = find(frequencies(:, :, minimumBin:maximumBin) == maxVal) + (minimumBin - 1)*M*N;
    heartRate = ceil(bestIndices/(M*N)) / framesInBuffer * cameraFPS * 60;
    
    strcat(num2str(heartRate), ' beats per minute')