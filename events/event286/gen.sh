lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 12.53741741741742 --fixed-mass2 66.82986986986987 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1016137745.9492803 \
--gps-end-time 1016144945.9492803 \
--d-distr volume \
--min-distance 2387.09549044806e3 --max-distance 2387.1154904480604e3 \
--l-distr fixed --longitude -169.95394897460938 --latitude -30.492372512817383 --i-distr uniform \
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
