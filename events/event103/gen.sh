lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 22.37057057057057 --fixed-mass2 31.783503503503503 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1007459610.8799124 \
--gps-end-time 1007466810.8799124 \
--d-distr volume \
--min-distance 314.6426834256262e3 --max-distance 314.6626834256262e3 \
--l-distr fixed --longitude 76.31871032714844 --latitude -26.10582733154297 --i-distr uniform \
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
