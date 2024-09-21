lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 31.783503503503503 --fixed-mass2 15.563003003003004 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1000378240.9261823 \
--gps-end-time 1000385440.9261823 \
--d-distr volume \
--min-distance 356.81108642066044e3 --max-distance 356.8310864206604e3 \
--l-distr fixed --longitude 176.28436279296875 --latitude 29.14044952392578 --i-distr uniform \
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
