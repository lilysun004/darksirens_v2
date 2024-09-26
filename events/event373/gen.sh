lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 30.354754754754754 --fixed-mass2 68.51075075075076 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1014894476.6833795 \
--gps-end-time 1014901676.6833795 \
--d-distr volume \
--min-distance 2617.8953822758326e3 --max-distance 2617.915382275833e3 \
--l-distr fixed --longitude 138.81576538085938 --latitude 5.675955295562744 --i-distr uniform \
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
