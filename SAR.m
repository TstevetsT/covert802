M = 4;                      % Size of signal constellation
Mc = 16;                      % Size of signal constellation
k = log2(M);                % Number of bits per symbol
kc = log2(Mc);                % Number of bits per symbol
n = 3000;                  % Number of bits to process
numSamplesPerSymbol = 1;    % Oversampling factor
rng default                 % Use default random number generator
dataIn = randi([0 1],n,1);  % Generate vector of binary data
dataInc = randi([0 1],n,1);  % Generate vector of binary data
%stem(dataIn(1:40),'filled');
%title('Random Bits');
%xlabel('Bit Index');
%ylabel('Binary Value');
dataInMatrix = reshape(dataIn,length(dataIn)/2,2)   % Reshape data into binary 4-tuples
dataInMatrixc = reshape(dataInc,length(dataInc)/4,4)   % Reshape data into binary 4-tuples
dataSymbolsIn = bi2de(dataInMatrix)                 % Convert to integers
dataSymbolsInc = bi2de(dataInMatrixc)                 % Convert to integers
%figure; % Create new figure window.
%stem(dataSymbolsIn(1:10));
%title('Random Symbols');
%xlabel('Symbol Index');
%ylabel('Integer Value');
dataMod = qammod(dataSymbolsIn,M,0,'gray');  % Gray coding, phase offset = 0
dataModc = qammod(dataSymbolsInc,Mc,0,'gray'); % Gray coding, phase offset = 0
%for i=1:length(dataModc)
 %   if dataModc(i) == -1.0000 - 1.0000i
  %      dataModc(i)=.5+.5i;
   % elseif dataModc(i) == 1.0000 + 1.0000i
    %    dataModc(i)=1.5+1.5i;
 %   elseif dataModc(i) == 1.0000 - 1.0000i
  %      dataModc(i)=1.5+.5i;
   % else dataModc(i)=.5+1.5i;
    %end
%end       
EbNo = 10;
snr = EbNo + 10*log10(k) - 10*log10(numSamplesPerSymbol);
receivedSignal = awgn(dataMod,snr,'measured');
receivedSignalc = awgn(dataModc,snr,'measured');
sPlotFig = scatterplot(receivedSignalc,1,0,'g.');
%sPlotFig = scatterplot(dataModc,1,0,'g.');
hold on
scatterplot(dataMod,1,0,'k*',sPlotFig)