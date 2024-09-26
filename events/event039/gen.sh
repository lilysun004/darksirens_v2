lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 18.084324324324324 --fixed-mass2 21.950350350350348 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1014947091.4375035 \
--gps-end-time 1014954291.4375035 \
--d-distr volume \
--min-distance 1270.2184778347594e3 --max-distance 1270.2384778347594e3 \
--l-distr fixed --longitude 32.15902328491211 --latitude 29.14012908935547 --i-distr uniform \
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
