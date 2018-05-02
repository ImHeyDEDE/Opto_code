function StimManuel(t);
  if t>=1
    d2=daq.getDevices;
    s2=daq.createSession('ni');
    s2.Rate=2000;
    ai0=addAnalogInputChannel(s2,'Dev1','ai0','Voltage'); % Les 3 signaux EMG
    ai1=addAnalogInputChannel(s2,'Dev1','ai1','Voltage');
    ai2=addAnalogInputChannel(s2,'Dev1','ai2','Voltage');
    TrigOut=addAnalogInputChannel(s2,'Dev1','ai3','Voltage');
    SigTrig=addAnalogOutputChannel(s2,'Dev1','ao0','Voltage');
    RateAr=round(s2.Rate);
    pulsem=zeros(1,RateAr*2).'; % On multiplie par 2 pour avoir 2 seconds d'acquisition
    pulsem(RateAr*0.25:RateAr*2)=4;
    queueOutputData(s2,pulsem);
    %fid1 = fopen('log.bin','w');
    lp2 = addlistener(s2,'DataAvailable',@plotData);
    %ld2 = addlistener(s,'DataAvailable',@(src, event)logData(src, event, fid1));
    %s2.NotifyWhenDataAvailableExceeds = 2000; %s.Rate/s.Notify=freq de display
    s2.startBackground();
    s2.wait();
    delete(lp2);
    %delete(ld2);
  end
end