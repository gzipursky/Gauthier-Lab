imagePath = '/Users/benlau/Desktop/J100_2014-05-26_L01.tif';

timeTrace = [1,100]; %set time frame to analyze
meanOverTime = zeros(timeTrace(1,1),timeTrace(1,2)); %set up empty array to store the mean intensity values of some region

for i = timeTrace(1,1):timeTrace(1,2) %loop through every image in the time frame
    frame = double(imread(imagePath,i)); 

    figure(1);clf
    %imagesc(imOne) %open image

    pointOne = [19,100]; %set the upper left bound of a region
    pointTwo = [24,110]; %set the bottom right bound of a region 
    area = (pointTwo(1,2)-pointOne(1,2))*(pointTwo(1,1)-pointOne(1,1)); %compute area of region
   
    theSum = 0; %initialize a variable for the sum of pixel intensity in the region

    for y = pointOne(1,1):pointTwo(1,1) %loop through the height of the region
        for x = pointOne(1,2):pointTwo(1,2) %loop through the width of the region
            theSum = frame(y,x) + theSum; %add each pixel's intensity to a sum
        end
    end

    mean = theSum/area; %compute the mean intensity of the region
    meanOverTime(1,i) = mean; %add this value to the array storing all of the means over time
end

plot(meanOverTime) %generate plot for the mean vs time
xlabel('Time (ms)') %add x-axis label
ylabel('Intensity') %add y-axis label 
title('Single Neuron Firing over Time') %add title

saveas(gcf,'neuronfiringovertime.pdf') %save figure as pdf
startTime = timeTrace(1,1); %time trace
endTime = timeTrace(1,2);
xPointOne = pointOne(1,2); %some analysis parameters
yPointOne = pointOne(1,1);
xPointTwo = pointTwo(1,2);
yPointTwo = pointTwo(1,1);
save('timetrace.mat','A','B','C') %save time trace and analysis parameters in matlab file