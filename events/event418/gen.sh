lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 9.848008008008009 --fixed-mass2 76.07471471471472 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1020076106.1898326 \
--gps-end-time 1020083306.1898326 \
--d-distr volume \
--min-distance 1085.2194174988965e3 --max-distance 1085.2394174988965e3 \
--l-distr fixed --longitude -140.3954620361328 --latitude 22.641578674316406 --i-distr uniform \
--f-lower 20 --disable-spin \
--waveform SEOBNRv4_ROM

bayestar-sample-model-psd \
-o psd.xml \
--H1=aLIGOZeroDetHighPower \
--L1=aLIGOZeroDetHighPower \
--V1=AdvVirgo

bayestar-realize-coincs \
-o coinc.xml \
inj.xml --reference-psd psd.xml \
--detector H1 L1 V1 \
--measurement-error gaussian-noise \
--snr-threshold 4.0 \
--net-snr-threshold 12.0 \
--min-triggers 2 \
--keep-subthreshold

bayestar-localize-coincs coinc.xml
