lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 48.84444444444445 --fixed-mass2 73.97361361361362 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1013946108.5846019 \
--gps-end-time 1013953308.5846019 \
--d-distr volume \
--min-distance 4560.433804639619e3 --max-distance 4560.453804639619e3 \
--l-distr fixed --longitude 96.36572265625 --latitude -48.914794921875 --i-distr uniform \
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
