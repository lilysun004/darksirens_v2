lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 31.11115115115115 --fixed-mass2 53.550910910910915 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1003149731.3955601 \
--gps-end-time 1003156931.3955601 \
--d-distr volume \
--min-distance 1992.5418925742417e3 --max-distance 1992.5618925742417e3 \
--l-distr fixed --longitude -125.26921081542969 --latitude 73.34568786621094 --i-distr uniform \
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
