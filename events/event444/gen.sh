lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 24.63975975975976 --fixed-mass2 26.152552552552553 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1015076154.3307668 \
--gps-end-time 1015083354.3307668 \
--d-distr volume \
--min-distance 1021.4375088249906e3 --max-distance 1021.4575088249906e3 \
--l-distr fixed --longitude 178.95359802246094 --latitude -25.27429962158203 --i-distr uniform \
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
